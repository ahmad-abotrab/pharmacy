import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/search/search.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

class SearchMidByScientificWay implements Search {
  @override
  List<Object> getinfo;
  List f = [
    {'no data found'}
  ];
  Future<List<Medicine>> searching(name, {v2}) async {}

  @override
  Future<List<Medicine>> searchingWithOneParamerter(v1) async {
    List<Medicine> temp = [];

    return await FirebaseFirestore.instance
        .collection('medicins')
        .get()
        .then((value) {
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
          product.warnings = doc.data()['Warnings'];
          product.urlImage = doc.data()['urlImage'];
          product.setOriginalPrice(double.parse(doc.data()['original_price']));
          product.setManifacture(doc.data()['manufacture_company']);
          temp.add(product);
        });

        ///here after i get all medicine filttered it by composition
        /// fittered mission is : get all composition and check if searching characher is contiain in one of it
        return temp.where((element) {
          final nameLower = [];
          for (int i = 0; i < element.composition.length; i++) {
            nameLower.add(element.composition[i].toLowerCase());
            nameLower[i]
                .substring(nameLower[i].length - 3, nameLower[i].length);
          }

          final queryLower = v1.toLowerCase();
          bool ifIt = false;

          for (int i = 0; i < nameLower.length; i++) {
            if (nameLower[i].contains(queryLower)) {
              ifIt = true;
              break;
            }
          }
          print(ifIt);
          return ifIt;
        }).toList();
      } else
        return [];
    });
  }
}
