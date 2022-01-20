// ignore_for_file: deprecated_member_use

import 'package:e2ea/Widgets/TextEdite.dart';
import 'package:e2ea/newController/assistentController/ScanCodeByCamera.dart';
import 'package:e2ea/newController/calculationsAndInventory/addMedicin.dart';
import 'package:e2ea/newController/imagepicker2.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class Medicinescreen extends StatefulWidget {
  Medicinescreen({Key key, this.product, this.callBackUrl}) : super(key: key);
  final Medicine product;
  Function(Object) callBackUrl;

  @override
  _MedicinescreenState createState() => _MedicinescreenState();
}

class _MedicinescreenState extends State<Medicinescreen> {
  @override
  Widget build(BuildContext context) {
    double my_font = 20;

    String nameProduct = widget.product.name;
    String theraputicCategoires = widget.product.theraputicCategoires;
    String from = widget.product.from;
    String barcode = widget.product.barcode;
    String indications = widget.product.indications;
    String manufactureCompany = widget.product.manufactureCompany;
    String place = widget.product.place;
    String sideReactions = widget.product.sideReactions;
    String warnings = widget.product.warnings;
    String url = widget.product.urlImage;
    String precautions = widget.product.precautions;

    int packing = widget.product.packing;
    List composition = widget.product.composition;
    double count = widget.product.count_for_consumption;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   IconButton(
        //       icon: Icon(Icons.create_new_folder),
        //       color: Colors.blueAccent,
        //       onPressed: () async {
        //         Fluttertoast.showToast(
        //             backgroundColor: Colors.green[400],
        //             msg: "Opening PDF file ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.BOTTOM,
        //             timeInSecForIosWeb: 1);
        //         // final ffg = await PdfBill.generatpdf(widget.product);
        //         // PdfApi.openFile(ffg);
        //       }),
        // ],
        title: FittedBox(
          child: Text(
            nameProduct,
            style: TextStyle(),
          ),
        ),
        backgroundColor: Colors.green,
        actions: [
          RaisedButton(
              color: Colors.green[600],
              onPressed: () {
                Medicine medicin = new Medicine(
                  id: widget.product.id,
                  urlImage: widget.product.urlImage,
                  name: widget.product.name,
                  barcode: widget.product.barcode,
                  theraputicCategoires: widget.product.theraputicCategoires,
                  from: widget.product.from,
                  packing: widget.product.packing,
                  indications: widget.product.indications,
                  notUses: widget.product.notUses,
                  precautions: widget.product.precautions,
                  warnings: widget.product.warnings,
                  sideReactions: widget.product.sideReactions,
                  manufactureCompany: widget.product.manufactureCompany,
                  composition: widget.product.composition,
                );
                addNewPrpduct().updateProduct(medicin);
              },
              child: Row(
                children: [Text("Save"), Icon(Icons.save)],
              )),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black87)),
                  child: (url == null)
                      ? Image.asset(
                          'assets/images/notFound.png',
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          url,
                        ),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    widget.product.urlImage = await imagepicker2(widget.product)
                        .showMaterialDialog(context);
                    setState(() {
                      url = widget.product.urlImage;
                    });
                  },
                  child: Icon(Icons.add_a_photo),
                )
              ],
            )),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "place ",
                style: TextStyle(
                  fontSize: my_font + 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text: place,
                name_of_changing: 'Placec',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      widget.product.place = object;
                      //medicine.Syrup  = object;
                    })),

            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'count items : ',
                style: TextStyle(
                  fontSize: my_font + 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text: count.toString(),
                name_of_changing: 'count ',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      widget.product.count_for_consumption =
                          double.parse(object);
                    })),

            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "precautions ",
                style: TextStyle(
                  fontSize: my_font + 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text: precautions,
                name_of_changing: 'Syrop',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      widget.product.precautions = object;
                      //medicine.Syrup  = object;
                    })),

            //ACTIONS
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                ' indications: ',
                style: TextStyle(
                  fontSize: my_font + 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            TextEdite(
                text: indications,
                name_of_changing: 'Medicine Actions',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      widget.product.indications = object;
                    })),
            //USAGE
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'theraputicCategoires : ',
                style: TextStyle(
                  fontSize: my_font + 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            TextEdite(
                text: theraputicCategoires,
                name_of_changing: 'Medicine Usage',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      widget.product.theraputicCategoires = object;
                      //medicine.Usage  = object;
                    })),
            //WARRNINGS

            //INTERACTIONS

            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'packing',
                style: TextStyle(
                  fontSize: my_font + 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text: packing.toString(),
                name_of_changing: 'Medicine Interactions',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      widget.product.packing = int.parse(object);
                    })),

            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Side Reactions : ',
                style: TextStyle(
                  fontSize: my_font + 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text: sideReactions,
                name_of_changing: 'Medicine Alternatives',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      widget.product.sideReactions = object;
                      //medicine.Alternatives  = object;
                    })),

            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Company  : ',
                style: TextStyle(
                  fontSize: my_font + 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text: manufactureCompany,
                name_of_changing: 'Medicine Alternatives',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      manufactureCompany = object;
                    })),

            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Formula : ',
                style: TextStyle(
                  fontSize: my_font + 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text: from,
                name_of_changing: 'Medicine Formula',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      widget.product.from = object;
                    })),

            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Barcode : ',
                style: TextStyle(
                  fontSize: my_font + 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            InkWell(
              onDoubleTap: () async {
                barcode = await ScanCodeByCamera().scanBarcodeNormal();
                setState(() {
                  widget.product.barcode = barcode;
                });
              },
              child: Container(
                padding: EdgeInsets.all(5),
                child: SelectableText(
                  barcode,
                  style: TextStyle(
                    fontSize: my_font,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
