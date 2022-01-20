import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/search/SearchBillByNameAndDate.dart';
import 'package:e2ea/newController/search/SearchMedById.dart';
import 'package:e2ea/newModels/models/billmodel.dart';
import 'package:e2ea/newModels/models/customermodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:intl/intl.dart';

class ShowBillOrMed extends StatefulWidget {
  ShowBillOrMed({Key key, this.customer}) : super(key: key);
  Customer customer;
  List<String> choices = ['bills', 'medicins'];
  DateTime firstDate = new DateTime(0, 0, 0, 0, 0, 0);
  DateTime secondDate = new DateTime(0, 0, 0, 0, 0, 0);
  TextEditingController firstDateController, secondDateController;
  List<DataRow> rows = [];

  List<DataColumn> billColumn = [
    DataColumn(label: Container(child: Text("id Bill"))),
    DataColumn(label: Text("القيمة الشرائية")),
    DataColumn(label: Text("تاريخ الفاتورة ")),
  ];
  List<DataColumn> medicineColumn = [
    DataColumn(label: Container(child: Text("اسم الدواء"))),
    DataColumn(label: Text("تاريخ الشراء")),
  ];

  String dropDownChoice;

  int whatIChoice = 1;

  @override
  _ShowBillOrMedState createState() => _ShowBillOrMedState();
}

class _ShowBillOrMedState extends State<ShowBillOrMed> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FittedBox(child: Text('Show Bill Customer')),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'choice',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.15,
                      // margin: EdgeInsets.symmetric(
                      //     horizontal: widget.mediaQueryData.size.width * 0.08),
                      child: DropdownButton(
                        hint: FittedBox(
                            child: Text(
                          widget.dropDownChoice == null
                              ? 'choice your chooice'
                              : widget.dropDownChoice,
                          style: TextStyle(fontSize: 16),
                        )),
                        onChanged: (value) {
                          choiceSearch(value);
                          setState(() {
                            widget.dropDownChoice = value;
                            widget.rows = [];
                          });
                        },
                        items:
                            widget.choices.map<DropdownMenuItem<String>>((e) {
                          return DropdownMenuItem(
                              value: e,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e),
                                ],
                              ));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'first Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                    choiceDateFirst(),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'second Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    choiceDateSecond(),
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
                      sortAscending: true,
                      columns: widget.whatIChoice == 1
                          ? widget.medicineColumn
                          : widget.billColumn,
                      rows: widget.rows == null ? [] : widget.rows,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('Get'),
          onPressed: () async {
            List<Bill> bills = await SearchBillByDateAndName().searching(
                widget.firstDate, widget.customer,
                v2: widget.secondDate);
            if (widget.dropDownChoice == 'bills') {
              List<DataCell> cells = [];
              for (int i = 0; i < bills.length; i++) {
                cells = [];
                cells.add(DataCell(Text(bills[i].id)));
                cells.add(DataCell(Text(bills[i].total_price.toString())));
                String date = formatTimestamp(bills[i].date);
                cells.add(DataCell(Text(date)));

                setState(() {
                  widget.rows.add(DataRow(cells: cells));
                });
              }
            } else {
              for (int i = 0; i < bills.length; i++) {
                for (int j = 0; j < bills[i].basket.length; j++) {
                  print("id " + bills[i].basket[j].toString());
                  String id = bills[i]
                      .basket[j]
                      .toString()
                      .substring(1, bills[i].basket[j].toString().length - 1);
                  print('id towe ' + id);

                  List temp = await SearchMidByID().searching(id);
                  List<DataCell> cells = [];
                  cells.add(DataCell(Text(temp[0].name)));
                  String date = formatTimestamp(bills[i].date);
                  cells.add(DataCell(Text(date)));
                  setState(() {
                    widget.rows.add(DataRow(cells: cells));
                  });
                }
              }
            }
          },
        ));
  }

  choiceSearch(choice) {
    if (choice == widget.choices[1]) {
      setState(() {
        widget.whatIChoice = 1;
      });
    } else {
      setState(() {
        widget.whatIChoice = 0;
      });
    }
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
