import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/calculationsAndInventory/addemployee.dart';
import 'package:e2ea/newModels/models/employemodel.dart';
import 'package:e2ea/views/Register/completelyRegister.dart';
import '../../localization/localizations_demo.dart';
import '../../Utility/Utility.dart';
import '../../Widgets/AppBarPhrmacy.dart';
import '../../Widgets/TextFieldForm.dart';
import '../../views/MainHome/MainScreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

class Register extends StatefulWidget {
  Register({Key key, this.userEmployee}) : super(key: key);
  Employee userEmployee;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController name,
      phone,
      date,
      enabledCheckStaticSalary,
      email,
      password,
      enabledCheckByHourSalary,
      costOfHour;

  MediaQueryData mediaQueryData;
  String dropdownValue;
  DateTime pickedDate = new DateTime(0, 0, 0, 0, 0, 0);
  TextAlign textAlign;
  List textCheckbox = [];
  //Employee employee = new Employee.constructor1();

  bool staticSalary = false;
  bool byHourSalary = false;
  bool show = true;

  double salary = 0.0;
  double tempSalar = 0.0;
  int height = 0;
  String result;
  String state = 'employee';

  @override
  void initState() {
    pickedDate = DateTime.now();
    email = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();
    phone = TextEditingController();
    date = TextEditingController();
    enabledCheckStaticSalary = TextEditingController();
    enabledCheckByHourSalary = TextEditingController();
    costOfHour = TextEditingController();
    super.initState();
  }

  void dispose() {
    name.dispose();
    phone.dispose();
    date.dispose();
    enabledCheckStaticSalary.dispose();
    email.dispose();
    password.dispose();
    enabledCheckByHourSalary.dispose();
    costOfHour.dispose();
    super.dispose();
  }

  void clearTextStatic() {
    enabledCheckStaticSalary.clear();
  }

