import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/Widgets/SearchBy_flutterTypeHead.dart';
import 'package:e2ea/newController/ScanCodeByCamera.dart';
import 'package:e2ea/newController/api_createPDf/pdf_api.dart';
import 'package:e2ea/newController/api_createPDf/pdf_bill.dart';
import 'package:e2ea/newController/assistentController/constantForPopMenu.dart';
import 'package:e2ea/newController/calculationsAndInventory/makeBill.dart';
import 'package:e2ea/newController/search/SearchCustomer.dart';
import 'package:e2ea/newController/search/searchmidbyname.dart';
import 'package:e2ea/newModels/models/billmodel.dart';
import 'package:e2ea/newModels/models/customermodel.dart';
import 'package:e2ea/newModels/models/employemodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';
import 'package:e2ea/views/AddCustomer/AddCustomer.dart';
import 'package:e2ea/views/MainHome/MainScreen.dart';

import '../../Widgets/CategoryItem.dart';

import '../../counter.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../localization/localizations_demo.dart';
import 'dart:ui' as ui;

// ignore: must_be_immutable
class SaleMed extends StatefulWidget {
  SaleMed({Key key, this.products, this.mediaQueryData, this.employee})
      : super(key: key);
  Map<String, dynamic> products;
  Employee employee;

  Map<String, Medicine> tempBody = {};
  List quantity = [];

  Medicine temp1;

  double totalCostOfProducts = 0;
  String barCode;
  MediaQueryData mediaQueryData;
  bool isSearching = true;
  Customer customer;
  TextEditingController textEditingController;
  int typeOfSearch;

  @override
  _SaleMedState createState() => _SaleMedState();
}

class _SaleMedState extends State<SaleMed> {
  @override
  void initState() {
    super.initState();
    widget.quantity = new List.generate(widget.products.length, (index) => 0);
    widget.tempBody = new Map.from(widget.products);
    widget.tempBody.clear();
  }

