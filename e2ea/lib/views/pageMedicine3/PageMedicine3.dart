// ignore_for_file: deprecated_member_use

import 'package:e2ea/newController/ImagePicker.dart';

import 'package:e2ea/newController/assistentController/ScanCodeByCamera.dart';
import 'package:e2ea/newController/calculationsAndInventory/addMedicin.dart';
import 'package:e2ea/newController/imagepicker2.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';
import 'package:e2ea/Widgets/TextEdite.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PageMedicins extends StatefulWidget {
  PageMedicins({Key key, this.product, this.callBackUrl}) : super(key: key);
  final Medicine product;
  Function(Object) callBackUrl;
  @override
  _PageMedicinsState createState() => _PageMedicinsState();
}

class _PageMedicinsState extends State<PageMedicins> {
  @override
  Widget build(BuildContext context) {
    String nameProduct = widget.product.name;
    String theraputicCategoires = widget.product.theraputicCategoires;
    String from = widget.product.from;
    int packing = widget.product.packing;
    List composition = widget.product.composition;
    String barcode = widget.product.barcode;
    String indications = widget.product.indications;
    String manufactureCompany = widget.product.manufactureCompany;

    String actions = widget.product.sideReactions;
    String warnings = widget.product.warnings;
    String url = widget.product.urlImage;

    double my_font = (MediaQuery.of(context).size.width) * 0.05;
    double Head = my_font + 5;
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
        title: FittedBox(
          child: Text(
            nameProduct,
            style: TextStyle(),
          ),
        ),
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
                  warnings: widget.product.precautions,
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
        //padding: EdgeInsets.all(2),
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

            TextEdite(
                text: theraputicCategoires != null
                    ? theraputicCategoires
                    : " theraputicCategoires",
                name_of_changing: 'Categoiry',
                font_size: my_font,
                callBackText: (object) => setState(
                    () => widget.product.theraputicCategoires = object)),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "Indications",
                style: TextStyle(
                  fontSize: Head,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text: indications != null
                    ? indications
                    : "  Double tap to add information",
                name_of_changing: 'indications',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      widget.product.from = object;
                      //medicine.Syrup  = object;
                    })),
            //SYRUP
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "SYRUP",
                style: TextStyle(
                  fontSize: Head,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text: from != null ? from : " Double tap to add information",
                name_of_changing: 'Syrop',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      widget.product.from = object;
                      //medicine.Syrup  = object;
                    })),
            TextEdite(
                text: packing != null
                    ? '$packing'
                    : "  Double tap to add information",
                name_of_changing: 'packing',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      widget.product.packing = int.parse(object);
                      //medicine.Syrup  = object;
                    })),

            //ACTIONS
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Actions : ',
                style: TextStyle(
                  fontSize: Head,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            TextEdite(
                text: actions != null
                    ? actions
                    : "  Double tap to add information ",
                name_of_changing: 'Medicine Actions',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      widget.product.sideReactions = object;
                    })),
            //USAGE
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Usage : ',
                style: TextStyle(
                  fontSize: Head,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text: "medicine['Usage']",
                name_of_changing: 'Medicine Usage',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      //    medicine['Usage']" = object;
                      //medicine.Usage  = object;
                    })),
            //WARRNINGS
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Warrnings',
                style: TextStyle(
                  fontSize: Head,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text: warnings != null
                    ? warnings
                    : "  Double tap to add information",
                name_of_changing: 'Medicine Warrnings',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      widget.product.warnings = object;
                    })),
            //INTERACTIONS
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Interactions :',
                style: TextStyle(
                  fontSize: Head,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            TextEdite(
                text: "medicine['Interactions']",
                name_of_changing: 'Medicine Interactions',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      // medicine['Interactions'] = object;
                      //medicine.Interactions  = object;
                    })),
            //Alternative
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Alternatives : ',
                style: TextStyle(
                  fontSize: Head,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text:
                    //medicine.alternative
                    " medicine['Alternatives']",
                name_of_changing: 'Medicine Alternatives',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      //medicine['Alternatives'] = object;
                      //medicine.Alternatives  = object;
                    })),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Company  : ',
                style: TextStyle(
                  fontSize: Head,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text: manufactureCompany != null
                    ? manufactureCompany
                    : "  Double tap to add information ",
                name_of_changing: 'Medicine Alternatives',
                font_size: my_font,
                callBackText: (object) => setState(
                    () => widget.product.manifacture_company = object)),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Formula : ',
                style: TextStyle(
                  fontSize: Head,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextEdite(
                text: " Double tap to add information ",
                name_of_changing: 'Medicine Alternatives',
                font_size: my_font,
                callBackText: (object) => setState(() {
                      //widget.product.
                    })),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Composition : ',
                style: TextStyle(
                  fontSize: Head,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(children: compositionText(composition)),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "Barcode",
                style: TextStyle(
                  fontSize: Head,
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
                    fontSize: Head,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: (MediaQuery.of(context).size.height) * 0.014,
            // ),
          ],
        ),
      ),
    );
  }

  Container spaceBetweenTexts(MediaQueryData mediaQueryData) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueGrey.withOpacity(0.4),
            Colors.blueGrey.withOpacity(0.9)
          ],
        ),
      ),
      child: SizedBox(
        height: mediaQueryData.size.height * 0.014,
      ),
    );
  }

  List<Widget> compositionText(List composition) {
    List<Widget> com = [];
    for (int i = 0; i < composition.length; i++) {
      com.add(Expanded(
        child: Container(
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FittedBox(
                child: composition[i].toString() == null
                    ? Text(
                        composition[i].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : Text(" No composition "),
              ),
            ],
          ),
        ),
      ));
    }
    return com;
  }

  FittedBox makeFormalPharmacy(
      MediaQueryData mediaQueryData, String nameProduct) {
    return FittedBox(
      child: Text(
        'الشكل الصيدلاني : ' + '$nameProduct',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  FittedBox makeTherapeuticCategory(
      MediaQueryData mediaQueryData, String nameProduct) {
    return FittedBox(
      child: Text(
        'الفئة العلاجية : ' + '$nameProduct',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  FittedBox makeNameMedicin(MediaQueryData mediaQueryData, String nameProduct) {
    return FittedBox(
      child: Text(
        'اسم الدواء : ' + '$nameProduct',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class EveryInformationInPage extends StatelessWidget {
  const EveryInformationInPage({
    Key key,
    @required this.nameProduct,
    @required this.direction,
  }) : super(key: key);
  final MainAxisAlignment direction;
  final String nameProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blueGrey.withOpacity(0.4),
        Colors.blueGrey.withOpacity(0.9)
      ])),
      child: Row(
        mainAxisAlignment: direction,
        children: [
          Flexible(
            child: Text(
              '$nameProduct',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 19,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
