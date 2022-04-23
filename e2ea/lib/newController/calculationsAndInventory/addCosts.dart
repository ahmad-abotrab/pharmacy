import 'package:cloud_firestore/cloud_firestore.dart';

class add_costs {
  enter_costs(List costsBill, DateTime date) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('CostBill').doc();
    await ref.set({
      'costBill_id': ref.id,
      'Date': date,
      'Costs': costsBill,
    });
  }
}
