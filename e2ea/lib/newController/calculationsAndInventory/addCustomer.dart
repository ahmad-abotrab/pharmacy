import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newModels/models/customermodel.dart';

class addcustomer {
  String customername;
  void customeradd(Customer customer) async {
    DocumentReference newcustomer =
        await FirebaseFirestore.instance.collection('customer').doc();
    newcustomer.set({
      'customer_id': newcustomer.id,
      'name_customer': customer.name,
      'notes': customer.notice,
      'bills': customer.bills,
    });
  }

  void customerupdate(Customer customer) async {
    DocumentReference newcustomer =
        await FirebaseFirestore.instance.collection('customer').doc(customer.id);
    newcustomer.update({
      'customer_id': newcustomer.id,
      'name_customer': customer.name,
      'notes': customer.notice,
      'bills': customer.bills,
    });
  }
}
