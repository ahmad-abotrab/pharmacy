import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/Widgets/AlertDialoge.dart';
import 'package:e2ea/newController/ScanCodeByCamera.dart';
import 'package:e2ea/newController/assistentController/constantForPopMenu.dart';
import 'package:e2ea/newController/calculationsAndInventory/consumption_tendency.dart';
import 'package:e2ea/newController/deleteFromFirebase.dart';
import 'package:e2ea/newController/search/SearchByBarcode.dart';
import 'package:e2ea/newController/search/SearchCustomer.dart';
import 'package:e2ea/newController/search/SearchMidByScientfic.dart';
import 'package:e2ea/newController/search/searchEmployeeName.dart';
import 'package:e2ea/newController/search/searchbillbetween.dart';
import 'package:e2ea/newController/search/searchmidbyname.dart';
import 'package:e2ea/newModels/models/Language.dart';
import 'package:e2ea/newModels/models/consumptionModel.dart';
import 'package:e2ea/newModels/models/employemodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';
import 'package:e2ea/views/Bill/BillCreator.dart';

import 'package:e2ea/views/EditingAccessabilty/EditingAccessabilty.dart';
import 'package:e2ea/views/QuantityInentory/QuantityIneventory.dart';
import 'package:e2ea/views/Register/Register.dart';
import 'package:e2ea/views/finincalReports/FinincalReports.dart';
import 'package:e2ea/views/pageMedicine3/pageMedicine4.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../counter.dart';
import '../../../localization/localizations_demo.dart';
import '../../../main.dart';
import '../../../Widgets/SearchBy_flutterTypeHead.dart';
import '../../../views/AddOrUpdateToMed/AddOrUpdateToMed.dart';
import '../../../views/DeleteAccount/deleteAccount.dart';
import '../../../views/EnteringCosts/EnteringCosts.dart';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

//Notes
//title use FittedBox to make responseve text

