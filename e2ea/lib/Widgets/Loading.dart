import 'package:e2ea/Widgets/AppBarPhrmacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  Loading({
    Key key,
  }) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    final Color green = new Color.fromRGBO(239, 252, 234, 100);
    return Scaffold(
      appBar: AppBarPharmacy(
        title: "Pharmacy",
      ),
      body: Container(
          color: green,
          child: Center(
            child: SpinKitFadingCircle(
              color: Colors.indigo[600],
              size: 80.0,
            ),
          )),
    );
  }
}
