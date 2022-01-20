import 'package:e2ea/newController/assistentController/ScanCodeByCamera.dart';
import 'package:e2ea/newController/calculationsAndInventory/addMedicin.dart';
import 'package:e2ea/newController/search/SearchByBarcode.dart';
import 'package:e2ea/newModels/models/employemodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';
import 'package:e2ea/views/MainHome/MainScreen.dart';

import '../../../Widgets/AlertDialoge.dart';

import '../../../Widgets/FieldAdding.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BodyAddedPage extends StatelessWidget {
  BodyAddedPage({
    Key key,
    this.mediaQueryData,
    this.textEditingControllerList,
    this.useremployee
  }) : super(key: key);

  List<TextEditingController> textEditingControllerList = [];
  Employee useremployee;
  MediaQueryData mediaQueryData;
  List result = [];
  List comp = [];
  List inde = [];
  List<Widget> childColumn;

  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    childColumn = [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.02,
      ),
      Center(
        child: Text('هنا يمكنك إضافة أو تعديل أي صنف دوائي'),
      ),
      FieldAdding(
        textEditingControllerList: textEditingControllerList[0],
        hintText: 'Barcode Medicine',
        iconData: Icons.qr_code,
        press: press,
      ),
      FieldAdding(
        textEditingControllerList: textEditingControllerList[1],
        hintText: 'Name Medicine',
        iconData: Icons.local_pharmacy,
        press: () {
          textEditingControllerList[1].text = '';
        },
      ),
      FieldAdding(
        textEditingControllerList: textEditingControllerList[2],
        hintText: 'Theraputic Categories',
        iconData: Icons.qr_code,
        press: () {
          textEditingControllerList[2].text = '';
        },
      ),
      FieldAdding(
        textEditingControllerList: textEditingControllerList[3],
        hintText: 'Pharmaceutical form',
        iconData: Icons.qr_code,
        press: () {
          textEditingControllerList[3].text = '';
        },
      ),
      FieldAdding(
        textEditingControllerList: textEditingControllerList[4],
        hintText: 'Packing',
        iconData: Icons.qr_code,
        press: () {
          textEditingControllerList[4].text = '';
        },
      ),
      FieldAdding(
        textEditingControllerList: textEditingControllerList[6],
        hintText: 'Indications',
        iconData: Icons.qr_code,
        press: () {},
      ),
      FieldAdding(
        textEditingControllerList: textEditingControllerList[7],
        hintText: 'not uses',
        iconData: Icons.qr_code,
        press: () {
          inde.add(textEditingControllerList[7].text);
          textEditingControllerList[7].text = '';
        },
      ),
      FieldAdding(
        textEditingControllerList: textEditingControllerList[8],
        hintText: 'Precautions',
        iconData: Icons.qr_code,
        press: () {},
      ),
      FieldAdding(
        textEditingControllerList: textEditingControllerList[9],
        hintText: 'warnings',
        iconData: Icons.qr_code,
        press: () {},
      ),
      FieldAdding(
        textEditingControllerList: textEditingControllerList[10],
        hintText: 'side recations',
        iconData: Icons.qr_code,
        press: () {},
      ),
      FieldAdding(
        textEditingControllerList: textEditingControllerList[11],
        hintText: 'Manufacture company',
        iconData: Icons.qr_code,
        press: () {},
      ),
      FieldAdding(
        textEditingControllerList: textEditingControllerList[12],
        hintText: 'Composition',
        iconData: Icons.qr_code,
        press: () {
          comp.add(textEditingControllerList[12].text);
          textEditingControllerList[12].text = '';
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
            onPressed: () async {
              Medicine medicine = new Medicine(
                name: textEditingControllerList[1].text,
                barcode: textEditingControllerList[0].text,
                theraputicCategoires: textEditingControllerList[2].text,
                from: textEditingControllerList[3].text,
                packing:textEditingControllerList[4].text == null? 0 : int.parse(textEditingControllerList[4].text),
                indications: textEditingControllerList[6].text,
                notUses: inde,
                precautions: textEditingControllerList[8].text,
                warnings: textEditingControllerList[9].text,
                sideReactions: textEditingControllerList[10].text,
                manufactureCompany: textEditingControllerList[11].text,
                composition: comp,
              );

              ///add new product
              addNewPrpduct().addProdyct(medicine);

              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('تم اضافة الدواء بنجاح'),
                        actions: [
                          MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Stay')),
                          MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen(employee: useremployee,)));
                              },
                              child: Text('Go To Home')),
                        ],
                      ));
            },
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
                  child: Text(
                    'add',
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
          MaterialButton(
            onPressed: () {
              Medicine medicine = new Medicine(
                id: textEditingControllerList[13].text,
                name: textEditingControllerList[1].text,
                barcode: textEditingControllerList[0].text,
                theraputicCategoires: textEditingControllerList[2].text,
                from: textEditingControllerList[3].text,
                packing: int.parse(textEditingControllerList[4].text),
                indications: textEditingControllerList[6].text,
                notUses: inde,
                precautions: textEditingControllerList[8].text,
                warnings: textEditingControllerList[9].text,
                sideReactions: textEditingControllerList[10].text,
                manufactureCompany: textEditingControllerList[11].text,
                composition: comp,
              );
              addNewPrpduct().updateProduct(medicine);
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('تم التعديل على معلومات الدواء بنجاح'),
                        actions: [
                          MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Stay')),
                          MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen(
                                              employee: useremployee,
                                            )));
                              },
                              child: Text('Go To Home')),
                        ],
                      ));
