import 'package:flutter/material.dart';

class TextFieldFrom extends StatelessWidget {
  final String hiddenText;
  final Icon prefixIcon;
  final double degreeOfedge;
  final TextEditingController textEditingController;
  final String validator;
  const TextFieldFrom({
    Key key,
    this.hiddenText,
    this.prefixIcon,
    this.degreeOfedge,
    this.textEditingController,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: (value) => value.isEmpty ? validator : null,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hiddenText,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(degreeOfedge),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
