import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/search/search.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';


class SearchByBarcode extends Search {
  Future<List<Medicine>> getUserSugesstions(String query) async {
    final List<Medicine> result = [];

    return await FirebaseFirestore.instance
        .collection('medicins')
        .where('Barcode', isEqualTo: query)
        .get()
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
          result.add(product);
        });

        return result;
      }
    });
  }
    @override
  Future<Object> searchingWithOneParamerter(v1) {
 
  }

  @override
  Future<Object> searching(v1, {v2}) {
    // TODO: implement searching
    throw UnimplementedError();
  }
}