// ignore: must_be_immutable
class AppBarMainScreen extends StatefulWidget
    with ChangeNotifier
    implements PreferredSizeWidget {
  MediaQueryData mediaQueryData;
  AppBarMainScreen({
    Key key,
    this.mediaQueryData,
    this.employee,
    this.limitationMedicine,
    this.expireMedicine,
  }) : super(key: key);
  List limitationMedicine;
  bool isPressed = false;
  List expireMedicine;
  DateTime firstDate = new DateTime(0, 0, 0, 0, 0, 0);
  DateTime secondDate = new DateTime(0, 0, 0, 0, 0, 0);
  dynamic counter = 0;

  int howMuchSaleFromProduct;

  String barcode;
  String s = 'l';
  Employee employee;

  TextEditingController firstDateController, secondDateController;
  Counter providorForDate;
  @override
  _AppBarMainScreenState createState() => _AppBarMainScreenState();
  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppBarMainScreenState extends State<AppBarMainScreen>
    with TickerProviderStateMixin {
  bool isSearching = true;
  String codeProduct;
  List<dynamic> all = [];
  TextEditingController textEditingController;
  final formKey = GlobalKey<FormState>();
  int typeOfSearch;

  void changedLang(Language lang) {
    print(lang.name);
  }

  @override
  void initState() {
    widget.firstDate = DateTime.now();
    widget.secondDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Iam in build');
    widget.providorForDate = Provider.of<Counter>(context);

    all.addAll(
        widget.limitationMedicine == null ? [] : widget.limitationMedicine);
    all.addAll(widget.expireMedicine == null ? [] : widget.expireMedicine);
    List<String> title = [];
    for (int i = 0; i < all.length; i++) {
      title.add(all[i].name);
    }
    //nested function to choice what is screen should go to it

    //return widget AppBar
    return AppBar(
      title: isSearching
          ? Container(
              child: FittedBox(
                child: Text(
                  DemoLocalizations.of(context)
                      .translate('mainScreenTitleAppbar'),
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
          : typeOfSearch == 0 //employee
              ? SearchByFlutterTypeHead(
                  suggestionsCallback:
                      SearchEmployee().searchingWithOneParamerter,
                  nofoundItemHint: 'employee Not found',
                  target: 'employee',
                ) //employee name search
              : typeOfSearch == 1 //scientific name
                  ? SearchByFlutterTypeHead(
                      suggestionsCallback:
                          SearchMidByScientificWay().searchingWithOneParamerter,
                      nofoundItemHint: 'no Medicine found',
                      target: 'medicine',
                    ) //scientific name search
                  : typeOfSearch == 2 // trade name
                      ? SearchByFlutterTypeHead(
                          suggestionsCallback:
                              SearchMidByName().searchingWithOneParamerter,
                          nofoundItemHint: 'no Medicine found',
                          target: 'medicine',
                        ) //trade name search
                      : typeOfSearch == 3 // dont
                          ? SearchByFlutterTypeHead()
                          : typeOfSearch == 4
                              ? SearchByFlutterTypeHead(
                                  suggestionsCallback: SearchCustomer()
                                      .searchingWithOneParamerter,
                                  nofoundItemHint: 'no customer found',
                                  target: 'customerAndBill',
                                )
                              : Container(
                                  child: FittedBox(
                                    child: Text(
                                      DemoLocalizations.of(context)
                                          .translate('mainScreenTitleAppbar'),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'DancingScript',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

      //this all action in appbar
      actions: <Widget>[
        //search button
        isSearching
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
                    return ConstantsMainPage.searchBy(context, widget.employee)
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
                    isSearching = true;
                  });
                },
                icon: Icon(Icons.cancel),
                color: Colors.white,
              ),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: PopupMenuButton<String>(
            icon: Stack(
              children: [
                Icon(Icons.notifications),
                Positioned(
                  child: Text(
                    widget.limitationMedicine == null &&
                            widget.expireMedicine == null
                        ? '0'
                        : widget.limitationMedicine == null &&
                                widget.expireMedicine != null
                            ? '${widget.expireMedicine.length}'
                            : widget.limitationMedicine != null &&
                                    widget.expireMedicine == null
                                ? '${widget.limitationMedicine.length}'
                                : '${widget.expireMedicine.length + widget.limitationMedicine.length}',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            onSelected: choicePopButton,
            offset: Offset(10, 45),
            itemBuilder: (BuildContext context) {
              return title.map((String choice) {
                return PopupMenuItem<String>(
                  child: Text(
                    choice,
                    textAlign: TextAlign.start,
                    textDirection: ui.TextDirection.rtl,
                    style: TextStyle(color: Colors.black),
                  ),
                  value: choice,
                );
              }).toList();
            },
          ),
        ),
        //barcode button
        IconButton(
          onPressed: pressQrCodeIcon,
          icon: Icon(Icons.qr_code),
          color: Colors.white,
        ),

        //pop up button
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: choicePopButton,
            offset: Offset(10, 45),
            itemBuilder: (BuildContext context) {
              return ConstantsMainPage.choices(context, widget.employee)
                  .map((String choice) {
                return PopupMenuItem<String>(
                  child: Text(
                    choice,
                    textAlign: TextAlign.start,
                    textDirection: ui.TextDirection.rtl,
                    style: TextStyle(color: Colors.black),
                  ),
                  value: choice,
                );
              }).toList();
            },
          ),
        ),
      ],
    );
  }

  void choicePopButton(
    String choice,
  ) async {
    TextEditingController searchMedicineController =
        new TextEditingController();
    if (choice == DemoLocalizations.of(context).translate('ConsumptionRate')) {
      ConsumptionRateModel consumptionRateMax = new ConsumptionRateModel();
      ConsumptionRateModel consumptionRateMin = new ConsumptionRateModel();
      consumptionRateMax =
          await consumption_tendency().calculate_max_consumption1();
      consumptionRateMin =
          await consumption_tendency().calculate_min_consumption1();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Consumption rate'),
          content: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('max consumption : '),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        consumptionRateMax.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(
                        height: widget.mediaQueryData.size.height * 0.05,
                      ),
                      Text(consumptionRateMax.quantity.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('min consumption : '),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        consumptionRateMin.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(
                        height: widget.mediaQueryData.size.height * 0.05,
                      ),
                      Text(consumptionRateMin.quantity.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: Text('back'),
            )
          ],
        ),
      );
      return;
    }
    if (choice ==
        DemoLocalizations.of(context).translate('HowSaleFromThisMed')) {
      String formatTimestamp(Timestamp timestamp) {
        var format = new DateFormat('y-MM-d'); // 'hh:mm' for hour & min
        return format.format(timestamp.toDate());
      }

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        FittedBox(
                            child: Text('اختر الدواء الذي تريد أن تبحث عنه')),
                        TextFormField(
                          controller: searchMedicineController,
                          validator: (value) => value.isEmpty
                              ? "less than 6 character should be more than 8"
                              : null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "name Medicine Search",
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text('First Date'),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: FittedBox(
                                        child: Text(
                                          widget.providorForDate
                                                      .firstDateProvidor ==
                                                  null
                                              ? '${DateTime.now().year},${DateTime.now().month},${DateTime.now().day}'
                                              : '${widget.providorForDate.firstDateProvidor.year},${widget.providorForDate.firstDateProvidor.month},${widget.providorForDate.firstDateProvidor.day}',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                      trailing: Icon(Icons.keyboard_arrow_down),
                                      onTap: () async {
                                        DateTime rr = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(
                                              DateTime.now().year - 70),
                                          lastDate: DateTime(
                                              DateTime.now().year + 75),
                                          initialDate: widget.providorForDate
                                              .firstDateProvidor,
                                        );
                                        setState(() => widget.providorForDate
                                            .setnewDateFirst(rr));
                                        // launch(

                                        // );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'second Date',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: FittedBox(
                                        child: Text(
                                          widget.providorForDate
                                                      .secondDateProvidor ==
                                                  null
                                              ? '${DateTime.now().year},${DateTime.now().month},${DateTime.now().day}'
                                              : '${widget.providorForDate.secondDateProvidor.year},${widget.providorForDate.secondDateProvidor.month},${widget.providorForDate.secondDateProvidor.day}',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                      trailing: Icon(Icons.keyboard_arrow_down),
                                      onTap: () async {
                                        DateTime rr = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(
                                              DateTime.now().year - 70),
                                          lastDate: DateTime(
                                              DateTime.now().year + 75),
                                          initialDate: widget.providorForDate
                                              .secondDateProvidor,
                                        );
                                        setState(() => widget.providorForDate
                                            .setnewDateSecond(rr));
                                        // launch(

                                        // );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      border: Border.all(color: Colors.black)),
                                  child: Center(child: Text('back'))),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                print('text ' +
                                    widget.providorForDate.firstDateProvidor.day
                                        .toString());
                                print('text text ' +
                                    widget
                                        .providorForDate.secondDateProvidor.day
                                        .toString());
                                print('name ' + searchMedicineController.text);
                                List<dynamic> bills =
                                    await SearchBillBetweendates().searching(
                                        widget
                                            .providorForDate.firstDateProvidor,
                                        v2: widget.providorForDate
                                            .secondDateProvidor);

                                List<Medicine> temp = await SearchMidByName()
                                    .searching(searchMedicineController.text);
                                List<String> ids = [];
                                for (int i = 0; i < bills.length; i++) {
                                  for (int j = 0;
                                      j < bills[i].basket.length / bills.length;
                                      j++) {
                                    ids.add(bills[i].basket[j].toString());
                                  }
                                }
                                for (int i = 0; i < ids.length; i++) {
                                  print(ids[i] + ' ' + i.toString());
                                }
                                int index = 0;
                                for (int i = 0; i < bills.length; i++) {
                                  for (int j = 0;
                                      j < bills[i].basket.length;
                                      j++) {
                                    // print("bsic " + temp[0].id.toString());
                                    // print(
                                    //     "sew " + bills[i].basket[j].toString());
                                    if (temp[0].id == bills[i].basket[j]) {
                                      // print('beack + ' + (j + i).toString());
                                      index = j;
                                      break;
                                    }
                                  }
                                  // print("index is  : " + index.toString());

                                  setState(() {
                                    widget.counter +=
                                        bills[i].quantityList[index];
                                  });
                                }
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.height * 0.12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      border: Border.all(color: Colors.black)),
                                  child: Center(child: Text('okay'))),
                            ),
                          ],
                        ),
                        Text(widget.counter.toString()),
                      ],
                    ),
                  );
                },
              ),
            );
          });
    }

    if (choice == DemoLocalizations.of(context).translate('newACCOUNT')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Register(
            userEmployee: widget.employee,
          ),
        ),
      );
      return;
    }
    if (choice ==
        DemoLocalizations.of(context).translate('EditingForAccessibility')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditingAccessabilty(),
        ),
      );
      return;
    }
    if (choice == DemoLocalizations.of(context).translate('DeleteAccount')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DeleteAccount(mediaQueryData: widget.mediaQueryData),
        ),
      );

      return;
    }
    if (choice == DemoLocalizations.of(context).translate('finincalReports')) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FinincalReports(
                  mediaQueryData: widget.mediaQueryData,
                )),
      );

      return;
    }
    if (choice ==
        DemoLocalizations.of(context).translate('quantityInventory')) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                QuantityInentory(mediaQueryData: widget.mediaQueryData)),
      );

      return;
    }

    if (choice == DemoLocalizations.of(context).translate('EnteringCost')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EnteringCosts(
            employee: widget.employee,
            mediaQueryData: widget.mediaQueryData,
          ),
        ),
      );

      return;
    }
    if (choice == DemoLocalizations.of(context).translate('addOrupdateMed')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddOrUpdateMed(
            mediaQueryData: widget.mediaQueryData,
            userEmployee: widget.employee,
          ),
        ),
      );

      return;
    }
    if (choice == DemoLocalizations.of(context).translate('deleteProduct')) {
      deleteProduct();
      return;
    }
  }

  pickDateFirst() async {
    DateTime datetime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime(DateTime.now().year + 75),
      initialDate: widget.firstDate,
    );
    if (datetime != null) {
      setState(() => widget.firstDate = datetime);
    }
  }

  pickDateSecond() async {
    DateTime datetime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime(DateTime.now().year + 75),
      initialDate: widget.secondDate,
    );
    if (widget.secondDateController != null && datetime != null) {
      setState(() => widget.secondDate = datetime);
    }
  }

  Expanded choiceDateFirst() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: FittedBox(
                child: Text(
                  widget.firstDate == null
                      ? '${DateTime.now().year},${DateTime.now().month},${DateTime.now().day}'
                      : '${widget.firstDate.day}',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () {
                // launch(
                pickDateFirst();
                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  Expanded choiceDateSecond() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: FittedBox(
                child: Text(
                  widget.secondDate == null
                      ? '${DateTime.now().year},${DateTime.now().month},${DateTime.now().day}'
                      : '${widget.secondDate.day}',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: () {
                // launch(
                pickDateSecond();
                // );
              },
            ),
          ],
        ),
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

    if (nameProductAfterSearch != null) {
      if (nameProductAfterSearch != null) {
        Medicine product = nameProductAfterSearch[0];

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Medicinescreen(
                      product: product,
                    )));
      } else {
        print('i am in else\n');
      }
    }
  }

  void choiceSearch(String text) {
    if (text == DemoLocalizations.of(context).translate('SearchByEmployee')) {
      setState(() {
        isSearching = false;
        typeOfSearch = 0;
      });

      return;
    }
    if (text == DemoLocalizations.of(context).translate('SearchBy_TradMed')) {
      setState(() {
        isSearching = false;
        typeOfSearch = 2;
      });
      return;
    }
    if (text ==
        DemoLocalizations.of(context).translate('SearchBy_ScientificMed')) {
      setState(() {
        isSearching = false;
        typeOfSearch = 1;
      });
      return;
    }
    if (text == DemoLocalizations.of(context).translate('SearchBy..')) {
      setState(() {
        isSearching = false;
        typeOfSearch = 3;
      });
      return;
    }
    if (text == DemoLocalizations.of(context).translate('SearchByCustomer')) {
      setState(() {
        isSearching = false;
        typeOfSearch = 4;
      });
      return;
    }
    if (text == DemoLocalizations.of(context).translate('SearchBillBetween')) {
      setState(() {
        isSearching = false;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BillCreator()));
      });
      return;
    }
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

  deleteProduct() async {
    String barcode = await ScanCodeByCamera().scanBarcodeNormal();
    List resultSearch = await SearchByBarcode().getUserSugesstions(barcode);
    Medicine product = resultSearch[0];
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context, product),
      ),
    );
  }

  contentBox(context, Medicine product) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FittedBox(
                child: Text(
                  product.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                DemoLocalizations.of(context).translate('contentDeleteProduct'),
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () async {
                      await DeleteFromFirebase()
                          .deleteFormFirebase(product, 'medicins');
                      Navigator.pop(context);
                    },
                    child: Text(
                      DemoLocalizations.of(context).translate('OkayButton'),
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: 30,
          right: 45,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(Constants.avatarRadius)),
              child: Container(
                margin: EdgeInsets.only(
                    top: widget.mediaQueryData.size.height * 0.01),
                height: widget.mediaQueryData.size.height * 0.09,
                width: widget.mediaQueryData.size.width * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: product.urlImage != null
                          ? NetworkImage(product.urlImage)
                          : AssetImage("assets/images/notFound.png"),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
