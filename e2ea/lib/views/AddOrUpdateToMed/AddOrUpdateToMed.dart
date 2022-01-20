import 'package:e2ea/newController/search/SearchByBarcode.dart';
import 'package:e2ea/newModels/models/employemodel.dart';

import '../../Widgets/SearchBy_flutterTypeHead.dart';
import '../../localization/localizations_demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'components/Body.dart';

// ignore: must_be_immutable
class AddOrUpdateMed extends StatefulWidget {
  AddOrUpdateMed({
    this.mediaQueryData,
    this.userEmployee,
    key,
  }) : super(key: key);
  MediaQueryData mediaQueryData;
  Employee userEmployee;
  List<TextEditingController> textEditingControllerList =
      List<TextEditingController>.generate(
          20, (index) => new TextEditingController());
  bool isSearching = true;

  @override
  _AddOrUpdateMedState createState() => _AddOrUpdateMedState();
}

class _AddOrUpdateMedState extends State<AddOrUpdateMed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: widget.isSearching
            ? Container(
                child: FittedBox(
                  child: Text(
                    DemoLocalizations.of(context)
                        .translate('titleAppbarEditiingPage'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DancingScript',
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : SearchByFlutterTypeHead(
                suggestionsCallback: SearchByBarcode().getUserSugesstions,
              ), //trade name search

        actions: [
          !widget.isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      widget.isSearching = true;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      widget.isSearching = false;
                    });
                  },
                ),
          IconButton(
              onPressed: () {
                setState(() {
                  for (int i = 0;
                      i < widget.textEditingControllerList.length;
                      i++) {
                    widget.textEditingControllerList[i].text = '';
                  }
                });
              },
              icon: Icon(Icons.delete_sharp)),
        ],
      ),
      body: BodyAddedPage(
        textEditingControllerList: widget.textEditingControllerList,
        useremployee:widget.userEmployee,
      ),
    );
  }
}
