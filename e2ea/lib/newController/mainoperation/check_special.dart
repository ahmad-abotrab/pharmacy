import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newModels/models/employemodel.dart';

class checks {
  int check = 0;
  void update_option_employee(
      Employee employee ,var map_impression) async {
    await FirebaseFirestore.instance.collection('Employee').doc(employee.id).update({
      'impression_map': map_impression
    });
    ////update the value for this employee
    // await FirebaseFirestore.instance
    //     .collection('Employee')
    //     .where('employee_email', isEqualTo: employee_email)
    //     .get()
    //     .then((value) {
    //   value.docs.forEach((element) {
    //     element.reference.update({'map_impression.$option': new_value});
    //   });
    // });
  }

  Future<bool> check_earnings_for_admin(String employee_email) async {
    List<Map<String, dynamic>> translate_toList1 = [];
    bool variable;

    await FirebaseFirestore.instance
        .collection('Employee')
        .where('employee_email', isEqualTo: employee_email)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          translate_toList1.add(doc.data()['map_impression']);
        });
      }
    });
    translate_toList1.forEach((val) => variable = val['earnings']);
    print(translate_toList1);

    if (variable == true)
      return true;
    else
      return false;
  }

  Future<Object> checkeddWhatNewAccessibility(String employee_email) async {
    Map<String, dynamic> newAccessibility = await FirebaseFirestore.instance
        .collection('Employee')
        .where('employee_email', isEqualTo: employee_email)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        Map<String, dynamic> newAccessibility1 = {};
        value.docs.forEach((doc) {
          newAccessibility1 = doc.data()['map_impression'];
        });
        return newAccessibility1;
      } else {
        return {};
      }
    });
    return newAccessibility;
  }

  Future<bool> check_report_for_admin(String employee_email) async {
    List<Map<String, dynamic>> translate_toList2 = [];
    bool variable;

    await FirebaseFirestore.instance
        .collection('Employee')
        .where('employee_email', isEqualTo: employee_email)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          translate_toList2.add(doc.data()['map_impression']);
        });
      }
    });
    translate_toList2.forEach((val) => variable = val['repots']);
    print(translate_toList2);

    if (variable == true)
      return true;
    else
      return false;
  }
}
