import 'package:e2ea/Widgets/BottomNavTab.dart';
import 'package:e2ea/localization/localizations_demo.dart';
import 'package:e2ea/newController/calculationsAndInventory/report.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FinincalReports extends StatefulWidget {
  FinincalReports({Key key, this.mediaQueryData}) : super(key: key);
  final MediaQueryData mediaQueryData;

  bool daily = false, monthly = false, yearly = false;

  bool checkPresentTime = true;
  DateTime pickedDate = new DateTime(0, 0, 0, 0, 0, 0);
  TextEditingController dailyDate;

  DateTime firstDateMonthly = new DateTime(0, 0, 0, 0, 0, 0),
      secondDateMonthly = new DateTime(0, 0, 0, 0, 0, 0);
  String whatController;

  List resultFinincalSearch = [];

  var profits = 0.0, losses = 0.0, totaleSell = 0.0, totallBuy = 0.0;

  @override
  _FinincalReportsState createState() => _FinincalReportsState();
}

class _FinincalReportsState extends State<FinincalReports> {
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
    var Daily_Monthly_Yearly = Positioned(
      top: widget.mediaQueryData.size.height * 0.25,
      right: widget.mediaQueryData.size.width * 0.015,
      child: Container(
        width: widget.mediaQueryData.size.width * 0.97,
        height: widget.mediaQueryData.size.height * 0.24,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.09),
              blurRadius: 8,
              spreadRadius: 3,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          margin:
              EdgeInsets.only(left: widget.mediaQueryData.size.width * 0.001),
          child: Row(
            children: [
              Expanded(
                child: ButtonToChoiceFillter(
                  mediaQueryData: widget.mediaQueryData,
                  color: Colors.green.withOpacity(0.5),
                  hintText: DemoLocalizations.of(context).translate('daily'),
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
                  hintText: DemoLocalizations.of(context).translate('monthly'),
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
                  hintText: DemoLocalizations.of(context).translate('yearly'),
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
      ),
    );
    var backGroundBoard = Column(
      children: [
        Container(
          child: Center(
            child: MaterialButton(
              onPressed: () => setState(() {
                widget.daily = false;
                widget.monthly = false;
                widget.yearly = false;
              }),
              child: Text(
                'Finical Reports Day',
                style: TextStyle(
                    fontSize: widget.mediaQueryData.size.width * 0.06),
              ),
            ),
          ),
          height: widget.mediaQueryData.size.height * 0.35,
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
        ),
      ],
    );

    ///here this varaible is finincal day
    var finincalDaily = Positioned(
      top: widget.mediaQueryData.size.height * 0.25,
      right: widget.mediaQueryData.size.width * 0.015,
      child: Container(
        width: widget.mediaQueryData.size.width * 0.97,
        height: widget.mediaQueryData.size.height * 0.24,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.09),
              blurRadius: 8,
              spreadRadius: 3,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
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
                            widget.resultFinincalSearch = await Reports()
                                .makeDayReport(
                                    widget.pickedDate.day,
                                    widget.pickedDate.month,
                                    widget.pickedDate.year);
                            setState(() {
                              widget.totaleSell =
                                  widget.resultFinincalSearch[0];
                              widget.totallBuy = widget.resultFinincalSearch[1];
                              widget.losses = widget.resultFinincalSearch[2];
                              widget.profits = widget.resultFinincalSearch[3];
                            });
                          },
                          child: Text('Get'),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        choiceDate(),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black)),
                        child: MaterialButton(
                          onPressed: () async {
                            widget.resultFinincalSearch = await Reports()
                                .makeDayReport(
                                    widget.pickedDate.day,
                                    widget.pickedDate.month,
                                    widget.pickedDate.year);
                            setState(() {
                              widget.totaleSell =
                                  widget.resultFinincalSearch[0];
                              widget.totallBuy = widget.resultFinincalSearch[1];
                              widget.losses = widget.resultFinincalSearch[2];
                              widget.profits = widget.resultFinincalSearch[3];
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
    );

    ///here this varaible is finincal month
    var finincalMonthly = Positioned(
      top: widget.mediaQueryData.size.height * 0.25,
      right: widget.mediaQueryData.size.width * 0.015,
      child: Container(
        width: widget.mediaQueryData.size.width * 0.97,
        height: widget.mediaQueryData.size.height * 0.24,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.09),
              blurRadius: 8,
              spreadRadius: 3,
              offset: Offset(0, 10),
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
                      widget.resultFinincalSearch =
                          await Reports().makeMonthReport(
                        widget.firstDateMonthly.month,
                        widget.firstDateMonthly.year,
                      );
                    },
                    child: Text('Get'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    ///here this varaible is finincal year
    var finincalYearly = Positioned(
      top: widget.mediaQueryData.size.height * 0.25,
      right: widget.mediaQueryData.size.width * 0.015,
      child: Container(
        width: widget.mediaQueryData.size.width * 0.97,
        height: widget.mediaQueryData.size.height * 0.24,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.09),
              blurRadius: 8,
              spreadRadius: 3,
              offset: Offset(0, 10),
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
                      // widget.resultFinincalSearch = await Reports()
                      //     .makeYearReport(widget.firstDateMonthly.year);
                    },
                    child: Text('Get'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    ///total sell
    var totalSell = Positioned(
      top: widget.mediaQueryData.size.height * 0.55,
      left: widget.mediaQueryData.size.width * 0.015,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_upward, color: Colors.green),
          SizedBox(width: widget.mediaQueryData.size.width * 0.04),
          Text(
            DemoLocalizations.of(context).translate('totalsell'),
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: widget.mediaQueryData.size.width * 0.42,
          ),
          //result[0]
          Text(widget.totaleSell.toString(),
              style: TextStyle(color: Colors.green)),
        ],
      ),
    );

    ///total Buy
    var totalBuy = Positioned(
      top: widget.mediaQueryData.size.height * 0.65,
      left: widget.mediaQueryData.size.width * 0.015,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_downward, color: Colors.green),
          SizedBox(width: widget.mediaQueryData.size.width * 0.04),
          Text(
            DemoLocalizations.of(context).translate('totalbuy'),
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: widget.mediaQueryData.size.width * 0.42,
          ),
          //result[1]

          Text(widget.totallBuy.toString(),
              style: TextStyle(color: Colors.green)),
        ],
      ),
    );

