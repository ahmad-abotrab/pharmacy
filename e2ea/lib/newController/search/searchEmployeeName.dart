import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/search/search.dart';
import 'package:e2ea/newModels/models/employemodel.dart';

class SearchEmployee implements Search {
  @override
  List<Object> getinfo;

  Future<List<Employee>> searching(name, {v2}) async {
    await Future<String>.delayed(const Duration(seconds: 1));
  }

  @override
  Future<List<Employee>> searchingWithOneParamerter(v1) async {
    List<Employee> temp = [];
    return await FirebaseFirestore.instance
        .collection('Employee')
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
          temp.add(employee);
        });

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
