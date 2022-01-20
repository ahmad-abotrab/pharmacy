// import 'package:flutter/material.dart';
// //0xFF067CBD
// class CardWidget extends StatefulWidget {
//   CardWidget({Key key}) : super(key: key);
//   Color color;
//   double radius;
//   double opacityMin;
//   double opacityMax;
//   Function press;
//   Function longPress;
//   bool ifActiveIncrement;
//   String image;
//   List<Widget> widgets;
//   bool buttonInformation;
//   MediaQueryData mediaQuery;
//   double circle;
//   @override
//   _CardWidgetState createState() => _CardWidgetState();
// }

// class _CardWidgetState extends State<CardWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.press,
//       child: Container(
//         decoration:
//             BoxDecoration(borderRadius: BorderRadius.circular(widget.circle)),
//         margin: EdgeInsets.symmetric(
//             horizontal: widget.mediaQuery.size.width * 0.002),
//         child: Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(widget.circle),
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       widget.color.withOpacity(widget.opacityMin),
//                       widget.color.withOpacity(widget.opacityMax),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(widget.circle)),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.all(3.0),
//                       child: Column(
//                         children: <Widget>[
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: <Widget>[
//                               IconButton(
//                                 color: Colors.white,
//                                 icon: Icon(
//                                   Icons.more_vert,
//                                   color: Colors.white,
//                                 ),
//                                 onPressed: pressInformation,
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: widget.mediaQuery.size.height * 0.05,
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             child: FittedBox(
//                               child: Text(
//                                 contentOfMainBox,
//                                 textAlign: TextAlign.center,
//                                 textDirection: ui.TextDirection.rtl,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 17,
//                                   //fontFamily: 'DancingScript',
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
