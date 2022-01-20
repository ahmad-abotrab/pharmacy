import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/search/search.dart';
import 'package:e2ea/newModels/models/billmodel.dart';
import 'package:e2ea/newModels/models/customermodel.dart';
import 'package:e2ea/newModels/models/employemodel.dart';


class SearchBillByEmployee implements Search {
  @override
  List<Object> getinfo;

  Future<List<Bill>> searching(name, {v2}) async {
    List<Bill> temp = [];

    var employeeid;
    var s = await FirebaseFirestore.instance
        .collection('Employee')
        .where("index_key2", arrayContains:name)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          employeeid = element.data()['employee_id'];
        });
      }
    });

    if (employeeid != null && name != '') {
      return await FirebaseFirestore.instance
          .collection('billS')
          .where("employee_id", isEqualTo: employeeid)
          .get()
          .then((doc) async {
        if (doc.docs.isNotEmpty) {
          doc.docs.forEach((doc) async {
            Customer customer = new Customer();
            Bill bill = new Bill();
            Employee employee = new Employee();
            List<Object> list = [];
            customer.setName(doc.data()['customer_name']);
            bill.setCustomer(customer);
            employee.setId(doc.data()['employee_id']);
            bill.setEmployee(employee);
            list.add(doc.data()['medicin_id']);
            bill.setBasket(list);
            bill.setTotal_price(doc.data()['total_bill_price']);
            temp.add(bill);
          });
          return temp;
        } else
          return [];
      });
    }
  }

  @override
  Future<Object> searchingWithOneParamerter(v1) {
    // TODO: implement searchingWithOneParamerter
    throw UnimplementedError();
  }
}

