import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class AccountsOp {
  String errorMessage;
  User user;
  authProblems errorType;
  Future<String> signIn(String email, String password) async {
    String errorMessage;
    User user;

    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = result.user;
      email = user.email;
      errorMessage = 'correct';
    } catch (error) {
      //print(error);
      switch (error.message) {
        case 'user-not-found':
          {
            errorMessage = authProblems.UserNotFound.toString();
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
        // ...
        default:
          print('Case ${error.message} is not yet implemented');
          return 'Case ${error.message} is not yet implemented';
      }
    }

    return 'The error is :' + errorMessage;
  }

  Future<String> addEmployeeProc(
      String email,
      String password,
      String employee_name,
      String employee_phone,
      int employee_workhour,
      double employee_salary) async {
    try {
      List<String> subname = employee_name.split(' ');
      List<String> indexlist = [];

      for (int i = 0; i <= subname.length; i++) {
        for (int j = 0; j <= subname[i].length + i; j++) {
          indexlist.add(subname[i].substring(0, j).toLowerCase());
        }
        authProblems errorType;

        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        var firebaseUser = await FirebaseAuth.instance.currentUser;
        var user = await firebaseUser.uid;
        //print(firebaseUser);
        await FirebaseFirestore.instance.collection('Employee').doc(user).set({
          'employee_name': employee_name,
          'index_key2': indexlist,
          'employee_phone': employee_phone,
          'employee_workhour': employee_workhour,
          'employee_salary': employee_salary,
          'employee_email': firebaseUser.email,
          'employee_password': password,
          'employee_id': user
        });
      }
    } catch (error) {
      //print(error);
      switch (error.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          errorType = authProblems.UserNotFound;
          break;
        case 'The password is invalid or the user does not have a password.':
          errorType = authProblems.PasswordNotValid;
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          errorType = authProblems.NetworkError;
          break;
        default:
          print('Case ${error.message} is not yet implemented');
          return 'Case ${error.message} is not yet implemented';
      }
    }
    print('The error is $errorType');
    return 'The error is $errorType';

    void logoutproc() {
      FirebaseAuth.instance.signOut();
      print('logout successfully!!!');
    }
  }
}

void deleteemplotee(String empname) {
  FirebaseFirestore.instance
      .collection('Employee')
      .where('employee_name', isEqualTo: empname)
      .get()
      .then((value) {
    value.docs.forEach((doc) async {
      doc.reference.update({'employee_email': 'null'});
      doc.reference.update({'employee_password': 'null'});
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: doc.data()['employee_email'],
          password: doc.data()['employee_password']);
      User user = FirebaseAuth.instance.currentUser;
      await user.delete();
    });
  });
}
