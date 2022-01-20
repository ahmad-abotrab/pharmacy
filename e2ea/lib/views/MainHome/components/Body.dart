//import 'package:e2ea/views/Entering/Entring.dart';

import 'package:e2ea/localization/localizations_demo.dart';
import 'package:e2ea/newController/assistentController/ChoiceCategory.dart';
import 'package:e2ea/newController/assistentController/constantForPopMenu.dart';
import 'package:e2ea/newController/calculationsAndInventory/report.dart';
import 'package:e2ea/newModels/models/employemodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';
import 'package:e2ea/views/SaleMed/SaleMed.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../views/enteringMedicen/enteringMedicen.dart';

import '../../../Widgets/MainOperationCard.dart';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// ignore: must_be_immutable
class Body extends StatelessWidget {
  Body(
      {Key key,
      @required this.mediaQueryData,
      @required this.color,
      @required this.employee})
      : super(key: key);

  final MediaQueryData mediaQueryData;
  final List color;
  Employee employee;
  List<Medicine> productList = [];
  ShowToast(String message, bool Time, BuildContext ctx) {
    Fluttertoast.showToast(
        backgroundColor: Colors.green[400],
        msg: (DemoLocalizations.of(ctx).translate('workingon') +
            " " +
            message +
            '\n \t' +
            DemoLocalizations.of(ctx).translate('plzwait')),
        toastLength: Time ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: mediaQueryData.size.height * 0.13),
            ),
            Container(
              /////////////////////////////////////////////
              /// تعدييييييييييييييييييييلللل
              height: (mediaQueryData.size.height),
              ////////////////////////////////////////////
              width: mediaQueryData.size.width,
              child: Container(
                //margin: EdgeInsets.only(top: mediaQueryData.size.height * 0.17),
                child: GridView.builder(
                  itemCount: color.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //mainAxisExtent: 200,
                    mainAxisSpacing: mediaQueryData.size.height * 0.02,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return MainOpCard(
                      color: color,
                      data: ConstantsMainPage.opGridView(context),
                      index: index,
                      mediaQueryData: mediaQueryData,
                      press: () async {
                        if (ConstantsMainPage.opGridView(context)[index]
                                    .keys
                                    .toString() ==
                                '(حساب الصندوق اليوم)' ||
                            ConstantsMainPage.opGridView(context)[index]
                                    .keys
                                    .toString() ==
                                '(Today Calc Box)') {
                          double totalSell = await Reports().calcTodayBox();
                          //Here should make Calaculate about box and get result
                          final snackBar = SnackBar(
                            content: Text('$totalSell'),
                            duration: Duration(milliseconds: 1500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.green[400],
                            behavior: SnackBarBehavior.fixed,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        if (ConstantsMainPage.opGridView(context)[index]
                                    .keys
                                    .toString() ==
                                '(شراء أدوية)' ||
                            ConstantsMainPage.opGridView(context)[index]
                                    .keys
                                    .toString() ==
                                '(buy Med)') {
                          ShowToast(
                              DemoLocalizations.of(context).translate('buyMed'),
                              false,
                              context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EnteringMedicen(
                                        productsList: productList,
                                        employee: employee,
                                      )));
                        }
                        if (ConstantsMainPage.opGridView(context)[index]
                                    .keys
                                    .toString() ==
                                '(بيع أدوية)' ||
                            ConstantsMainPage.opGridView(context)[index]
                                    .keys
                                    .toString() ==
                                '(sale)') {
                          ShowToast(
                              DemoLocalizations.of(context)
                                  .translate('saleMed'),
                              true,
                              context);
                          Map<String, Medicine> products =
                              await ChoiceCategory().tester();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SaleMed(
                                        mediaQueryData: mediaQueryData,
                                        products: products,
                                        employee: employee,
                                      )));
                        }
                      },
                      pressInformation: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(context, index),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, int index) {
    return new AlertDialog(
      title: Text(
        DemoLocalizations.of(context).translate('titleAlertDialoge'),
        textDirection: ui.TextDirection.rtl,
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            ConstantsMainPage.opGridView(context)[index]
                .values
                .toString()
                .substring(
                    1,
                    ConstantsMainPage.opGridView(context)[index]
                            .values
                            .toString()
                            .length -
                        1),
            textDirection: ui.TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
        ],
      ),
      actions: <Widget>[
        Container(
          alignment: Alignment.bottomLeft,
          // ignore: deprecated_member_use
          child: new FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ),
      ],
    );
  }
}
