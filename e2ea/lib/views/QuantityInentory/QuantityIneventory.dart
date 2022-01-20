import 'dart:math';

import 'package:e2ea/localization/localizations_demo.dart';
import 'package:e2ea/newController/calculationsAndInventory/jard.dart';
import 'package:e2ea/newController/calculationsAndInventory/report.dart';
import 'package:flutter/material.dart';

class QuantityInentory extends StatefulWidget {
  QuantityInentory({Key key, this.mediaQueryData}) : super(key: key);
  final MediaQueryData mediaQueryData;

  bool daily = false, monthly = false, yearly = false;

  bool checkPresentTime = true;
  DateTime pickedDate = new DateTime(0, 0, 0, 0, 0, 0);
  TextEditingController dailyDate;

  DateTime firstDateMonthly = new DateTime(0, 0, 0, 0, 0, 0),
      secondDateMonthly = new DateTime(0, 0, 0, 0, 0, 0);
  String whatController;

  List<List<Object>> resultFinincalSearch = [];
  List<DataRow> rows = [];

  @override
  _QuantityInentoryState createState() => _QuantityInentoryState();
}

class _QuantityInentoryState extends State<QuantityInentory> {
  @override
  void initState() {
    widget.daily = false;
    widget.monthly = false;
    widget.yearly = false;
    widget.pickedDate = new DateTime.now();
    widget.dailyDate = new TextEditingController();
    widget.firstDateMonthly = new DateTime.now();
    widget.secondDateMonthly = new DateTime.now();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var Daily_Monthly_Yearly = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.5),
            Colors.blue.withOpacity(0.5),
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: widget.mediaQueryData.size.height * 0.05,
          ),
          MaterialButton(
              onPressed: () {
                setState(() {
                  widget.daily = false;
                  widget.monthly = false;
                  widget.yearly = false;
                  widget.checkPresentTime = false;
                  widget.pickedDate = DateTime.now();
                  widget.firstDateMonthly = DateTime.now();
                });
              },
              child:
                  Text('Quantity Ineventory', style: TextStyle(fontSize: 20))),
          Container(
            width: widget.mediaQueryData.size.width * 0.97,
            height: widget.mediaQueryData.size.height * 0.2,
            child: Container(
              margin: EdgeInsets.only(
                  left: widget.mediaQueryData.size.width * 0.001),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonToChoiceFillter(
                      mediaQueryData: widget.mediaQueryData,
                      color: Colors.green.withOpacity(0.5),
                      hintText:
                          DemoLocalizations.of(context).translate('daily'),
                      onPressed: () => setState(
                        () {
                          widget.daily = true;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: widget.mediaQueryData.size.width * 0.001),
                  Expanded(
                    child: ButtonToChoiceFillter(
                      mediaQueryData: widget.mediaQueryData,
                      color: Color(0xff2ac3ff),
                      hintText:
                          DemoLocalizations.of(context).translate('monthly'),
                      onPressed: () => setState(
                        () {
                          widget.monthly = true;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: widget.mediaQueryData.size.width * 0.0001),
                  Expanded(
                    child: ButtonToChoiceFillter(
                      mediaQueryData: widget.mediaQueryData,
                      color: Color(0xffff6968),
                      hintText:
                          DemoLocalizations.of(context).translate('yearly'),
                      onPressed: () => setState(
                        () {
                          widget.yearly = true;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    var finincalDaily = Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.5),
              Colors.blue.withOpacity(0.5),
            ],
          ),
        ),
        child: Column(children: [
          SizedBox(
            height: widget.mediaQueryData.size.height * 0.05,
          ),
          MaterialButton(
            onPressed: () {
              setState(() {
                widget.daily = false;
                widget.monthly = false;
                widget.yearly = false;
                widget.checkPresentTime = false;
                widget.pickedDate = DateTime.now();
                widget.firstDateMonthly = DateTime.now();
              });
            },
            child: Text('Quantity Ineventory', style: TextStyle(fontSize: 20)),
          ),
          Container(
            child: widget.checkPresentTime
                ? Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: widget.checkPresentTime,
                              onChanged: (value) {
                                setState(() {
                                  widget.checkPresentTime = value;
                                });
                              }),
                          Text('present Date')
                        ],
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black)),
                          child: MaterialButton(
                            onPressed: () async {
                              widget.resultFinincalSearch = await jard()
                                  .makeDayJard(
                                      widget.pickedDate.day,
                                      widget.pickedDate.month,
                                      widget.pickedDate.year);
                              print('length is  : ' +
                                  widget.resultFinincalSearch.length
                                      .toString());
                              for (int i = 0;
                                  i < widget.resultFinincalSearch.length;
                                  i++) {
                                print('length ' +
                                    '$i  ' +
                                    widget.resultFinincalSearch[i].length
                                        .toString());
                              }
                              setState(() {
                                widget.rows = rows();
                              });
                            },
                            child: Text('Get'),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    width: widget.mediaQueryData.size.width * 0.9,
                    height: widget.mediaQueryData.size.height * 0.24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.09),
                          blurRadius: 8,
                          spreadRadius: 3,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              choiceDateFirst(),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black)),
                              child: MaterialButton(
                                onPressed: () async {
                                  widget.firstDateMonthly != null
                                      ? widget.resultFinincalSearch =
                                          await jard().makeDayJard(
                                          widget.firstDateMonthly.day,
                                          widget.firstDateMonthly.month,
                                          widget.firstDateMonthly.year,
                                        )
                                      : widget.resultFinincalSearch =
                                          await jard().makeDayJard(
                                          DateTime.now().day,
                                          DateTime.now().month,
                                          DateTime.now().year,
                                        );
                                  print('length is  : ' +
                                      widget.resultFinincalSearch.length
                                          .toString());
                                  for (int i = 0;
                                      i < widget.resultFinincalSearch.length;
                                      i++) {
                                    print('length ' +
                                        '$i  ' +
                                        widget.resultFinincalSearch[i].length
                                            .toString());
                                  }
                                  setState(() {
                                    widget.rows = rows();
                                  });
                                },
                                child: Text('Get'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ]));

    ///here this varaible is finincal month
    var finincalMonthly = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.5),
            Colors.blue.withOpacity(0.5),
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: widget.mediaQueryData.size.height * 0.05,
          ),
          MaterialButton(
            onPressed: () {
              setState(() {
                widget.daily = false;
                widget.monthly = false;
                widget.yearly = false;
                widget.pickedDate = DateTime.now();
                widget.firstDateMonthly = DateTime.now();
              });
            },
            child: Text('Quantity Ineventory', style: TextStyle(fontSize: 20)),
          ),
          Container(
            width: widget.mediaQueryData.size.width * 0.9,
            height: widget.mediaQueryData.size.height * 0.24,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.09),
                  blurRadius: 8,
                  spreadRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      choiceDateFirst(),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      // margin: EdgeInsets.only(
                      //     bottom: widget.mediaQueryData.size.height * 0.12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black)),
                      child: MaterialButton(
                        onPressed: () async {
                          widget.firstDateMonthly == null
                              ? widget.resultFinincalSearch =
                                  await jard().makeMonthJard(
                                  DateTime.now().month,
                                  DateTime.now().year,
                                )
                              : widget.resultFinincalSearch =
                                  await jard().makeMonthJard(
                                  widget.firstDateMonthly.month,
                                  widget.firstDateMonthly.year,
                                );
                          print('length is  : ' +
                              widget.resultFinincalSearch.length.toString());
                          setState(() {
                            widget.rows = rows();
                          });
                        },
                        child: Text('Get'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    ///here this varaible is finincal year
    var finincalYearly = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.5),
            Colors.blue.withOpacity(0.5),
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: widget.mediaQueryData.size.height * 0.05,
          ),
          MaterialButton(
            onPressed: () {
              setState(() {
                widget.daily = false;
                widget.monthly = false;
                widget.yearly = false;
              });
            },
            child: Text('Quantity Ineventory', style: TextStyle(fontSize: 20)),
          ),
          Container(
            width: widget.mediaQueryData.size.width * 0.9,
            height: widget.mediaQueryData.size.height * 0.24,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.09),
                  blurRadius: 8,
                  spreadRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      choiceDateFirst(),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      // margin: EdgeInsets.only(
                      //     bottom: widget.mediaQueryData.size.height * 0.12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black)),
                      child: MaterialButton(
                        onPressed: () async {
                          widget.firstDateMonthly != null
                              ? widget.resultFinincalSearch = await jard()
                                  .makeYearJard(widget.firstDateMonthly.year)
                              : widget.resultFinincalSearch = await jard()
                                  .makeYearJard(DateTime.now().year);
                          print('length is  : ' +
                              widget.resultFinincalSearch.length.toString());
                          setState(() {
                            widget.rows = rows();
                          });
                        },
                        child: Text('Get'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    ///Here is my scaffold

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            widget.daily && !widget.monthly && !widget.yearly
                ? finincalDaily
                : !widget.daily && widget.monthly && !widget.yearly
                    ? finincalMonthly
                    : !widget.daily && !widget.monthly && widget.yearly
                        ? finincalYearly
                        : Daily_Monthly_Yearly,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.blueGrey.withOpacity(0.4),
                  Colors.blueGrey.withOpacity(0.9),
                ])),
                sortAscending: true,
                columns: [
                  DataColumn(label: Container(child: 
                  Text( DemoLocalizations.of(context).translate('medicinename')))),
                  DataColumn(label: 
                  Text( DemoLocalizations.of(context).translate('sold'))),
                  DataColumn(label:
                   Text( DemoLocalizations.of(context).translate('bought'))),
                  DataColumn(label: 
                  Text( DemoLocalizations.of(context).translate('left'))),
                ],
                rows: widget.rows == null ? [] : widget.rows,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> rows() {
    List<DataRow> rows = [];
    List<DataCell> cells = [];
    int length = widget.resultFinincalSearch[0] == null ||
            widget.resultFinincalSearch[0].length == 0
        ? 0
        : widget.resultFinincalSearch[0].length;

    for (int i = 0; i < length; i++) {
      cells = [];

      for (int j = 0; j < widget.resultFinincalSearch.length; j++) {
        cells.add(
          DataCell(
            Text(
              widget.resultFinincalSearch[j][i] == null
                  ? ""
                  : widget.resultFinincalSearch[j][i].toString(),
            ),
          ),
        );
      }
      rows.add(
        DataRow(
          cells: cells,
        ),
      );
    }

    return rows;
  }

  ///normal case chose one date
  Expanded choiceDate() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          top: widget.mediaQueryData.size.height * 0.04,
          bottom: widget.mediaQueryData.size.height * 0.05,
          right: widget.mediaQueryData.size.height * 0.01,
          left: widget.mediaQueryData.size.height * 0.01,
        ),
        //     bottom: widget.mediaQueryData.size.height * 0.06),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: FittedBox(
                child: Text(
                  widget.pickedDate == null
                      ? '${DateTime.now().year},${DateTime.now().month},${DateTime.now().day}'
                      : widget.pickedDate.year != null &&
                              widget.pickedDate.month != null &&
                              widget.pickedDate.day != null
                          ? '${widget.pickedDate.year},${widget.pickedDate.month},${widget.pickedDate.day}'
                          : widget.pickedDate.year == null &&
                                  widget.pickedDate.month != null &&
                                  widget.pickedDate.day != null
                              ? '${DateTime.now().year},${widget.pickedDate.month},${widget.pickedDate.day}'
                              : widget.pickedDate.year != null &&
                                      widget.pickedDate.month == null &&
                                      widget.pickedDate.day != null
                                  ? '${widget.pickedDate.year},${DateTime.now().month},${widget.pickedDate.day}'
                                  : widget.pickedDate.year != null &&
                                          widget.pickedDate.month != null &&
                                          widget.pickedDate.day == null
                                      ? '${widget.pickedDate.year},${widget.pickedDate.month},${DateTime.now().day}'
                                      : '${DateTime.now().year},${DateTime.now().month},${DateTime.now().day}',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () {
                pickDate();
              },
            ),
          ],
        ),
      ),
    );
  }

  pickDate() async {
    DateTime datetime = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime(DateTime.now().year + 75),
        initialDate: widget.pickedDate);

    setState(() {
      widget.pickedDate = datetime;
    });
  }

  //___________________________________________________________________________
