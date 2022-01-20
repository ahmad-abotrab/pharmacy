import 'package:e2ea/newModels/models/Language.dart';

import '../localization/localizations_demo.dart';
import '../main.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../views/Login/LoginScreen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DrawerPharma extends StatefulWidget {
  DrawerPharma({
    Key key,
    @required this.mediaQueryData,
    @required this.image,
    @required this.name,
    @required this.email,
  }) : super(key: key);

  final MediaQueryData mediaQueryData;
  final String image, name, email;

  @override
  _DrawerPharmaState createState() => _DrawerPharmaState();
}

class _DrawerPharmaState extends State<DrawerPharma> {
  static var Green = Color.fromRGBO(212, 240, 185, 0.8);
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    bool thereImage = false;
    if (widget.image == '' || widget.image == null) {
      thereImage = false;
    } else {
      thereImage = true;
    }
    return Drawer(
      elevation: 0.00,
      child: ListView(
        // Important: Remove any padding from the ListView.
        //padding: EdgeInsets.zero,
        children: <Widget>[
          //Drawer Header
          buildDrawerHeader(context, thereImage),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.black,
            ),
            title: Container(
              // margin: EdgeInsets.symmetric(
              //     horizontal: widget.mediaQueryData.size.width * 0.08),
              child: DropdownButton(
                hint: FittedBox(
                    child: Text(
                  DemoLocalizations.of(context).translate('selectLang'),
                  style: TextStyle(fontSize: 12),
                )),
                onChanged: (value) {
                  choiceLanguage(value);
                },
                items: Language.langList(context)
                    .map<DropdownMenuItem<Language>>((e) {
                  return DropdownMenuItem(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(e.name), Text(e.flag)],
                      ));
                }).toList(),
              ),
            ),
          ),

          //body of drawer
          ListTile(
            //make long press
            leading: Icon(
              Icons.trending_up_rounded,
              color: Colors.green,
            ),
            title: Text(
              DemoLocalizations.of(context).translate('earn'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            //make long press
            leading: Icon(
              Icons.trending_down,
              color: Colors.red,
            ),
            title: Text(
              DemoLocalizations.of(context).translate('lose'),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  padding: EdgeInsets.all(2),
                  elevation: 8,
                  color: Green,
                  onPressed: () {
                    try {
                      auth.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    } on FirebaseAuthException catch (exception) {
                      print(exception.code.toString() + "\t this eception \n");
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Text("Error when you make Sign out"),
                                actions: [Text(exception.code.toString())],
                              ));
                    }
                  },
                  child: Text(
                      DemoLocalizations.of(context).translate('LogoutButton')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void choiceLanguage(Language language) {
    Locale tempLocale;

    switch (language.languageCode) {
      case 'en':
        {
          tempLocale = Locale(language.languageCode, 'US');

          break;
        }
      case 'ar':
        {
          tempLocale = Locale(language.languageCode, 'SY');

          break;
        }
      default:
        {
          tempLocale = Locale(language.languageCode, 'US');

          break;
        }
    }
    MyApp.setLocale(context, tempLocale);
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert;
    // set up the buttons
    // ignore: deprecated_member_use
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    // ignore: deprecated_member_use
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen(),
          ),
        );
      },
    );

    // set up the AlertDialog
    alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Would you to make Log out?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  DrawerHeader buildDrawerHeader(BuildContext context, bool thereImage) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: CircleAvatar(
                    radius: 46.0,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: !thereImage
                                ? AssetImage(widget
                                    .image) //Here should put picture of employee or manager
                                : AssetImage(
                                    widget.image) //here should put person
                            ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // margin: EdgeInsets.only(
                    //     top: widget.mediaQueryData.size.height * 0.13),
                    // alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        FittedBox(
                          child: Text(
                            widget.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.mediaQueryData.size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: widget.mediaQueryData.size.height * 0.02,
            ),
            Flexible(
              child: Text(
                widget.email,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
