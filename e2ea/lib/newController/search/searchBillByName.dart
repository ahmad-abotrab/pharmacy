import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/search/search.dart';
import 'package:e2ea/newModels/models/billmodel.dart';
import 'package:e2ea/newModels/models/customermodel.dart';
import 'package:e2ea/newModels/models/employemodel.dart';


class SearchBillByName implements Search {
  @override
  List<Object> getinfo;
  List f = [
    {'no data found'}
  ];
  Future<List<Bill>> searching(name, {v2}) async {
    List<Bill> temp = [];

    await Future<String>.delayed(const Duration(seconds: 1));

    return await FirebaseFirestore.instance
        .collection('bills')
        .where("customer_name", isEqualTo: name)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) async {
          Bill bill = new Bill();
          Customer customer = new Customer();
          Employee employee = new Employee();
          List<Object> list = [];
          //bill.setDate(doc.data()['bill_date']);
          customer.setName(doc.data()['customer_name']);
          bill.setCustomer(customer);
          employee.setId(doc.data()['employee_id']);
          bill.setEmployee(employee);
          list.add(doc.data()['medicin_id']);
          bill.setBasket(list);
          bill.setTotal_price(double.parse(doc.data()['total_bill_price']));
          temp.add(bill);
        });
        return temp;
      } else
        return [];
    });
  }

  @override
  Future<Object> searchingWithOneParamerter(v1) {
    // TODO: implement searchingWithOneParamerter
    throw UnimplementedError();
  }
}