    ///losses
    var losses = Positioned(
      top: widget.mediaQueryData.size.height * 0.75,
      left: widget.mediaQueryData.size.width * 0.015,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.trending_down, color: Colors.red),
          SizedBox(width: widget.mediaQueryData.size.width * 0.04),
          Text(
            DemoLocalizations.of(context).translate('lose'),
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: widget.mediaQueryData.size.width * 0.47,
          ),
          //result[2]

          Text(widget.losses.toString(), style: TextStyle(color: Colors.red)),
        ],
      ),
    );

    ///pr
    var profits = Positioned(
      top: widget.mediaQueryData.size.height * 0.85,
      left: widget.mediaQueryData.size.width * 0.015,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.trending_up, color: Colors.green),
          SizedBox(width: widget.mediaQueryData.size.width * 0.04),
          Text(
            DemoLocalizations.of(context).translate('earn'),
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: widget.mediaQueryData.size.width * 0.47,
          ),
          //result[3]

          Text(widget.profits.toString(),
              style: TextStyle(color: Colors.green)),
        ],
      ),
    );

    ///
    ///

    ///Here is my scaffold

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          backGroundBoard,
          totalSell,
          totalBuy,
          profits,
          losses,
          widget.daily && !widget.monthly && !widget.yearly
              ? finincalDaily
              : !widget.daily && widget.monthly && !widget.yearly
                  ? finincalMonthly
                  : !widget.daily && !widget.monthly && widget.yearly
                      ? finincalYearly
                      : Daily_Monthly_Yearly,
        ],
      ),
      bottomNavigationBar: BottomNavBar(mediaQueryData: widget.mediaQueryData),
    );
  }

  ///_________________________________________________________
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
                  widget.pickedDate.day == null &&
                          widget.pickedDate.month != null &&
                          widget.pickedDate.year != null
                      ? '${widget.pickedDate.year},${widget.pickedDate.month},${DateTime.now().day}'
                      : widget.pickedDate.day != null &&
                              widget.pickedDate.month == null &&
                              widget.pickedDate.year != null
                          ? '${widget.pickedDate.year},${DateTime.now().month},${widget.pickedDate.day}'
                          : widget.pickedDate.day != null &&
                                  widget.pickedDate.month != null &&
                                  widget.pickedDate.year == null
                              ? '${DateTime.now().year},${widget.pickedDate.month},${widget.pickedDate.day}'
                              : '${widget.pickedDate.year},${widget.pickedDate.month},${widget.pickedDate.day}',
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
                  '${widget.firstDateMonthly.year},${widget.firstDateMonthly.month},${widget.firstDateMonthly.day}',
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
        width: mediaQueryData.size.height * 0.139,
        height: mediaQueryData.size.height * 0.15,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(.09),
                blurRadius: 8,
                spreadRadius: 5,
                offset: Offset(0, 10),
              )
            ]),
        child: Center(
          child: Text(hintText),
        ),
      ),
    );
  }
}
