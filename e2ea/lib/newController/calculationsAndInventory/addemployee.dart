import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newModels/models/employemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum authProblems { EmailyIsAlreadyTaken, PasswordNotValid, NetworkError }

class addNewEmplpoyee {
  Future<String> addEmployeeProc(Employee employee) async {
    String errorMessage;
    try {
     
      List<String> indexlist = [];

      for (int i = 0; i < employee.getName().length; i++) {
        for (int j = 0; j <= employee.getName().length + i; j++) {
          indexlist.add(employee.getName()[i].substring(0, j).toLowerCase());
        }
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: employee.getEmail(), password: employee.getPassword());

        var firebaseUser = await FirebaseAuth.instance.currentUser;
        var user = await firebaseUser.uid;
        //print(firebaseUser);
        await FirebaseFirestore.instance.collection('Employee').doc(user).set({
          'employee_name': employee.getName(),
          'index_key2': indexlist,
          'employee_phone': employee.getPhoneNumber(),
          'employee_workhour': employee.getWorkHours(),
          'employee_salary': employee.getSalary(),
          'employee_email': firebaseUser.email,
          'employee_id': user,
          'map_impression': employee.getMap()
        });
      }
      errorMessage = 'correct';
    } catch (error) {
      //print(error);
      switch (error.message) {
        case 'email-already-in-use':
          {
            errorMessage = authProblems.EmailyIsAlreadyTaken.toString();
            break;
          }
        case 'wrong-password':
          {
            errorMessage = authProblems.PasswordNotValid.toString();
            break;
          }
        case 'network-request-failed':
          {
            errorMessage = authProblems.NetworkError.toString();
            break;
          }
        default:
          {
            errorMessage = error.message;
          }
      }
    }
    return errorMessage;
  }
}
