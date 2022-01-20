import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

class addNewPrpduct {
  Medicine medicine = new Medicine();

  addProdyct(Medicine medicine) async {
    //List<String> indexlist = [];

    DocumentReference ref =
        await FirebaseFirestore.instance.collection('medicins').doc();
    medicine.setId(ref.id);

    ref.set({
      //'index_key': indexlist,
      'medicin_id': medicine.getId(),
      'medicin_name': medicine.getName(),
      'medicin_price': medicine.getPrice(),
      'original_price': medicine.getOriginalPrice(),
      'manufacturecompany': medicine.manufactureCompany,
      'quantity_limit': medicine.get_quantity_limit(),
      'count_for_consumption': 0,
      'Barcode': medicine.getbarcode(),
      'Theraputic Categories': medicine.getTheraputicCategoires(),
      'From': medicine.getFrom(),
      'Packing': medicine.getPacking(),
      'Indications': medicine.getIndications(),
      'NotUses': medicine.getNotUses(),
      'Precautions': medicine.getPrecautions(),
      'Warnings': medicine.getWarnings(),
      'SideRecations': medicine.getSideReactions(),
      'Composition': medicine.getComposition(),
      'urlImage': medicine.getUrlImage(),
    });
  }

  updateProduct(Medicine medicine) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection('medicins')
        .doc(medicine.id);

    // for (int i = 1; i < medicine.getName().length + 1; i++) {
    //   indexlist.add(medicine.getName().substring(0, i).toLowerCase());
    // }

    ref.update({
      //'index_key': indexlist,
      'medicin_id': medicine.getId(),
      'medicin_name': medicine.getName(),
      'medicin_price': medicine.getPrice(),
      'original_price': medicine.getOriginalPrice(),
      'manufacture_company': medicine.getManifacture(),
      'quantity_limit': medicine.get_quantity_limit(),
      'count_for_consumption': 0,
      'Barcode': medicine.getbarcode(),
      'Theraputic Categories': medicine.getTheraputicCategoires(),
      'From': medicine.getFrom(),
      'Packing': medicine.getPacking(),
      'Indications': medicine.getIndications(),
      'NotUses': medicine.getNotUses(),
      'Precautions': medicine.getPrecautions(),
      'Warnings': medicine.getWarnings(),
      'SideRecations': medicine.getSideReactions(),
      'Composition': medicine.getComposition(),
      'urlImage': medicine.getUrlImage(),
    });
  }
}
