import '../routes/route_names.dart';
import '../views/EnteringCosts/EnteringCosts.dart';
import '../views/MainHome/MainScreen.dart';
import '../views/Register/Register.dart';
import 'package:flutter/material.dart';

class CustomerRoute {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        {
          return MaterialPageRoute(builder: (_) => MainScreen());
        }
      case (enteringCostRoute):
        {
          return MaterialPageRoute(builder: (_) => EnteringCosts());
        }
        default:{
          return MaterialPageRoute(builder: (_) => 
          Register());
        }
    }
  }
}
