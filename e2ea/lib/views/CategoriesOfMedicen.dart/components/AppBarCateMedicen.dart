//import 'dart:math';

import 'package:e2ea/newController/ScanCodeByCamera.dart';
import 'package:e2ea/newController/search/SearchByBarcode.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

import '../../../localization/localizations_demo.dart';

import '../../../views/PageMedicins/PageMedicins.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBarCateMedicen extends StatefulWidget implements PreferredSizeWidget {
  AppBarCateMedicen(
      {Key key,
      @required this.tabController,
      this.selectedIndex,
      this.tabTitle})
      : super(key: key);
  final TabController tabController;
  bool isSelected = false;
  int selectedIndex;
  int temp = 0;
  String barcode;

  List<String> tabTitle = [];

  @override
  _AppBarCateMedicenState createState() => _AppBarCateMedicenState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _AppBarCateMedicenState extends State<AppBarCateMedicen>
    with TickerProviderStateMixin {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: !isSearching
          ? FittedBox(
              child: Text(
                DemoLocalizations.of(context)
                    .translate('titleAppBarCategoryMed'),
                style: TextStyle(
                  fontFamily: 'DancingScript',
                  fontSize: 25,
                ),
              ),
            )
          : TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              onChanged: (value) {},
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: DemoLocalizations.of(context)
                    .translate("hintTextSearchField"),
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
      actions: [
        isSearching
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
                icon: Icon(
                  Icons.cancel,
                ),
              )
            : IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = true;
                  });
                },
                icon: Icon(Icons.search),
              ),
        IconButton(
          onPressed: pressQrCodeIcon,
          icon: Icon(Icons.qr_code),
        ),
      ],
      elevation: 2,
      bottom: TabBar(
        indicatorColor: Colors.white,

        controller: widget.tabController,
        //automaticIndicatorColorAdjustment: true,
        isScrollable: true,

        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 2,

        tabs: buildTabs(index: widget.temp, context: context),
      ),
    );
  }

  pressQrCodeIcon() async {
    String barcode = await ScanCodeByCamera().scanBarcodeNormal();
    if (!mounted) return () {};
    setState(() {
      widget.barcode = barcode;
    });
    List nameProductAfterSearch =
        await SearchByBarcode().getUserSugesstions(barcode);
    // print("this is barcode. + " + nameProductAfterSearch[0].barCode.toString());
    if (nameProductAfterSearch != null) {
      Medicine product = nameProductAfterSearch[0];

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PageMedicins(
                    product: product,
                  )));
    }
  }

  List<Widget> buildTabs({int index, BuildContext context}) {
    List<Widget> tabs = [];

    for (int i = 0; i < widget.tabTitle.length; i++) {
      String cho = widget.tabTitle[i];
      // String cho = DemoLocalizations.of(context).translate(widget.catMed[i].keys.toList()[0]);
      if (i == widget.selectedIndex) {
        widget.isSelected = true;
      } else {
        widget.isSelected = false;
      }
      tabs.add(
        AnimatedSwitcher(
          duration: Duration(microseconds: 0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Text(
              cho,
              style: TextStyle(
                color: widget.isSelected ? Colors.white : Colors.white54,
                fontFamily: 'Amiri',
                fontSize: 17,
              ),
            ),
          ),
        ),
      );
    }
    return tabs;
  }
}
