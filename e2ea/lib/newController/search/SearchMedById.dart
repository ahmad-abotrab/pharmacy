import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/search/search.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

class SearchMidByID implements Search {
  @override
  List<Object> getinfo;

  Future<List<Object>> searching(id, {v2}) async {
    List<Medicine> temp = [];

    return await FirebaseFirestore.instance
        .collection('medicins')
        .where("medicin_id", isEqualTo: id)
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
          product.setOriginalPrice(doc.data()['original_price']);
          product.setManifacture(doc.data()['manufacture_company']);
          temp.add(product);
        });
        return temp;
      }
    });
  }

  @override
  Future<Object> searchingWithOneParamerter(v1) {
    // TODO: implement searchingWithOneParamerter
    throw UnimplementedError();
  }
}
