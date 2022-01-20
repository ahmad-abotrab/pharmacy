import 'package:flutter/material.dart';

class DropdownHours extends StatefulWidget {
  final String hiddinText;
  const DropdownHours({
    Key key,
    this.hiddinText,
  }) : super(key: key);

  @override
  _DropdownHoursState createState() => _DropdownHoursState();
}

class _DropdownHoursState extends State<DropdownHours> {
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 3, left: 3),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButton(
          hint: Padding(
            padding: EdgeInsets.only(left: 3, right: 3),
            child: Text(
              widget.hiddinText,
              style: TextStyle(color: Colors.black),
            ),
          ),
          dropdownColor: Colors.white,
          elevation: 0,
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 30,
          onChanged: (newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: buildList().map(
            (valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

// ignore: missing_return
buildList() {
  List list = [];
  int counter = 0;
  for (int i = 1; i <= 10; i++) {
    if (counter == 3) return list;
    if (i == 10) {
      i = 0;
      counter++;
    }
    if (counter == 0) {
      list.add(i.toString());
    } else {
      list.add(counter.toString() + (i).toString());
    }
  }
}
