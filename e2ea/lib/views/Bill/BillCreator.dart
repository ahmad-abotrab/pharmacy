import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/search/search.dart';
import 'package:e2ea/newController/search/searchbillbetween.dart';
import 'package:e2ea/newModels/models/billmodel.dart';
import 'package:intl/intl.dart';

import '../../Widgets/AppBarPhrmacy.dart';

import 'package:flutter/material.dart';

class BillCreator extends StatefulWidget {
  BillCreator({Key key}) : super(key: key);
  DateTime firstDate = new DateTime(0, 0, 0, 0, 0, 0);
  DateTime secondDate = new DateTime(0, 0, 0, 0, 0, 0);
  TextEditingController firstDateController, secondDateController;
  List<DataRow> rows = [];

  @override
  _BillCreatorState createState() => _BillCreatorState();
}

class _BillCreatorState extends State<BillCreator> {
  MediaQueryData mediaQueryData;
  @override
  void initState() {
    widget.firstDate = DateTime.now();
    widget.secondDate = DateTime.now();
    widget.firstDateController = new TextEditingController();
    widget.secondDateController = new TextEditingController();

    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  List actions = [];
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBarPharmacy(
        title: 'Bills',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'First Date : ',
                        style: TextStyle(
                            fontSize: mediaQueryData.size.width * 0.05),
                      ),
                      choiceDateFirst()
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Second Date : ',
                        style: TextStyle(
                            fontSize: mediaQueryData.size.width * 0.0396),
                      ),
                      choiceDateSecond()
                    ],
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.blueGrey.withOpacity(0.4),
                      Colors.blueGrey.withOpacity(0.9),
                    ])),
                    columns: [
                      DataColumn(label: Container(child: Text("id Bill"))),
                      DataColumn(label: Text("cost")),
                      DataColumn(label: Text("Date")),
                    ],
                    rows: widget.rows == null ? [] : widget.rows,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('get'),
        onPressed: () async {
          print('befor search');
          List<Bill> bills = await SearchBillBetweendates()
              .searching(widget.firstDate, v2: widget.secondDate);
          print('after search');
          List<DataCell> cells = [];
          for (int i = 0; i < bills.length; i++) {
            cells = [];
            cells.add(
              DataCell(
                Text(bills[i].id),
              ),
            );
            cells.add(
              DataCell(
                Text(bills[i].total_price.toString()),
              ),
            );

            String date = formatTimestamp(bills[i].date);
            cells.add(
              DataCell(
                Text(date),
              ),
            );
            setState(() {
              widget.rows.add(DataRow(cells: cells));
            });
          }
        },
      ),
    );
  }

  Expanded choiceDateFirst() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: FittedBox(
                child: Text(
                  widget.firstDate == null
                      ? '${DateTime.now().year},${DateTime.now().month},${DateTime.now().day}'
                      : '${widget.firstDate.year},${widget.firstDate.month},${widget.firstDate.day}',
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

  String formatTimestamp(Timestamp timestamp) {
    var format = new DateFormat('y-MM-d'); // 'hh:mm' for hour & min
    return format.format(timestamp.toDate());
  }

  pickDateFirst() async {
    DateTime datetime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime(DateTime.now().year + 75),
      initialDate: widget.firstDate,
    );
    if (widget.firstDateController != null && datetime != null) {
      setState(() {
        widget.firstDate = datetime;
      });
    }
  }

  Expanded choiceDateSecond() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: FittedBox(
                child: Text(
                  widget.secondDate == null
                      ? '${DateTime.now().year},${DateTime.now().month},${DateTime.now().day}'
                      : '${widget.secondDate.year},${widget.secondDate.month},${widget.secondDate.day}',
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
      initialDate: widget.secondDate,
    );
    if (widget.secondDateController != null && datetime != null) {
      setState(() {
        widget.secondDate = datetime;
      });
    }
  }
}
