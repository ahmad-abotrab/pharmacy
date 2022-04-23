import 'package:e2ea/views/Login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import './counter.dart';
import './localization/localizations_demo.dart';
import './routes/customer_rout.dart';
import './routes/route_names.dart';
import 'newModels/models/employemodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => Counter(),
      child: MyApp(
          ),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({
    Key key,
    this.employee,
    this.auth,
  }) : super(key: key);
  Employee employee;
  var auth;
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale;

  setLocale(Locale locale) {
    setState(() {
      this.locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    Employee emp = new Employee();
    emp.email = 'rafirafi@gmail.com';
    emp.name = 'رافي الروف';
    emp.id = 'NKKwLXkFUUb8AtqYSThyMI4RJLy1';
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PharmacyApp',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Color(0xFF2bb673),
        ),
        locale: this.locale,
        localizationsDelegates: [
          DemoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'SY')],
        onGenerateRoute: CustomerRoute.allRoutes,
        initialRoute: homeRoute,
        home: LoginScreen());
  }
}
