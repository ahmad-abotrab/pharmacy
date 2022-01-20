
import '../../../views/MainHome/MainScreen.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.mediaQuery,
    @required this.formKey,
    @required this.cemail,
    @required this.cpassword,
  }) : super(key: key);

  final MediaQueryData mediaQuery;
  final GlobalKey<FormState> formKey;
  final TextEditingController cemail;
  final TextEditingController cpassword;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: mediaQuery.size.height,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: mediaQuery.size.height * 0.001,
                  ),
                  Container(child: new Image.asset("assets/gr1.jpg")),
                  SizedBox(
                    height: mediaQuery.size.height * 0.07,
                  ),
                  TextFormField(
                    controller: cemail,
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
                    controller: cpassword,
                    validator: (value) => value.length < 6
                        ? "less than 6 character should be more than 8"
                        : null,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "password",
                      prefixIcon: Icon(Icons.vpn_key),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mediaQuery.size.height * 0.05,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          ),
                        );
                        // var email = cemail.text.toString();
                        // var password = cpassword.text.toString();

                        /*try {
                          auth.signInWithEmailAndPassword(
                              email: email, password: password);
                        } catch (e) {
                          setState(() {
                            x = "rooror";
                          });
                        }*/
                      }
                    },
                    height: mediaQuery.size.height * 0.08,
                    minWidth: double.infinity,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Login",
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
        ),
      ),
    );
  }
}
