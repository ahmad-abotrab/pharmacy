import 'package:flutter/material.dart';

class FieldAdding extends StatelessWidget {
  const FieldAdding({
    Key key,
    this.iconData,
    this.press,
    this.hintText,
    @required this.textEditingControllerList,
  }) : super(key: key);

  final TextEditingController textEditingControllerList;
  final IconData iconData;
  final Function press;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: TextFormField(
        controller: textEditingControllerList,
        // textAlign: TextAlign.end,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: IconButton(
            onPressed: press,
            icon: Icon(iconData),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
