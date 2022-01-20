import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/search/search.dart';
import 'package:e2ea/newModels/models/employemodel.dart';

class SearchEmployeeByEmail implements Search {
  @override
  List<Object> getinfo;

  Future<List<Employee>> searching(name, {v2}) async {
    List<Employee> temp = [];
    return await FirebaseFirestore.instance
        .collection('Employee')
        .where("employee_email", isEqualTo: name)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          Employee employee = new Employee();
          employee.setId(doc.data()['employee_id']);
          employee.setName(doc.data()['employee_name']);
          employee.setEmail(doc.data()['employee_email']);
          employee.setPhoneNumber(doc.data()['employee_phone']);
          employee.setHours(doc.data()['employee_workhour']);
          employee.set_impression(doc.data()['impression_map']);
          employee.state = doc.data()['state'];
          //employee.setSalary(doc.data()['employee_salary']);
          temp.add(employee);
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
