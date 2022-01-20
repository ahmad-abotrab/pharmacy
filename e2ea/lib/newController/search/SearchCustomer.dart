import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/search/search.dart';
import 'package:e2ea/newModels/models/customermodel.dart';

class SearchCustomer implements Search {
  @override
  List<Object> getinfo;

  @override
  Future<Object> searching(v1, {v2}) {}
  @override
  Future<List<Customer>> searchingWithOneParamerter(v1) async {
    List<Customer> temp = [];
    return await FirebaseFirestore.instance
        .collection('Customer')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          Customer customer = new Customer();
          customer.id = doc.data()["id"];
          customer.name = doc.data()["name"];
          customer.notice = doc.data()["notes"];
          customer.bills = doc.data()["bills"];
          print(customer.name);
          temp.add(customer);
        });
        print('length is temp customer ' + temp.length.toString());

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
