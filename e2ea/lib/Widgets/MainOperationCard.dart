import 'package:flutter/material.dart';

import 'dart:ui' as ui;

class MainOpCard extends StatelessWidget {
  const MainOpCard({
    Key key,
    this.data,
    this.color,
    this.index,
    this.pressInformation,
    this.press,
    this.mediaQueryData,
    this.textGridView,
  }) : super(key: key);

  final List color;
  final List<Map<String, String>> data;
  final int index;
  final Function pressInformation;
  final Function press;
  final MediaQueryData mediaQueryData;
  final String textGridView;
  static const Color green = Color.fromRGBO(239, 252, 226, 1.0);

  @override
  Widget build(BuildContext context) {
    String contentOfMainBox;
    contentOfMainBox = data[index]
        .keys
        .toString()
        .substring(1, data[index].keys.toString().length - 1)
        .trim();

    return GestureDetector(
      onTap: press,
      child: Container(
       
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        margin:
            EdgeInsets.symmetric(horizontal: mediaQueryData.size.width * 0.002),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            // color: Color(0xFFB0BCC5).withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: green, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              color: Colors.white,
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.black,
                              ),
                              onPressed: pressInformation,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mediaQueryData.size.height * 0.05,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: FittedBox(
                            child: Text(
                              contentOfMainBox,
                              textAlign: TextAlign.center,
                              textDirection: ui.TextDirection.rtl,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                //fontFamily: 'DancingScript',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
