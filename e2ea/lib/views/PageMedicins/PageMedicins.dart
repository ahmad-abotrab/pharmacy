import 'package:e2ea/newModels/models/medicinmodel.dart';

import 'package:flutter/material.dart';

class PageMedicins extends StatefulWidget {
  PageMedicins({Key key, this.product}) : super(key: key);
  final Medicine product;
  //final MediaQueryData mediaQueryData;

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

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: FittedBox(
            child: Text(
          'Profile of Medicin',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        )),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.blueGrey.withOpacity(0.4),
              Colors.blueGrey.withOpacity(0.9)
            ])),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: mediaQueryData.size.height * 0.007,
                      left: mediaQueryData.size.height * 0.01),
                  height: mediaQueryData.size.height * 0.17,
                  width: mediaQueryData.size.width * 0.26,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/panadol.png"),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        makeNameMedicin(mediaQueryData, nameProduct),
                        makeFormalPharmacy(mediaQueryData, from),
                        makeTherapeuticCategory(
                            mediaQueryData, theraputicCategoires),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: EveryInformationInPage(
              nameProduct: 'العبوة : ' + '$packing',
              direction: MainAxisAlignment.start,
            ),
          ),
          Expanded(
            child: EveryInformationInPage(
              nameProduct: 'التركيب :',
              direction: MainAxisAlignment.end,
            ),
          ),
          Expanded(
            child: Column(
              children: compositionText(composition),
            ),
          ),
          Expanded(
            child: EveryInformationInPage(
              nameProduct: 'الاستطبابات : ',
              direction: MainAxisAlignment.end,
            ),
          ),
          Expanded(
            child: EveryInformationInPage(
              nameProduct: indications,
              direction: MainAxisAlignment.end,
            ),
          ),
          Expanded(
            child: EveryInformationInPage(
              nameProduct: 'الآثار الجانبية',
              direction: MainAxisAlignment.end,
            ),
          ),
          Expanded(
            child: Column(
              children: compositionText(composition),
            ),
          ),
          Expanded(
            child: EveryInformationInPage(
              nameProduct: 'أهم التداخلات الدوائية',
              direction: MainAxisAlignment.end,
            ),
          ),
          Expanded(
            child: Column(
              children: compositionText(composition),
            ),
          ),
          Expanded(
            child: EveryInformationInPage(
              nameProduct: 'الشركة المصنعة :  $manufactureCompany',
              direction: MainAxisAlignment.end,
            ),
          ),
          Expanded(
            child: EveryInformationInPage(
              nameProduct: 'barcode :   $barcode',
              direction: MainAxisAlignment.start,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueGrey.withOpacity(0.4),
                    Colors.blueGrey.withOpacity(0.9)
                  ],
                ),
              ),
            ),
          ),
        ],
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueGrey.withOpacity(0.4),
                Colors.blueGrey.withOpacity(0.9)
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FittedBox(
                child: Text(
                  composition[i].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
