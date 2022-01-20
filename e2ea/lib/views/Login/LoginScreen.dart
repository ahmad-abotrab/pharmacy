import 'package:e2ea/HelpedClassesForCreateTables/addMed.dart';
import 'package:e2ea/Widgets/Loading.dart';
import 'package:e2ea/newController/calculationsAndInventory/expireNotification.dart';
import 'package:e2ea/newController/calculationsAndInventory/limitNotification.dart';
import 'package:e2ea/newController/mainoperation/accountOperation.dart';
import 'package:e2ea/newController/search/SearchEmployeeByEmail.dart';
import 'package:e2ea/newModels/models/employemodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';
import 'package:e2ea/views/MainHome/MainScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("  Pharmacy "),
              leading: Icon(Icons.login),
            ),
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
                            // SizedBox(
                            //   height: mediaQuery.size.height * 0.001,
                            // ),
                            AspectRatio(
                                aspectRatio: 3 / 2,
                                //mediaQuery.size.width * 0.1 /  mediaQuery.size.width * 0.1,
                                child:
                                    new Image.asset("assets/images/gr1.jpg")),
                            // SizedBox(
                            //   height: mediaQuery.size.height * 0.07,
                            // ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: email,
                              validator: (value) => value.isNotEmpty
                                  ? null
                                  : "Please Enter a email address",
                              decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(Icons.mail),
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
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
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
                            MaterialButton(
                              onPressed: () async {
                                if (formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  _showToast();
                                  print(email.text + " " + password.text);

                                  widget.message = await AccountsOp()
                                      .signIn(email.text, password.text);
                                  //if validation email and password
                                  if (widget.message ==
                                      'The error is :correct') {
                                    List temp = await SearchEmployeeByEmail()
                                        .searching(email.text);

                                    List<Medicine> limit =
                                        await limitNotification().getT();
                                    print('limit us : ' +
                                        limit.length.toString());
                                    List<Medicine> expire =
                                        await expireDateNotification().getNot();
                                    print('expire us : ' +
                                        expire.length.toString());
                                    print(
                                        'length is ' + temp.length.toString());
                                    if (temp == null || temp.isEmpty) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text('Warning'),
                                                content: Text(
                                                    'this employee is not there '),
                                                actions: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      setState(() =>
                                                          loading = false);
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
                              },
                              height: mediaQuery.size.height * 0.08,
                              minWidth: double.infinity,
                              color: green,
                              textColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

// SizedBox(
//   height: mediaQuery.size.height * 0.05,
// ),
// MaterialButton(
//   onPressed: () {
//     if (formKey.currentState.validate()) {
//       print(cemail.text + " " + cpassword.text);
//       Future<String> t = accountsOp.addEmployeeProc(
//           cemail.text,
//           cpassword.text,
//           'Ahmad',
//           '0988888888',
//           10,
//           35.2);
//       if (t == null) {
//         print("ya 7ra is null\n");
//       } else {
//         //String s = t.toString();
//         print(t);
//       }

//       //accountsOp.signIn(cemail, password)
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MainScreen(),
//         ),
//       );
//       // var email = cemail.text.toString();
//       // var password = cpassword.text.toString();

//       /*try {
//       auth.signInWithEmailAndPassword(
//           email: email, password: password);
//     } catch (e) {
//       setState(() {
//         x = "rooror";
//       });
//     }*/
//     }
//   },
//   height: mediaQuery.size.height * 0.08,
//   minWidth: double.infinity,
//   color: Theme.of(context).primaryColor,
//   textColor: Colors.white,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(20),
//   ),
//   child: Text(
//     "sign up",
//     style: TextStyle(
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
// ),
// SizedBox(
//   height: mediaQuery.size.height * 0.05,
// ),
// MaterialButton(
//   onPressed: () {
//     if (formKey.currentState.validate()) {
//       print(cemail.text + " " + cpassword.text);
//       accountsOp.logoutproc();

//       //accountsOp.signIn(cemail, password)
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MainScreen(),
//         ),
//       );
//       // var email = cemail.text.toString();
//       // var password = cpassword.text.toString();

//       /*try {
//       auth.signInWithEmailAndPassword(
//           email: email, password: password);
//     } catch (e) {
//       setState(() {
//         x = "rooror";
//       });
//     }*/
//     }
//   },
//   height: mediaQuery.size.height * 0.08,
//   minWidth: double.infinity,
//   color: Theme.of(context).primaryColor,
//   textColor: Colors.white,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(20),
//   ),
//   child: Text(
//     "sign out",
//     style: TextStyle(
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
// ),
