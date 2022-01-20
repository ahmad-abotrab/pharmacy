import 'package:e2ea/localization/localizations_demo.dart';
import 'package:e2ea/newController/calculationsAndInventory/addCosts.dart';
import 'package:e2ea/newModels/models/costsmodel.dart';
import 'package:e2ea/newModels/models/employemodel.dart';

import '../../views/MainHome/MainScreen.dart';

import '../../counter.dart';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EnteringCosts extends StatefulWidget {
  EnteringCosts({Key key, this.employee, this.mediaQueryData})
      : super(key: key);
  DateTime pickedDate = new DateTime(0, 0, 0, 0, 0, 0);
  DateTime storeDate = new DateTime(0, 0, 0, 0, 0, 0);
  TextEditingController date;
  MediaQueryData mediaQueryData;

  Employee employee;
  Counter dropDownValue;
  List<DataRow> dataRowList = [];
  double cost = 0;

  TextEditingController priceOfCosts;
  TextEditingController notes;

  List listCostBill = [];

  String typeOfCost_dropDown;

  bool checkPresentTime = true;
  final formKey = GlobalKey<FormState>();

  @override
  _EnteringCostsState createState() => _EnteringCostsState();
}

class _EnteringCostsState extends State<EnteringCosts> {
  String formattedDate =
      DateFormat('yyyy-MM-dd – h:mm a').format(DateTime.now());

  @override
  void initState() {
    widget.priceOfCosts = new TextEditingController();
    widget.notes = new TextEditingController();
    widget.pickedDate = DateTime.now();
    widget.date = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    widget.priceOfCosts.dispose();
    widget.notes.dispose();
    super.dispose();
  }

  Container choiceDate() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              widget.pickedDate == null ? '${DateTime.now().year},${DateTime.now().month},${DateTime.now().day}'
              :'${widget.pickedDate.year},${widget.pickedDate.month},${widget.pickedDate.day}',
              style: TextStyle(fontSize: 15),
            ),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: () {
              // launch(

              pickDate();

              // );
            },
          ),
        ],
      ),
    );
  }

  pickDate() async {
    DateTime datetime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime(DateTime.now().year + 75),
      initialDate: widget.pickedDate == null ? DateTime.now() : widget.pickedDate,
    );
    if (widget.date != null && datetime != null) {
      setState(() {
        widget.pickedDate = datetime;
        widget.storeDate = datetime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> listDropDowCosts = [
      DemoLocalizations.of(context).translate('inListCosts1'),
      DemoLocalizations.of(context).translate('inListCosts2'),
      DemoLocalizations.of(context).translate('inListCosts3'),
      DemoLocalizations.of(context).translate('inListCosts4'),
      DemoLocalizations.of(context).translate('inListCosts5')
    ];
    widget.dropDownValue = Provider.of<Counter>(context);
    DataRow dataRowWidget(String formattedDate) {
      return DataRow(
        cells: [
          DataCell(
            Text(widget.typeOfCost_dropDown),
          ),
          DataCell(
            Text(widget.priceOfCosts.text),
          ),
          DataCell(
            Text(widget.notes.text),
          ),
          DataCell(
            Text(formattedDate),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: FittedBox(
          child: Text(
              DemoLocalizations.of(context).translate('titleAppbarCostPage')),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (widget.formKey.currentState.validate()) {
                    this.widget.dataRowList.add(
                        dataRowWidget(DateFormat().format(widget.pickedDate)));

                    if (this.widget.dataRowList.length > 0) {
                      costs costBill = new costs(
                        typeOfCost: widget.typeOfCost_dropDown,
                        cost: widget.priceOfCosts == null ? 0.0 :double.parse(widget.priceOfCosts.text),
                        notes: widget.notes.text,
                        formattedDate: DateFormat().format(widget.pickedDate),
                      );
                      widget.cost += widget.priceOfCosts == null ? 0.0 :double.parse(widget.priceOfCosts.text);
                      widget.listCostBill.add(costBill.toJson());
                    }

                    widget.date.text = DateFormat().format(widget.pickedDate);

                    widget.priceOfCosts.text = '';
                    widget.notes.text = '';
                    widget.checkPresentTime = true;
                  }
                });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.mediaQueryData.size.width * 0.25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  margin: EdgeInsets.only(
                      top: widget.mediaQueryData.size.height * 0.02),
                  child: DropdownButton<String>(
                    value: widget.typeOfCost_dropDown,
                    // style: TextStyle(fontSize: 20),
                    onChanged: (String value) {
                      setState(() {
                        widget.typeOfCost_dropDown = value;
                      });
                    },
                    focusColor: Colors.grey,
                    icon: Icon(Icons.arrow_downward),
                    items: listDropDowCosts.map((ele) {
                      return DropdownMenuItem(
                        value: ele,
                        child: Text(ele),
                      );
                    }).toList(),
                    hint: Text(
                        DemoLocalizations.of(context).translate('typeOfCost')),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.all(widget.mediaQueryData.size.height * 0.02),
                  child: TextFormField(
                    controller: widget.priceOfCosts,
                    validator: (value) => value.isNotEmpty
                        ? null
                        : DemoLocalizations.of(context).translate('validator'),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: DemoLocalizations.of(context)
                          .translate('priceOfCost'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.all(widget.mediaQueryData.size.height * 0.02),
                  child: TextFormField(
                    controller: widget.notes,
                    validator: (value) => value.isNotEmpty
                        ? null
                        : DemoLocalizations.of(context).translate('validator'),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText:
                          DemoLocalizations.of(context).translate('notes'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                widget.checkPresentTime
                    ? Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            value: widget.checkPresentTime,
                            onChanged: (value) {
                              setState(() {
                                widget.checkPresentTime = value;
                              });
                            },
                          ),
                          SizedBox(
                              width: widget.mediaQueryData.size.width * 0.01),
                          Text(DemoLocalizations.of(context)
                              .translate('presenTime'))
                        ],
                      )
                    : Container(
                        margin: EdgeInsets.all(12),
                        child: choiceDate(),
                      ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text(
                          DemoLocalizations.of(context).translate('typeOfCost'),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          DemoLocalizations.of(context)
                              .translate('priceOfCost'),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          DemoLocalizations.of(context).translate('notes'),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          DemoLocalizations.of(context).translate('date'),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                      ],
                      rows: this.widget.dataRowList == null
                          ? []
                          : this.widget.dataRowList,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // AddCosts().addCostBill(widget.listCostBill, formattedDate);
          add_costs().enter_costs(widget.listCostBill, DateTime.now());
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(
                        DemoLocalizations.of(context).translate('backToHome')),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen(
                                        employee: widget.employee,
                                      )));
                        },
                        child: Text('go back'),
                      )
                    ],
                  ));
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
