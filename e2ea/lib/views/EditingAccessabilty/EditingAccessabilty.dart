import 'package:e2ea/Widgets/SearchBy_flutterTypeHead.dart';
import 'package:e2ea/localization/localizations_demo.dart';
import 'package:e2ea/newController/mainoperation/check_special.dart';
import 'package:e2ea/newController/search/searchEmployeeName.dart';
import 'package:e2ea/newModels/models/employemodel.dart';
import 'package:flutter/material.dart';

class EditingAccessabilty extends StatefulWidget {
  EditingAccessabilty({Key key}) : super(key: key);
  bool isSearhing = true;
  Employee employee;
  Map<String, dynamic> checked = {
    "createAccount": false,
    "finincalReports": false,
    "deleteAccount": false,
    "searchEmployee": false,
    "available": false,
  };

  @override
  _EditingAccessabiltyState createState() => _EditingAccessabiltyState();
}

class _EditingAccessabiltyState extends State<EditingAccessabilty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: widget.isSearhing
              ? FittedBox(
                  child: Text(DemoLocalizations.of(context)
                      .translate('editingaccebility')))
              : widget.employee == null
                  ? SearchByFlutterTypeHead(
                      suggestionsCallback:
                          SearchEmployee().searchingWithOneParamerter,
                      nofoundItemHint: 'employee Not found',
                      target: 'employee',
                      whereIam: 'Accessabilty',
                      callbackEmployee: (object) => setState(() {
                        widget.employee = object;
                        widget.checked["createAccount"] =
                            widget.employee.impression_map["createAccount"];
                        widget.checked["finincalReports"] =
                            widget.employee.impression_map["finincalReports"];
                        widget.checked["deleteAccount"] =
                            widget.employee.impression_map["deleteAccount"];
                        widget.checked["searchEmployee"] =
                            widget.employee.impression_map["searchEmployee"];
                        widget.checked["available"] =
                            widget.employee.impression_map["available"];
                      }),
                    )
                  : Text(widget.employee.name),
          actions: [
            widget.isSearhing
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isSearhing = !widget.isSearhing;
                      });
                    },
                    icon: Icon(Icons.search))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isSearhing = !widget.isSearhing;
                        widget.employee = null;
                      });
                      setState(() {
                        widget.checked["createAccount"] = false;
                        widget.checked["finincalReports"] = false;
                        widget.checked["deleteAccount"] = false;
                        widget.checked["searchEmployee"] = false;
                        widget.checked["available"] = false;
                      });
                    },
                    icon: Icon(Icons.cancel))
          ]),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            // AspectRatio(
            //         aspectRatio: 0.4 / 0.4,

            //         child: new Image.asset("assets/images/perm.jpg")),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromRGBO(239, 252, 226, 1.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      DemoLocalizations.of(context).translate('newaccebility'),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(12),
                //       color: Color.fromRGBO(239, 252, 226, 0.8)),
                //   child: Text(
                //     widget.employee.getName() != null
                //         ? widget.employee.getName()
                //         : '  ',
                //     style: TextStyle(color: Colors.black),
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              children: [
                Checkbox(
                    activeColor: Colors.blue[200],
                    checkColor: Colors.green,
                    value: widget.checked["createAccount"],
                    onChanged: (value) {
                      setState(() {
                        widget.checked["createAccount"] = value;
                      });
                    }),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromRGBO(239, 252, 226, 1.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DemoLocalizations.of(context).translate('creataccount'),
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                Checkbox(
                    activeColor: Colors.blue[200],
                    checkColor: Colors.green,
                    value: widget.checked["finincalReports"],
                    onChanged: (value) {
                      setState(() {
                        widget.checked["finincalReports"] = value;
                      });
                    }),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromRGBO(239, 252, 226, 1.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DemoLocalizations.of(context).translate('seereport'),
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                Checkbox(
                    activeColor: Colors.blue[200],
                    checkColor: Colors.green,
                    value: widget.checked["deleteAccount"],
                    onChanged: (value) {
                      setState(() {
                        widget.checked["deleteAccount"] = value;
                      });
                    }),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromRGBO(239, 252, 226, 1.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DemoLocalizations.of(context).translate('deletaccount'),
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                Checkbox(
                    activeColor: Colors.blue[200],
                    checkColor: Colors.green,
                    value: widget.checked["searchEmployee"],
                    onChanged: (value) {
                      setState(() {
                        widget.checked["searchEmployee"] = value;
                      });
                    }),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromRGBO(239, 252, 226, 0.8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DemoLocalizations.of(context).translate('seerchaccount'),
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                Checkbox(
                    activeColor: Colors.blue[200],
                    checkColor: Colors.green,
                    value: widget.checked["available"],
                    onChanged: (value) {
                      setState(() {
                        widget.checked["available"] = value;
                      });
                    }),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromRGBO(239, 252, 226, 0.8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DemoLocalizations.of(context)
                          .translate('editingaccebility'),
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upload),
        onPressed: () async {
          await checks()
              .update_option_employee(widget.employee, widget.checked);
        },
      ),
    );
  }
}