//for first date
  Expanded choiceDateFirst() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          top: widget.mediaQueryData.size.height * 0.01,
          bottom: widget.mediaQueryData.size.height * 0.05,
          right: widget.mediaQueryData.size.height * 0.03,
          left: widget.mediaQueryData.size.height * 0.03,
        ),
        //     bottom: widget.mediaQueryData.size.height * 0.06),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: FittedBox(
                child: Text(
                  widget.firstDateMonthly == null
                      ? '${DateTime.now().year},${DateTime.now().month},${DateTime.now().day}'
                      : widget.firstDateMonthly.year != null &&
                              widget.firstDateMonthly.month != null &&
                              widget.firstDateMonthly.day != null
                          ? '${widget.firstDateMonthly.year},${widget.firstDateMonthly.month},${widget.firstDateMonthly.day}'
                          : widget.firstDateMonthly.year == null &&
                                  widget.firstDateMonthly.month != null &&
                                  widget.firstDateMonthly.day != null
                              ? '${DateTime.now().year},${widget.firstDateMonthly.month},${widget.firstDateMonthly.day}'
                              : widget.firstDateMonthly.year != null &&
                                      widget.firstDateMonthly.month == null &&
                                      widget.firstDateMonthly.day != null
                                  ? '${widget.firstDateMonthly.year},${DateTime.now().month},${widget.firstDateMonthly.day}'
                                  : widget.firstDateMonthly.year != null &&
                                          widget.firstDateMonthly.month !=
                                              null &&
                                          widget.firstDateMonthly.day == null
                                      ? '${widget.firstDateMonthly.year},${widget.firstDateMonthly.month},${DateTime.now().day}'
                                      : '${DateTime.now().year},${DateTime.now().month},${DateTime.now().day}',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () {
                // launch(
                pickDateFirst();

                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  pickDateFirst() async {
    DateTime datetime = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime(DateTime.now().year + 75),
        initialDate: widget.firstDateMonthly);

    setState(() {
      widget.firstDateMonthly = datetime;
    });
  }

  //___________________________________________________________________________
  ///For scond date
  Expanded choiceDateSecond() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          top: widget.mediaQueryData.size.height * 0.04,
          bottom: widget.mediaQueryData.size.height * 0.05,
          right: widget.mediaQueryData.size.height * 0.01,
          left: widget.mediaQueryData.size.height * 0.01,
        ),
        //     bottom: widget.mediaQueryData.size.height * 0.06),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: FittedBox(
                child: Text(
                  '${widget.secondDateMonthly.year},${widget.secondDateMonthly.month},${widget.secondDateMonthly.day}',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () {
                // launch(
                pickDateSecond();

                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  pickDateSecond() async {
    DateTime datetime = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime(DateTime.now().year + 75),
        initialDate: widget.secondDateMonthly);

    setState(() {
      widget.secondDateMonthly = datetime;
    });
  }
  //_________________________________________________________________
}

