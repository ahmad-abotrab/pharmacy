import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/Utility/Utility.dart';
import 'package:e2ea/localization/localizations_demo.dart';
import 'package:e2ea/newModels/models/employemodel.dart';
import 'package:e2ea/views/MainHome/MainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CompletelyRegister extends StatefulWidget {
  CompletelyRegister({Key key, this.employee, this.userEmployee})
      : super(key: key);
  Employee employee;
  final formKey = GlobalKey<FormState>();
  bool show = true;
  TextEditingController email, password;

  Employee userEmployee;

  Map<String, dynamic> checked = {
    "createAccount": false,
    "finincalReports": false,
    "deleteAccount": false,
    "searchEmployee": false,
    "available": false,
  };

  @override
  _CompletelyRegisterState createState() => _CompletelyRegisterState();
}

class _CompletelyRegisterState extends State<CompletelyRegister> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    widget.email = TextEditingController();
    widget.password = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildHeadOfPage('Available powers for this employee?'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                TextFormField(
                  controller: widget.email,
                  validator: (value) =>
                      value.isNotEmpty ? null : "Please Enter a email address",
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText:
                        DemoLocalizations.of(context).translate('emailFiled'),
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                TextFormField(
                  controller: widget.password,
                  keyboardType: TextInputType.number,
                  validator: (value) => value.length < 6
                      ? "less than 6 character should be more than 8"
                      : null,
                  obscureText: widget.show,
                  decoration: InputDecoration(
                    hintText: DemoLocalizations.of(context)
                        .translate('passwordField'),
                    prefixIcon: IconButton(
                      icon: widget.show
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          widget.show = !widget.show;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('صلاحيات الموظف الجديد'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        value: widget.checked["createAccount"],
                        onChanged: (value) {
                          setState(() {
                            widget.checked["createAccount"] = value;
                          });
                        }),
                    Text('create account')
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        value: widget.checked["finincalReports"],
                        onChanged: (value) {
                          setState(() {
                            widget.checked["finincalReports"] = value;
                          });
                        }),
                    Text('رؤية التقارير المالية')
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        value: widget.checked["deleteAccount"],
                        onChanged: (value) {
                          setState(() {
                            widget.checked["deleteAccount"] = value;
                          });
                        }),
                    Text('حذف حساب موظف')
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        value: widget.checked["searchEmployee"],
                        onChanged: (value) {
                          setState(() {
                            widget.checked["searchEmployee"] = value;
                          });
                        }),
                    Text('البحث عن موظف')
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.green,
                        value: widget.checked["available"],
                        onChanged: (value) {
                          setState(() {
                            widget.checked["available"] = value;
                          });
                        }),
                    Text('تعديل على الصلاحيات')
                  ],
                ),
                MaterialButton(
                  onPressed: () async {
                    if (widget.formKey.currentState.validate()) {
                      //make sign up if there is not any issue
                      try {
                        await auth.createUserWithEmailAndPassword(
                            email: widget.email.text,
                            password: widget.password.text);
                        widget.employee.impression_map = widget.checked;
                        var firebaseUser = FirebaseAuth.instance.currentUser;
                        for (int i = 0;
                            i < widget.employee.impression_map.length;
                            i++) {
                          print('key is  : ' +
                              widget.employee.impression_map.keys.toList()[i].toString() );
                              print('value is  : ' +
                              widget.employee.impression_map.values.toList()[i].toString());

                        }
                        var user = firebaseUser.uid;
                        print(firebaseUser);

                        await FirebaseFirestore.instance
                            .collection('Employee')
                            .doc(user)
                            .set({
                          'employee_id': user,
                          'employee_email': firebaseUser.email,
                          'emoloyee_password': widget.password.text,
                          'state': 'employee',
                          'employee_name': widget.employee.name,
                          'employee_phone': widget.employee.phoneNumber,
                          'employee_sex': widget.employee.sex,
                          'employee_startWork': widget.employee.dateStartWork,
                          'employee_worksHour': widget.employee.workHours,
                          'employee_costOfHourWork':
                              widget.employee.costEachWorkHour,
                          'employee_salary': widget.employee.salary,
                          'impression_map': widget.employee.impression_map
                        });

                        showAlertDialog(context, "اكتمل التسجيل", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MainScreen(employee: widget.userEmployee),
                            ),
                          );
                        });
                      } on FirebaseAuthException catch (exception) {
                        switch (exception.code) {
                          case 'email-already-in-use':
                            {
                              showAlertDialog(context, "الحساب مسجل به من قبل",
                                  () {
                                Navigator.of(context).pop(false);
                              });
                              break;
                            }
                          case 'network-request-failed':
                          case 'unknown':
                            {
                              showAlertDialog(
                                  context, "لا يوجد اتصال بالانترنت", () {
                                Navigator.of(context).pop(false);
                              });
                              break;
                            }

                          default:
                            {
                              showAlertDialog(context,
                                  "الرجاء اعلام الشركة بالحالة المسببة لهذا الخطأ",
                                  () {
                                Navigator.of(context).pop(false);
                              });
                              break;
                            }
                        }
                      }
                    }
                  } //this is process when i press on button register,
                  ,
                  height: MediaQuery.of(context).size.height * 0.08,
                  minWidth: double.infinity,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    DemoLocalizations.of(context).translate('registerButton'),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
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

  Container buildHeadOfPage(String hiddinText) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          hiddinText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
