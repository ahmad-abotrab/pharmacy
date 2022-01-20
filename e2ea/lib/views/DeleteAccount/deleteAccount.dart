//import 'package:last/views/Login/components/Body.dart';
import 'package:flutter/material.dart';

class DeleteAccount extends StatelessWidget {
  final TextEditingController email, password;
  final MediaQueryData mediaQueryData;
  const DeleteAccount({
    Key key,
    this.email,
    this.password,
    this.mediaQueryData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(" DeleteAccount"),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: mediaQueryData.size.height * 0.02,
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                ),
              ),
            ),
            SizedBox(
              height: mediaQueryData.size.height * 0.02,
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  hintText: "password",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0.1),
              child: RaisedButton(
                
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text("confirm delete account"),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ignore: deprecated_member_use
                            RaisedButton(
                              child: Text("Yes"),
                              onPressed: () {
                                //Here u should delete account form data base
                              },
                            ),
                            // ignore: deprecated_member_use
                            RaisedButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                child: Text("delete"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
