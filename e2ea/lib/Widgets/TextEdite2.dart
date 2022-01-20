import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class TextEdite extends StatefulWidget {
  TextEdite(
      {@required this.text,
      @required this.name_of_changing,
      @required this.font_size,
      this.callBackText});
  String text;
  String name_of_changing;
  bool _change = false;
  double font_size = 20;
  TextEditingController _controller;
  Function(Object) callBackText;
  @override
  _TextEditeState createState() => _TextEditeState();
}

class _TextEditeState extends State<TextEdite> {
  // _showMaterialDialog(BuildContext ctx) {
  //   return showDialog(
  //       context: ctx,
  //       builder: (ctx) => AlertDialog(
  //             title: Text("Medicine Image"),
  //             content: Text("Please choose one "),
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: Text('Files'),
  //                 onPressed: () {
  //                   Navigator.of(ctx).pop();
  //                 },
  //               ),
  //               FlatButton(
  //                 child: Text('Camera'),
  //                 onPressed: () {
  //                   Navigator.of(ctx).pop();
  //                 },
  //               )
  //             ],
  //           ));
  // }

  @override
  Widget build(BuildContext ctx) {
    if (widget._change) {
      widget._controller = TextEditingController(text: widget.text);
      return AlertDialog(
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('back')),
        ],
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
      child: SelectableText(
        widget.text,
        style: TextStyle(color: Colors.black, fontSize: widget.font_size),
      ),
    );
  }
}