  void clearTextByHour() {
    enabledCheckByHourSalary.clear();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    textCheckbox.add(DemoLocalizations.of(context).translate('constantSalary'));
    textCheckbox.add(DemoLocalizations.of(context).translate('HoureSalary'));
    List hiddinText = [
      DemoLocalizations.of(context).translate('titilePage'),
      DemoLocalizations.of(context).translate('headPage'),
      DemoLocalizations.of(context).translate('filedName'),
      DemoLocalizations.of(context).translate('fieledPhone'),
    ];
    IconButton iconButton = IconButton(
      icon: Icon(Icons.notifications),
      onPressed: () {},
    );
    List<Widget> buttons = [];
    buttons.add(iconButton);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarPharmacy(
        title: hiddinText[0],
        buttons: buttons,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildHeadOfPage(hiddinText),
                  SizedBox(
                    height: mediaQueryData.size.height * 0.03,
                  ),
                  Column(
                    children: <Widget>[
                      TextFieldFrom(
                        validator: 'please Enter Name OF Employee',
                        textEditingController: name,
                        hiddenText: hiddinText[2],
                        prefixIcon: Icon(Icons.person),
                        degreeOfedge: 20,
                      ),
                      SizedBox(
                        height: mediaQueryData.size.height * 0.02,
                      ),
                      TextFieldFrom(
                        validator: 'please Enter Number Of Phone',
                        textEditingController: phone,
                        hiddenText: hiddinText[3],
                        prefixIcon: Icon(Icons.phone),
                        degreeOfedge: 20,
                      ),
                      SizedBox(
                        height: mediaQueryData.size.height * 0.03,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              choiceDate(),
                              choiceSex(),
                            ],
                          ),
                          SizedBox(
                            height: mediaQueryData.size.height * 0.03,
                          ),
                          //first check box for static Salary
                          Container(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  //راتب ثابت
                                  textCheckbox[0],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Checkbox(
                                  checkColor: Colors.grey,
                                  activeColor: Colors.white10,
                                  value: staticSalary,
                                  onChanged: (bool value) {
                                    setState(() {
                                      staticSalary = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          //input for static salary
                          Container(
                            child: TextFormField(
                              validator: (value) => enabledCheckByHourSalary ==
                                      true
                                  ? value.isEmpty
                                      ? "Plaeas should enter salary  To Complete Register!!!!"
                                      : null
                                  : null,
                              controller: enabledCheckStaticSalary,
                              //textAlign: TextAlign.right,
                              keyboardType: TextInputType.number,
                              enabled: staticSalary ? true : false,
                              decoration: InputDecoration(
                                hintText: staticSalary
                                    ? DemoLocalizations.of(context)
                                        .translate('enterSalary')
                                    : DemoLocalizations.of(context)
                                        .translate('cantEnter'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mediaQueryData.size.height * 0.03,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  textCheckbox[1],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Checkbox(
                                  checkColor: Colors.grey,
                                  activeColor: Colors.white10,
                                  value: byHourSalary,
                                  onChanged: (bool value) {
                                    setState(() {
                                      byHourSalary = value;
                                      if (byHourSalary == false) {
                                        enabledCheckByHourSalary.clear();
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) => enabledCheckStaticSalary ==
                                          true
                                      ? value.isEmpty
                                          ? "Plaeas should enter number of work Hour To Complete Register!!!!"
                                          : null
                                      : null,
                                  controller: enabledCheckByHourSalary,
                                  keyboardType: TextInputType.number,
                                  //textAlign: TextAlign.right,
                                  enabled: byHourSalary ? true : false,
                                  decoration: InputDecoration(
                                    hintText: byHourSalary
                                        ? DemoLocalizations.of(context)
                                            .translate('numberOfHours')
                                        : DemoLocalizations.of(context)
                                            .translate('cantEnter'),
                                  ),
                                ),
                                SizedBox(
                                  height: mediaQueryData.size.height * 0.02,
                                ),
                                TextFormField(
                                  validator: (value) => enabledCheckStaticSalary ==
                                          true
                                      ? value.isEmpty
                                          ? "Plaeas should enter cost of Hour  To Complete Register!!!!"
                                          : null
                                      : null,
                                  controller: costOfHour,
                                  //textAlign: TextAlign.right,
                                  keyboardType: TextInputType.number,
                                  enabled: byHourSalary ? true : false,
                                  decoration: InputDecoration(
                                    hintText: byHourSalary
                                        ? DemoLocalizations.of(context)
                                            .translate('CostOfHour')
                                        : DemoLocalizations.of(context)
                                            .translate('cantEnter'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: mediaQueryData.size.height * 0.03,
                          ),

                          MaterialButton(
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                Employee employee;
                                if (staticSalary) {
                                  salary = enabledCheckStaticSalary.text == null
                                      ? 0.0
                                      : double.parse(
                                          enabledCheckStaticSalary.text);
                                  enabledCheckByHourSalary.text = '';
                                  costOfHour.text = '';
                                  employee = new Employee(
                                    name: name.text,
                                    dateStartWork: pickedDate,
                                    sex: dropdownValue,
                                    phoneNumber: phone.text,
                                    salary: salary,
                                  );
                                } else {
                                  salary = enabledCheckByHourSalary.text ==
                                              null ||
                                          costOfHour.text == null
                                      ? 0.0
                                      : double.parse(
                                              enabledCheckByHourSalary.text) *
                                          double.parse(costOfHour.text);
                                  employee = new Employee(
                                    name: name.text,
                                    dateStartWork: pickedDate,
                                    sex: dropdownValue,
                                    phoneNumber: phone.text,
                                    salary: salary,
                                    workHours:
                                        enabledCheckByHourSalary.text == null
                                            ? 0.0
                                            : int.parse(
                                                enabledCheckByHourSalary.text),
                                    costEachWorkHour: costOfHour.text == null
                                        ? 0.0
                                        : double.parse(costOfHour.text),
                                  );
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CompletelyRegister(
                                              employee: employee,
                                              userEmployee: widget.userEmployee,
                                            )));
                              }
                            } //this is process when i press on button register,
                            ,
                            height: mediaQueryData.size.height * 0.08,
                            minWidth: double.infinity,
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              DemoLocalizations.of(context)
                                  .translate('ToNextPage'),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded choiceDate() {
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
                  '${pickedDate.year},${pickedDate.month},${pickedDate.day}',
                  style: TextStyle(fontSize: 10),
                ),
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
      ),
    );
  }

  pickDate() async {
    DateTime datetime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime(DateTime.now().year + 75),
      initialDate: pickedDate,
    );
    if (date != null && datetime != null) {
      setState(() {
        pickedDate = datetime;
      });
    }
  }

  showAlertDialog(BuildContext context, String titleInDialog, Function press) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          titleInDialog,
          textDirection: Utility.isArabic(titleInDialog)
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          textAlign: Utility.isArabic(titleInDialog)
              ? TextAlign.right
              : TextAlign.left,
        ),
        actions: [
          // ignore: deprecated_member_use
          RaisedButton(child: Text("Close"), onPressed: press),
        ],
      ),
    );
  }

  Container choiceSex() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(right: 3),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.only(right: 18, left: 12),
      child: DropdownButton(
        hint: Padding(
          padding: EdgeInsets.only(right: 12, left: 12),
          child: Text(DemoLocalizations.of(context).translate('sex')),
        ),
        elevation: 0,
        value: dropdownValue,
        onChanged: (newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        dropdownColor: Colors.grey[200],
        items: <String>[
          DemoLocalizations.of(context).translate('sexMale'),
          DemoLocalizations.of(context).translate('sexFemale')
        ].map((newValue) {
          return DropdownMenuItem(
            value: newValue,
            child: Text(
              newValue,
              textDirection: ui.TextDirection.rtl,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }

  Container buildHeadOfPage(List hiddinText) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          hiddinText[1],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
