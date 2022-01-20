import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/search/search.dart';
import 'package:e2ea/newModels/models/billmodel.dart';
import 'package:e2ea/newModels/models/customermodel.dart';
import 'package:e2ea/newModels/models/employemodel.dart';

class SearchBillBetweendates implements Search {
  @override
  List<Bill> finalres = [];
  List<Object> getinfo;
  Bill bill = new Bill();
  Customer customer = new Customer();
  Employee employee = new Employee();
  List list = [];
  List listQuantity = [];
 
  //// function will return it if ther is no data between this two dates
  @override
  Future<List<Bill>> searching(date1, {v2}) async {
    if (date1 != '' && v2 != '' && date1 != null && v2 != null) {
      QuerySnapshot getbilldataInRange = await FirebaseFirestore.instance
          .collection('bills')
          .where('bill_date', isGreaterThanOrEqualTo: date1)
          .where('bill_date', isLessThanOrEqualTo: v2)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          value.docs.forEach((doc) {
            bill.id = doc.data()['bill_id'];
            customer.setName(doc.data()['customer_name']);
            bill.setCustomer(customer);
            employee.setId(doc.data()['employee_id']);
            bill.setEmployee(employee);
            list.add(doc.data()['medicin_id']);

            bill.setBasket(list);
            listQuantity.add(doc.data()['quantity_of_medicins']);
            bill.quantityList = listQuantity;

            // bill.quantityList.addAll(listQuantity != null ? listQuantity :[]);
            bill.setTotal_price(double.parse(doc.data()['total_bill_price']));
            bill.date = doc.data()['bill_date'];
            finalres.add(bill);
          });
          print(finalres.length);
        }
      });

      return finalres;
    } else
      return [];
  }

  @override
  Future<Object> searchingWithOneParamerter(v1) {
    // TODO: implement searchingWithOneParamerter
    throw UnimplementedError();
  }
}
