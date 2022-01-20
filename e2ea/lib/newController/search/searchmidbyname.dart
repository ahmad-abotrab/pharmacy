import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/search/search.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

class SearchMidByName implements Search {
  @override
  List<Object> getinfo;

  Future<List<Object>> searching(name, {v2}) async {
    List<Medicine> temp = [];

    return await FirebaseFirestore.instance.collection('medicins').get()
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
          product.setOriginalPrice(double.parse(doc.data()['original_price']));
          product.setManifacture(doc.data()['manufacture_company']);
          temp.add(product);
        });
        return temp;
      }
    });
  }

  @override
  Future<List<Medicine>> searchingWithOneParamerter(v1) async {
    List<Medicine> temp = [];

    return await FirebaseFirestore.instance
        .collection('medicins')
        .get()
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
          temp.add(product);
        });

        return temp.where((employee) {
          final nameLower = employee.name.toLowerCase();
          final queryLower = v1.toLowerCase();
          return nameLower.contains(queryLower);
        }).toList();
      } else
        return [];
    });
  }
}
