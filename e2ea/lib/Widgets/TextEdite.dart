// ignore_for_file: deprecated_member_use, non_constant_identifier_names, unused_element

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class TextEdite extends StatefulWidget {
  TextEdite({
    @required this.text,
    @required this.name_of_changing,
    @required this.font_size,
    this.callBackText,
    // this.callBackSave
  });
  String text;
  String name_of_changing;
  bool _change = false;
  //bool save = false;
  double font_size = 20;
  TextEditingController _controller;
  Function(Object) callBackText;
  // Function(Object) callBackSave;
  @override
  _TextEditeState createState() => _TextEditeState();
}

class _TextEditeState extends State<TextEdite> {
  @override
  Widget build(BuildContext ctx) {
    if (widget._change) {
      widget._controller = TextEditingController(text: widget.text);
      return AlertDialog(
        title: Text(
            'Changing' + ' ' + widget.name_of_changing + ' ' + 'Information'),
        titleTextStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        elevation: 30,
        content: TextField(
          maxLines: null,
          textInputAction: TextInputAction.done,
          onSubmitted: (newvalue) {
            setState(() {
              widget.text = newvalue;
              widget.callBackText?.call(widget.text);
              //widget.save = true;
              //widget.callBackSave?.call(widget.save);
              widget._change = false;
            });
          },
          enableSuggestions: true,
          autofocus: true,
          controller: widget._controller..text = widget.text,
        ),
      );
    }
    return InkWell(
        onDoubleTap: () {
          setState(() {
            widget._change = true;
          });
        },
        child: widget.text != null
            ? Text(widget.text,
                style:
                    TextStyle(color: Colors.black, fontSize: widget.font_size))
            : Text(
                "widget.text",
              ));
  }
}
