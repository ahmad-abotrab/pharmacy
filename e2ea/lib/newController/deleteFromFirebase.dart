import 'package:cloud_firestore/cloud_firestore.dart';


class DeleteFromFirebase {
  deleteFormFirebase(dynamic object, String collectionPath) async {
    await FirebaseFirestore.instance
      ..collection(collectionPath).doc(object.id).delete();
  }
}