class ButtonToChoiceFillter extends StatelessWidget {
  const ButtonToChoiceFillter({
    Key key,
    @required this.mediaQueryData,
    @required this.color,
    @required this.hintText,
    @required this.onPressed,
  }) : super(key: key);

  final MediaQueryData mediaQueryData;
  final Color color;
  final String hintText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        height: mediaQueryData.size.height * 0.06,
        width: mediaQueryData.size.width * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black)),
        child: Center(child: Text(hintText, style: TextStyle())),
      ),
    );
  }
}
    // var finincalDaily = Container(
    //   width: widget.mediaQueryData.size.width * 0.97,
    //   height: widget.mediaQueryData.size.height * 0.24,
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(.09),
    //         blurRadius: 8,
    //         spreadRadius: 3,
    //       ),
    //     ],
    //     borderRadius: BorderRadius.circular(8),
    //   ),
    //   child: Container(
    //     child: widget.checkPresentTime
    //         ? Row(
    //             children: [
    //               Row(
    //                 children: [
    //                   Checkbox(
    //                       value: widget.checkPresentTime,
    //                       onChanged: (value) {
    //                         setState(() {
    //                           widget.checkPresentTime = value;
    //                         });
    //                       }),
    //                   Text('present Date')
    //                 ],
    //               ),
    //               Expanded(
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(8),
    //                       border: Border.all(color: Colors.black)),
    //                   child: MaterialButton(
    //                     onPressed: () async {
    //                       widget.resultFinincalSearch = await Reports()
    //                           .makeDayReport(
    //                               widget.pickedDate.day,
    //                               widget.pickedDate.month,
    //                               widget.pickedDate.year);
    //                     },
    //                     child: Text('Get'),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           )
    //         : Column(
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Row(
    //                     children: [
    //                       Checkbox(
    //                           value: widget.checkPresentTime,
    //                           onChanged: (value) {
    //                             setState(() {
    //                               widget.checkPresentTime = value;
    //                             });
    //                           }),
    //                       Text('present Date')
    //                     ],
    //                   ),
    //                   choiceDate(),
    //                 ],
    //               ),
    //               Expanded(
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(8),
    //                       border: Border.all(color: Colors.black)),
    //                   child: MaterialButton(
    //                     onPressed: () async {
    //                       widget.resultFinincalSearch = await Reports()
    //                           .makeDayReport(
    //                               widget.pickedDate.day,
    //                               widget.pickedDate.month,
    //                               widget.pickedDate.year);
    //                     },
    //                     child: Text('Get'),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //   ),
    // );