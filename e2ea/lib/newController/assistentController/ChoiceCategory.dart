import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/search/searchmidbyname.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

class ChoiceCategory {
  Map<String, Medicine> result = {};
  List quantityResult = [];

  List quan = [];

  Future<Object> getAllDrugsQuantity(Medicine product) async {
    quantityResult.clear();

    return await FirebaseFirestore.instance
        .collection('quantity')
        .where('product_id', isEqualTo: product.id)
        .get()
        // ignore: missing_return
        .then((value) async {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) async {
          product.original_price = element.data()['original_price'] == null
              ? 0
              : element.data()['original_price'];
          product.price =
              element.data()['price'] == null ? 0 : element.data()['price'];
          product.choiceQuantity = 0;
          product.basicQuantity = element.data()['quantity'] == null
              ? 0
              : element.data()['quantity'];
          product.restOfAmount = element.data()['quantity'] == null
              ? 0
              : element.data()['quantity'];

          // product.expireDate = element.data()['dateExpire'];
        });
        // print("in get all drugs. " + productNew.name);
        return product;
      }
    });
  }

  tester() async {
    Map<String, Medicine> resultAfterSearchQuantity = {};
    List result = [];
    List valuesPrpduct =
        await FirebaseFirestore.instance.collection('medicins').get()
            // ignore: missing_return
            .then((value) async {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          Medicine product = new Medicine();
          product.id = doc.data()['medicin_id'];
          product.name = doc.data()['medicin_name'];
          product.barcode = doc.data()['Barcode'];
          product.composition = doc.data()['Composition'];
          product.from = doc.data()['From'];
          product.manufactureCompany = doc.data()['ManufactureCompany'];
          product.packing = doc.data()['Packing'];
          product.theraputicCategoires = doc.data()['Theraputic Categories'];
          product.indexing = doc.data()['indexing'];
          product.indications = doc.data()['Indications'];
          product.notUses = doc.data()['NotUses'];
          product.precautions = doc.data()['Precautions'];
          product.sideReactions = doc.data()['SideRecations'];
          product.ifCanUseWithoutPrescription =
              doc.data()['ifCanUseWithoutPrescription'];
          product.sideReactions = doc.data()['Warnings'];
          product.urlImage = doc.data()['urlImage'];
          product.quantity_limit = doc.data()['quantity_limit'];

          result.add(product);
        });

        return result;
      }
    });

    for (int i = 0; i < valuesPrpduct.length; i++) {
      Medicine object = new Medicine();

      object = await getAllDrugsQuantity(valuesPrpduct[i]);

      if (object != null) {
        resultAfterSearchQuantity[object.barcode] = object;
      } else {
        valuesPrpduct[i].original_price = 0.0;
        valuesPrpduct[i].price = 0.0;
        valuesPrpduct[i].choiceQuantity = 0;
        valuesPrpduct[i].basicQuantity = 0;
        valuesPrpduct[i].restOfAmount = 0;

        resultAfterSearchQuantity[valuesPrpduct[i].barcode] = valuesPrpduct[i];
      }
    }

    return resultAfterSearchQuantity;
  }

  makeMission(Map<String, Medicine> rest) {
    if (rest == null) {
      return null;
    }

    Map<String, List<Medicine>> classification =
        new Map<String, List<Medicine>>();

    for (int i = 0; i < rest.length; i++) {
      if (classification[rest.values.toList()[i].theraputicCategoires] ==
          null) {
        classification[rest.values.toList()[i].theraputicCategoires] =
            List<Medicine>.empty(growable: true);
      }
      classification[rest.values.toList()[i].theraputicCategoires]
          .add(rest.values.toList()[i]);
    }
    return classification;
  }
}