//  AlertDialog(
//                         title: Text(
//                             'تمت إضافةالدواء بنجاح هل تود العودة للصفحة الرئيسية أم البقاء ؟'),
//                         actions: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               MaterialButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);

//                                   for (int i = 0;
//                                       i < textEditingControllerList.length;
//                                       i++) {
//                                     textEditingControllerList[i].text = '';
//                                   }
//                                   //_____________________
//                                 },
//                                 child: Text("Stay"),
//                               ),
//                               MaterialButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => MainScreen()));
//                                 },
//                                 child: Text("Go Back"),
//                               ),
//                             ],
//                           )
//                         ],
//                       )
              //AddNewProductOrUpdate().updateInformation(product);
            },
            child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.blue.withOpacity(0.252),
                      Colors.blueGrey.withOpacity(0.2)
                    ]),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(child: Text('update'))),
          ),
        ],
      ),
    ];

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: Gradient.lerp(
                LinearGradient(colors: [
                  Colors.blueGrey.withOpacity(0.25),
                  Colors.blueGrey.withOpacity(0.7)
                ]),
                RadialGradient(colors: [
                  Colors.blueGrey.withOpacity(0.6),
                  Colors.blueGrey.withOpacity(0.9)
                ]),
                0.15),
          ),
          child: Column(
            children: childColumn,
          ),
        ),
      ),
    );
  }

//Here when i press in qrcode icon
  press() async {
    comp = [];
    print('length of :  ' + childColumn.length.toString());
    String barcode = await ScanCodeByCamera().scanBarcodeNormal();
    textEditingControllerList[0].text = barcode;
    result = await SearchByBarcode().getUserSugesstions(barcode);
    if (result != null) {
      Medicine product = result[0];
      textEditingControllerList[13].text = product.id;
      textEditingControllerList[1].text = product.name;
      textEditingControllerList[2].text = product.theraputicCategoires;
      textEditingControllerList[3].text = product.from;
      textEditingControllerList[4].text = product.packing.toString();
      textEditingControllerList[5].text = '';
      textEditingControllerList[6].text = product.indications;
      for (int i = 0; i < product.notUses.length; i++) {
        int j = i + 1;
        textEditingControllerList[7].text += ' _$j : ' + product.notUses[i];
      }
      textEditingControllerList[8].text = product.precautions;
      textEditingControllerList[9].text = product.warnings;
      textEditingControllerList[10].text = product.sideReactions;

      textEditingControllerList[11].text = product.manufactureCompany;
      for (int i = 0; i < product.composition.length; i++) {
        int j = i + 1;
        textEditingControllerList[12].text +=
            ' _$j : ' + product.composition[i];
      }
      if (textEditingControllerList[12] == null ||
          textEditingControllerList[12].text == '') {
        textEditingControllerList[12].text = '';
      }
      if (textEditingControllerList[7] == null ||
          textEditingControllerList[7].text == '') {
        textEditingControllerList[7].text = '';
      }
    }
    print('length of :  ' + childColumn.length.toString());
  }
}

// @override
// Widget build(BuildContext context) {
