import 'package:e2ea/Widgets/Loading.dart';
import 'package:e2ea/newController/calculationsAndInventory/expireNotification.dart';
import 'package:e2ea/newController/calculationsAndInventory/limitNotification.dart';
import 'package:e2ea/newController/mainoperation/accountOperation.dart';
import 'package:e2ea/newController/search/SearchEmployeeByEmail.dart';
import 'package:e2ea/newModels/models/employemodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';
import 'package:e2ea/views/MainHome/MainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  String message;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email, password;

  //String email, password;
  //AccountsOp accountsOp;
  String result = "";
  final Color green = new Color.fromRGBO(239, 252, 226, 1.0);

  MediaQueryData mediaQuery;
  bool show = true;
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
    //accountsOp = AccountsOp();
  }

  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future _showToast() {
    return Fluttertoast.showToast(
      backgroundColor: green,
      msg: " Working On Your Request  ",
      gravity: ToastGravity.BOTTOM,
    );
  }
  // Color(0xFF2bb673)

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xFFf7f7f7),
            appBar: AppBar(
                title: Text("Pharmacy"),
                titleTextStyle:
                    TextStyle(fontFamily: 'Forum-Regular', fontSize: 21),
                titleSpacing: 25,
                backgroundColor: Color(0xFF2bb673)),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  child: Container(
                    //height: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 3 / 2,
                              child:
                                  new Image.asset("assets/images/images.png"),
                            ),
                            SizedBox(
                              height: mediaQuery.size.height * 0.07,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: email,
                              validator: (value) => value.isNotEmpty
                                  ? null
                                  : "Please Enter a email address",
                              decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Color(0xFF2bb673),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.size.height * 0.04,
                            ),
                            TextFormField(
                              controller: password,
                              validator: (value) => value.length < 6
                                  ? "less than 6 character should be more than 8"
                                  : null,
                              obscureText: show,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "password",
                                prefixIcon: IconButton(
                                  icon: show
                                      ? Icon(Icons.visibility_off,
                                          color: Color(0xFF2bb673))
                                      : Icon(Icons.visibility,
                                          color: Color(0xFF2bb673)),
                                  onPressed: () {
                                    setState(() {
                                      show = !show;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.size.height * 0.05,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Color(0xFF2bb673),
                child: Icon(Icons.login, color: Colors.white),
                onPressed: onPressedLoginButton),
          );
  }

  onPressedLoginButton() async {
    if (formKey.currentState.validate()) {
      setState(() => loading = true);
      _showToast();

      widget.message = await AccountsOp().signIn(email.text, password.text);
      //if validation email and password
      if (widget.message == 'The error is :correct') {
        List temp = await SearchEmployeeByEmail().searching(email.text);
        List<Medicine> limit = await limitNotification().getT();
        List<Medicine> expire = await expireDateNotification().getNot();

        if (temp == null || temp.isEmpty) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Warning'),
                    content: Text('this employee is not there '),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          setState(() => loading = false);
                          Navigator.pop(context);
                        },
                        child: Text('okay'),
                      )
                    ],
                  ));
        } else {
          Employee employee = temp[0];

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(
                limit: limit,
                expire: expire,
                employee: employee,
              ),
            ),
          );
        }
      } else {
        setState(() => loading = false);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(widget.message),
            actions: [
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                  setState(() => loading = false);
                  Navigator.of(context).pop(false);
                },
                child: Text("close"),
              )
            ],
          ),
        ); //show dialog function
      }
    }
  }
}
