import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String name;
  String id;
  DateTime date;
  String insurance;
  List notice;
  List bills;

  Customer({
    this.name,
    this.id,
    this.date,
    this.insurance,
    this.notice,
    this.bills,
  });
  void setName(String name) {
    this.name = name;
  }

  void setId(String id) {
    this.id = id;
  }

  void setDateOfBirth(DateTime date) {
    this.date = date;
  }

  void setInsurance(String insurance) {
    this.insurance = insurance;
  }

  void set_notice(List notice) {
    this.notice = notice;
  }

  String getName() {
    return name;
  }

  String getId() {
    return id;
  }

  DateTime getDateOfBirth() {
    return date;
  }

  String getInsurance() {
    return insurance;
  }

  List get_notice() {
    return notice;
  }

  uploadata(Customer customer) async {
    List indexlist = new List();
    List indexkey = new List();
    DocumentReference ref =
        await FirebaseFirestore.instance.collection('customer').doc();
    for (int i = 1; i < customer.getName().length + 1; i++) {
      indexlist.add(customer.getName().substring(0, i).toLowerCase());
    }
    for (int i = 1; i < customer.getInsurance().length + 1; i++) {
      indexkey.add(customer.getInsurance().substring(0, i).toLowerCase());
    }
    ref.set({
      'index_name': indexlist,
      'customer_id': ref.id,
      'customer_name': customer.name,
      'insurance_company': customer.insurance,
      'customer_notice': customer.get_notice()
    });
  }
}