  @override
  void dispose() {
    widget.products.clear();
    widget.quantity.clear();
    widget.tempBody.clear();
    widget.totalCostOfProducts = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void choiceSearch(String text) {
      if (text == DemoLocalizations.of(context).translate('SearchBy_TradMed')) {
        setState(() {
          widget.isSearching = false;
          widget.typeOfSearch = 0;
        });
        return;
      }

      if (text == DemoLocalizations.of(context).translate('SearchByCustomer')) {
        setState(() {
          widget.isSearching = false;
          widget.typeOfSearch = 1;
        });
        return;
      }
    }

    final Counter counterproduct = Provider.of<Counter>(context);

    return Scaffold(
      appBar: AppBar(
        title: widget.isSearching
            ? FittedBox(
                //
                child: Text(
                    DemoLocalizations.of(context).translate('titleAppbar')))
            : widget.typeOfSearch == 1 //employee
                ? SearchByFlutterTypeHead(
                    suggestionsCallback:
                        SearchCustomer().searchingWithOneParamerter,
                    nofoundItemHint:
                        'not found customer , if you want to add it press on ',
                    target: 'sale',
                    callbackEmployee: (object) => setState(() {
                      widget.customer = object;
                    }),
                  )
                : SearchByFlutterTypeHead(
                    suggestionsCallback:
                        SearchMidByName().searchingWithOneParamerter,
                    nofoundItemHint: 'no Medicine found',
                    target: 'sale',
                    callbackEmployee: (object) => setState(() {
                      widget.temp1 = object;
                      Medicine temp = widget.products[widget.temp1.barcode];

                      setState(() {
                        widget.tempBody[temp.barcode] = temp;
                      });
                    }),
                  ),
        actions: [
          //search button
          widget.isSearching
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: PopupMenuButton<String>(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onSelected: choiceSearch,
                    offset: Offset(10, 45),
                    itemBuilder: (BuildContext context) {
                      return ConstantsMainPage.searchByInSale(context)
                          .map((String choice) {
                        return PopupMenuItem<String>(
                          child: Text(
                            choice,
                            textAlign: TextAlign.end,
                            textDirection: ui.TextDirection.rtl,
                            style: TextStyle(color: Colors.black),
                          ),
                          value: choice,
                        );
                      }).toList();
                    },
                  ),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isSearching = true;
                    });
                  },
                  icon: Icon(Icons.cancel),
                  color: Colors.white,
                ),
          //qrcode Button
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () async {
              widget.barCode = await ScanCodeByCamera().scanBarcodeNormal();
              if (widget.barCode == '-1') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('warnings'),
                    content: Text('this product is not there'),
                    actions: [
                      MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('okay'))
                    ],
                  ),
                );
              } else {
                Medicine temp = widget.products[widget.barCode];

                setState(() {
                  widget.tempBody[widget.barCode] = temp;
                });
              }
            },
          ),
          //add new Customer Button
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddCustomer()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: widget.mediaQueryData.size.height * 0.03,
            ),
            widget.customer == null
                ? Center(
                    child: Text(
                        DemoLocalizations.of(context).translate('nocustomer')))
                : Center(child: Text(widget.customer.name)),
            widget.tempBody.length == 0 || widget.tempBody == null
                ? Column(
                    children: [
                      SizedBox(
                        height: widget.mediaQueryData.size.height * 0.35,
                      ),
                      Container(
                        child: Center(
                          child: Text(DemoLocalizations.of(context)
                              .translate('Noproduct')),
                        ),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                          height: widget.mediaQueryData.size.width * 0.01,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 23,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: widget
                              .tempBody.length, //here to ceate list of grid
                          itemBuilder: (context, index) {
                            return CategoryItem(
                              mediaQueryData: widget.mediaQueryData,
                              product: widget.tempBody[
                                  widget.tempBody.keys.toList()[index]],
                              index: index,
                              // bodyOfPage: widget.bodyOfBage,
                              quantity: widget.quantity,
                              mapBody: widget.tempBody,
                              totaleCost: widget.totalCostOfProducts,
                              callbackToChangeQuantityPropertyProduct:
                                  (object) => setState(() => widget.tempBody[
                                      widget.tempBody.keys
                                          .toList()[index]] = object),
                              callbackToChangeTotalyCost: (object) => setState(
                                  () => widget.totalCostOfProducts = object),
                              callback: (object) =>
                                  setState(() => widget.tempBody = object),
                              callbackNewQuantity: (object) =>
                                  setState(() => widget.quantity = object),
                            );
                          },
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingButton(
        heroTag: 'btnSale',
        customer: widget.customer,
        tempBody: widget.tempBody,
        employee: widget.employee,
        totalCostOfProducts: widget.totalCostOfProducts,
        counterproduct: counterproduct,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    Key key,
    @required this.employee,
    @required this.customer,
    @required this.totalCostOfProducts,
    @required this.counterproduct,
    @required this.tempBody,
    @required this.heroTag,
  }) : super(key: key);

  final Employee employee;
  final String heroTag;
  final Customer customer;
  final double totalCostOfProducts;
  final tempBody;
  final Counter counterproduct;
  onLongPressed() {}

  onPressed(BuildContext context) async {
    List<Medicine> basket = [];
    for (int i = 0; i < tempBody.values.toList().length; i++) {
      print('fff ' + i.toString());
      print(tempBody.values.toList()[i].getQuantity());
      basket.add(tempBody.values.toList()[i]);
    }
    DocumentReference col_bill =
        await FirebaseFirestore.instance.collection('bills').doc();
    Bill bill = new Bill(
      id: col_bill.id,
      employee: employee,
      customer: customer,
      basket: basket,
      total_price: totalCostOfProducts,
      date: Timestamp.now(),
    );
    print('after make bill');
    print('---------------');

    for (int i = 0; i < bill.basket.length; i++) {
      print(basket[i].name);
    }
    print('kkfkfkdfjjhuyruwer989980329*-*-*-*-*-*-*-*-');
    await MakeBill().bill(bill, true);

    // await NewBuyingBill().addBill(bill);
    print('after asign');
    showDialogAfterSale(context, bill);
    counterproduct.counterProduct = 0;
  }

  Future<dynamic> showDialogAfterSale(BuildContext context, Bill bill) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("what you want do ??"),
        content: Text("Each button tells you what it does"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButtonOnSalePage(
                text: "Go To Main",
                press: () => pressButton_GoToMain(context),
              ),
              MaterialButtonOnSalePage(
                text: "pdf",
                press: () => press_createPdf(context, bill),
              ),
              MaterialButtonOnSalePage(
                text: 'Stay',
                press: () => pressButon_Stay(context),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        print('here after choice quantity');
        for (int i = 0; i < tempBody.values.toList().length; i++) {
          print(tempBody.values.toList()[i].quantity);
        }
      },
      child: FloatingActionButton(
        heroTag: heroTag,
        onPressed: () => onPressed(context),
        child: Container(
          child: Column(
            children: [
              FittedBox(
                child: Text(
                  counterproduct.counterProduct.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  pressButton_GoToMain(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreen(
                  employee: employee,
                )));
  }

  press_createPdf(BuildContext context, Bill bill) async {
    final pdf = await PdfBill().generatpdf(bill);
    PdfApi.openFile(pdf);
  }

  pressButon_Stay(BuildContext context) {
    Navigator.pop(context);
  }
}

class MaterialButtonOnSalePage extends StatelessWidget {
  const MaterialButtonOnSalePage({
    Key key,
    this.press,
    this.text,
  }) : super(key: key);

  final Function press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: press,
        child: Container(
          margin: EdgeInsets.all(2),
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue.withOpacity(0.252),
                Colors.blueGrey.withOpacity(0.2)
              ]),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: FittedBox(
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
