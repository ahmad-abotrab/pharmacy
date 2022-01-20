import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/Widgets/SearchBy_flutterTypeHead.dart';
import 'package:e2ea/localization/localizations_demo.dart';
import 'package:e2ea/newController/assistentController/ScanCodeByCamera.dart';
import 'package:e2ea/newController/calculationsAndInventory/makeOrder.dart';
import 'package:e2ea/newController/search/SearchByBarcode.dart';
import 'package:e2ea/newController/search/searchmidbyname.dart';
import 'package:e2ea/newModels/models/billmodel.dart';
import 'package:e2ea/newModels/models/employemodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

import '../../counter.dart';

import '../../views/MainHome/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EnteringMedicen extends StatefulWidget {
  EnteringMedicen({Key key, this.productsList, this.employee})
      : super(key: key);
  Employee employee;
  List<Medicine> productsList;
  String barcode;
  bool isSearching = false;
  Medicine medicineTemp;
  Counter providorForDate;
  @override
  _EnteringMedicenState createState() => _EnteringMedicenState();
}

class _EnteringMedicenState extends State<EnteringMedicen>
    with SingleTickerProviderStateMixin {
  List<DataRow> widetDataRow = [];
  var mapProduct = {};
  Counter controllerFileds;
  int currentCounter = 0;

  String nameProduct = '';

  int rerere = 0;
  double costOfBill = 0;
  List<Medicine> products = [];
  DateTime pickedDate = new DateTime(0, 0, 0, 0, 0, 0);
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    pickedDate = DateTime.now();
    super.initState();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.providorForDate = Provider.of<Counter>(context);
    controllerFileds = Provider.of<Counter>(context);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – h:mm a').format(now);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: !widget.isSearching
            ? FittedBox(
                child: Text(
                    DemoLocalizations.of(context).translate('titlebuymed')))
            : SearchByFlutterTypeHead(
                suggestionsCallback:
                    SearchMidByName().searchingWithOneParamerter,
                nofoundItemHint: 'no Medicine found',
                target: 'sale',
                callbackEmployee: (object) => setState(() {
                  setState(() {
                    widget.medicineTemp = object;
                    setState(() {
                      controllerFileds
                          .textEditingController[
                              controllerFileds.counterAddingMedicens - 1]
                              [controllerFileds.temp[0]]
                          .text = widget.medicineTemp.name;
                      controllerFileds
                          .textEditingController[
                              controllerFileds.counterAddingMedicens - 1]
                              [controllerFileds.temp[4]]
                          .text = widget.medicineTemp.id;
                    });
                  });
                }),
              ),
        actions: [
          !widget.isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isSearching = !widget.isSearching;
                    });
                  },
                  icon: Icon(Icons.search))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isSearching = !widget.isSearching;
                    });
                  },
                  icon: Icon(Icons.cancel)),
          IconButton(
            onPressed: () {
              setState(() {
                if (widget.barcode == null &&
                    controllerFileds.counterAddingMedicens != 0) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                                'لا يمكنك القيام بإضافة جديدة قبل مسح الباركود للمنتج الحالي'),
                            actions: [
                              MaterialButton(
                                  child: Text('okay'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          ));
                } else {
                  if (controllerFileds.counterAddingMedicens == 0) {
                    controllerFileds.addElementToList(
                        controllerFileds.counterAddingMedicens);

                    this.widetDataRow.add(dataRowWidget(formattedDate));
                    currentCounter = controllerFileds.counterAddingMedicens;
                    controllerFileds.increaseCounterAddingMed();
                    print(currentCounter);
                  } else {
                    Medicine medicine123 = new Medicine(
                      barcode: widget.barcode,
                      name: controllerFileds
                          .textEditingController[
                              controllerFileds.counterAddingMedicens - 1]
                              [controllerFileds.temp[0]]
                          .text,
                      id: controllerFileds
                          .textEditingController[
                              controllerFileds.counterAddingMedicens - 1]
                              [controllerFileds.temp[4]]
                          .text,
                      original_price: controllerFileds.textEditingController[
                                  controllerFileds.counterAddingMedicens -
                                      1][controllerFileds.temp[2]] !=
                              null
                          ? double.parse(controllerFileds
                              .textEditingController[
                                  controllerFileds.counterAddingMedicens - 1]
                                  [controllerFileds.temp[2]]
                              .text)
                          : 0.0,
                      price: controllerFileds.textEditingController[
                                  controllerFileds.counterAddingMedicens -
                                      1][controllerFileds.temp[3]] !=
                              null
                          ? double.parse(controllerFileds
                              .textEditingController[
                                  controllerFileds.counterAddingMedicens - 1]
                                  [controllerFileds.temp[3]]
                              .text)
                          : 0.0,
                      choiceQuantity: controllerFileds.textEditingController[
                                  controllerFileds.counterAddingMedicens -
                                      1][controllerFileds.temp[1]] !=
                              null
                          ? int.parse(controllerFileds
                              .textEditingController[
                                  controllerFileds.counterAddingMedicens - 1]
                                  [controllerFileds.temp[1]]
                              .text)
                          : 0,
                      expireDate: widget.providorForDate.firstDateProvidor,
                      limitDateOfMedicine: pickedDate,
                      quantity_limit: controllerFileds.textEditingController[
                                  controllerFileds.counterAddingMedicens -
                                      1][controllerFileds.temp[7]] !=
                              null
                          ? int.parse(controllerFileds
                              .textEditingController[
                                  controllerFileds.counterAddingMedicens - 1]
                                  [controllerFileds.temp[7]]
                              .text)
                          : 0,
                      whereIsThere: controllerFileds
                          .textEditingController[
                              controllerFileds.counterAddingMedicens - 1]
                              [controllerFileds.temp[5]]
                          .text,
                    );
                    rerere++;
                    costOfBill +=
                        medicine123.original_price * medicine123.choiceQuantity;

                    widget.productsList.add(medicine123);
                    controllerFileds.addElementToList(
                        controllerFileds.counterAddingMedicens);

                    this.widetDataRow.add(dataRowWidget(formattedDate));
                    controllerFileds.increaseCounterAddingMed();
                    pickedDate = new DateTime(0, 0, 0, 0, 0, 0);
                  }
                }
              });
            },
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.add,
                color: Colors.blueGrey,
              ),
            ),
          ),
          //bar code buttton
          IconButton(
            onPressed: () async {
              if (controllerFileds.counterAddingMedicens != 0) {
                String barcode = await ScanCodeByCamera().scanBarcodeNormal();

                if (!mounted) return;
                setState(() {
                  widget.barcode = barcode;
                  controllerFileds.barCodeProducts.add(widget.barcode);
                });
                List nameProductAfterSearch =
                    await SearchByBarcode().getUserSugesstions(widget.barcode);
                if (nameProductAfterSearch != null) {
                  String nameProduct = nameProductAfterSearch[0].name;
                  String idProduct = nameProductAfterSearch[0].id;
                  setState(() {
                    controllerFileds
                        .textEditingController[
                            controllerFileds.counterAddingMedicens - 1]
                            [controllerFileds.temp[0]]
                        .text = nameProduct;
                    controllerFileds
                        .textEditingController[
                            controllerFileds.counterAddingMedicens - 1]
                            [controllerFileds.temp[4]]
                        .text = idProduct;
                  });
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                                ',الدواء غير موجود في الداتا بيز ، عند ضغطك على زر موافق سنقوم بمسح الباركود الخاص بالدواء'),
                            actions: [
                              MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("yes")),
                            ],
                          ));
                }
              } else {
                String barcode = await ScanCodeByCamera().scanBarcodeNormal();
                if (!mounted) return;
                setState(() {
                  widget.barcode = barcode;
                });
              }
            },
            icon: Icon(Icons.qr_code),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Form(
            key: formKey,
            child: DataTable(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.blueGrey.withOpacity(0.4),
                Colors.blueGrey.withOpacity(0.9),
              ])),
              sortAscending: true,
              columns: [
                DataColumn(
                    label: Container(
                        child: Text(DemoLocalizations.of(context)
                            .translate('medicinename')))),
                DataColumn(
                    label: Text(
                        DemoLocalizations.of(context).translate('quantity'))),
                DataColumn(
                    label: Text(DemoLocalizations.of(context)
                        .translate('buyingprice'))),
                DataColumn(
                    label: Text(DemoLocalizations.of(context)
                        .translate('sellingprice'))),
                DataColumn(
                    label:
                        Text(DemoLocalizations.of(context).translate('place'))),
                DataColumn(
                    label: Text(
                        DemoLocalizations.of(context).translate('expiredate'))),
                DataColumn(
                    label: Text(DemoLocalizations.of(context)
                        .translate('minquantity'))),
                DataColumn(
                    label: Text(
                        DemoLocalizations.of(context).translate('buydate'))),

                // DataColumn(label: Text("مكان التوضع في الصيدلية")),
                // DataColumn(label: Text("تاريخ انتهاء الصلاحية")),
                // DataColumn(label: Text("الحد الأدنى اللازم توافره")),
                // DataColumn(label: Text("التاريخ")),
              ],
              rows: (controllerFileds.counterAddingMedicens >= 0)
                  ? this.widetDataRow.toList()
                  : [],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          if (formKey.currentState.validate()) {
            Medicine medicine123 = new Medicine(
              barcode: widget.barcode,
              name: controllerFileds
                  .textEditingController[
                      controllerFileds.counterAddingMedicens - 1]
                      [controllerFileds.temp[0]]
                  .text,
              id: controllerFileds
                  .textEditingController[
                      controllerFileds.counterAddingMedicens - 1]
                      [controllerFileds.temp[4]]
                  .text,
              original_price: controllerFileds.textEditingController[
                              controllerFileds.counterAddingMedicens - 1]
                          [controllerFileds.temp[2]] !=
                      null
                  ? double.parse(controllerFileds
                      .textEditingController[
                          controllerFileds.counterAddingMedicens - 1]
                          [controllerFileds.temp[2]]
                      .text)
                  : 0.0,
              price: controllerFileds.textEditingController[
                              controllerFileds.counterAddingMedicens - 1]
                          [controllerFileds.temp[3]] !=
                      null
                  ? double.parse(controllerFileds
                      .textEditingController[
                          controllerFileds.counterAddingMedicens - 1]
                          [controllerFileds.temp[3]]
                      .text)
                  : 0.0,
              choiceQuantity: controllerFileds.textEditingController[
                              controllerFileds.counterAddingMedicens - 1]
                          [controllerFileds.temp[1]] !=
                      null
                  ? int.parse(controllerFileds
                      .textEditingController[
                          controllerFileds.counterAddingMedicens - 1]
                          [controllerFileds.temp[1]]
                      .text)
                  : 0,
              expireDate: widget.providorForDate.firstDateProvidor,
              limitDateOfMedicine: pickedDate,
              quantity_limit: controllerFileds.textEditingController[
                              controllerFileds.counterAddingMedicens - 1]
                          [controllerFileds.temp[7]] !=
                      null
                  ? int.parse(controllerFileds
                      .textEditingController[
                          controllerFileds.counterAddingMedicens - 1]
                          [controllerFileds.temp[7]]
                      .text)
                  : 0,
              whereIsThere: controllerFileds
                  .textEditingController[
                      controllerFileds.counterAddingMedicens - 1]
                      [controllerFileds.temp[5]]
                  .text,
            );
            rerere++;
            costOfBill +=
                medicine123.original_price * medicine123.choiceQuantity;
            // mapProduct[medicine.barcode] = quantity.toJson();
            widget.productsList.add(medicine123);
            controllerFileds
                .addElementToList(controllerFileds.counterAddingMedicens);

            Bill bill = new Bill(
              basket: widget.productsList,
              employee: widget.employee,
            );

            await addOrderBill().orderbill(bill);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'تمت تسجيل الأدوية بنجاح',
                  style: TextStyle(fontSize: 10),
                  textDirection: ui.TextDirection.rtl,
                  textAlign: TextAlign.right,
                ),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen(
                                    employee: widget.employee,
                                  )));
                    },
                    child: Text("انتقل للصفحة الرئيسية"),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  bool checkIfNull(object) {
    bool check;
    object == null ? check = false : check = true;
    return check;
  }

  Column choiceDate() {
    return Column(
      children: <Widget>[],
    );
  }

  pickDate() async {
    DateTime datetime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 75),
      lastDate: DateTime(DateTime.now().year + 75),
      initialDate: DateTime(2020),
    );
    if (controllerFileds.textEditingController[
                    controllerFileds.counterAddingMedicens - 1]
                [controllerFileds.temp[5]] !=
            null &&
        datetime != null) {
      setState(() {
        pickedDate = datetime;
        print('thia is pickdate ' + pickedDate.toIso8601String());
      });
    }
  }

  //To create Data Row For Data Table , formatted Data parameter for Date now but make formate for it

  DataRow dataRowWidget(String formattedDate) {
    return DataRow(
      cells: [
        DataCell(
          TextFormField(
            controller: controllerFileds.textEditingController[controllerFileds
                .counterAddingMedicens][controllerFileds.temp[0]],
            autocorrect: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "اسم الدواء",
              hintTextDirection: ui.TextDirection.rtl,
            ),
          ),
        ),
        DataCell(
          TextFormField(
            validator: (value) => value.isEmpty ? 'عبي الحقل' : null,
            controller: controllerFileds.textEditingController[controllerFileds
                .counterAddingMedicens][controllerFileds.temp[1]],
            autocorrect: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "عدد القطع",
              hintTextDirection: ui.TextDirection.rtl,
            ),
          ),
        ),
        DataCell(
          TextFormField(
            controller: controllerFileds.textEditingController[controllerFileds
                .counterAddingMedicens][controllerFileds.temp[2]],
            autocorrect: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "سعر الشراء",
              hintTextDirection: ui.TextDirection.rtl,
            ),
          ),
        ),
        DataCell(
          TextFormField(
            controller: controllerFileds.textEditingController[controllerFileds
                .counterAddingMedicens][controllerFileds.temp[3]],
            keyboardType: TextInputType.number,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: "سعر المبيع",
              hintTextDirection: ui.TextDirection.rtl,
            ),
          ),
        ),
        DataCell(
          TextFormField(
            controller: controllerFileds.textEditingController[controllerFileds
                .counterAddingMedicens][controllerFileds.temp[5]],
            keyboardType: TextInputType.text,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: "مكان التوضع في الصيدلية",
              hintTextDirection: ui.TextDirection.rtl,
            ),
          ),
        ),
        DataCell(
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: FittedBox(
                                child: Text(
                                  widget.providorForDate.firstDateProvidor == null
                                      ? '${DateTime.now().year},${DateTime.now().month},${DateTime.now().day}'
                                      : '${widget.providorForDate.firstDateProvidor.year},${widget.providorForDate.firstDateProvidor.month},${widget.providorForDate.firstDateProvidor.day}',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              trailing: Icon(Icons.keyboard_arrow_down),
                              onTap: () async {
                                DateTime rr = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(DateTime.now().year - 70),
                                  lastDate: DateTime(DateTime.now().year + 75),
                                  initialDate:
                                      widget.providorForDate.firstDateProvidor,
                                );
                                setState(() =>
                                    widget.providorForDate.setnewDateFirst(rr));
                                // launch(

                                // );
                              },
                            ),
                          ],
                        ),
                      ),
                    
                  ],
                ),
              );
            },
          ),
        ),
        DataCell(
          TextFormField(
            controller: controllerFileds.textEditingController[controllerFileds
                .counterAddingMedicens][controllerFileds.temp[7]],
            keyboardType: TextInputType.number,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: "الحد الأدنى",
              hintTextDirection: ui.TextDirection.rtl,
            ),
          ),
        ),
        DataCell(
          Text(formattedDate),
        ),
      ],
    );
  }
}
