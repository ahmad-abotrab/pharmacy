import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateTables extends StatelessWidget {
  const CreateTables({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(
            children: [
              MaterialButton(
                onPressed: () async {
                  List indexKeyTemp = [];
                  List indexKey = [];

                  String s = 'Hexol 2';
                  String theraputicCategories = 'الأدوية العصبية';
                  List<String> composition = [
                    'Benzhexole HCl 2 mg',
                  ];
                  for (var i = s.length; i >= 1; i--) {
                    indexKeyTemp.add(s.substring(0, i));
                  }
                  for (var i = indexKeyTemp.length - 1; i >= 0; i--) {
                    indexKey.add(indexKeyTemp[i]);
                  }
                  DocumentReference ref =  FirebaseFirestore.instance
                      .collection('testDate')
                      .doc();
                  ref.set({
                    'index_key': DateTime.now(),
            
                  });
                },
                child: Text("Add Medicen Table"),
              ),
              MaterialButton(
                onPressed: () async {
                  var firebaseUser =  FirebaseAuth.instance.currentUser;
                  var user =  firebaseUser.uid;
                  print(firebaseUser);
                  await FirebaseFirestore.instance
                      .collection('Employee')
                      .doc(user)
                      .set({
                    'employee_id': 'user',
                    'employee_email': firebaseUser.email,
                    'state': 'state',
                    'employee_name': 'name',
                    'employee_phone': 'phone',
                    'employee_sex': 'dropdownValue',
                    'employee_startWork': 'pickedDate',
                    'employee_worksHour': 'enabledCheckByHourSalary',
                    'employee_costOfHourWork': 'costOfHour',
                    'employee_salary': 'salary',
                  });
                },
                child: Text("Add Employee Table"),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text("Add Sentific Table"),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text("Add Bill Table"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class addNewPrpduct {
//   Product medicine;

//   addProdyct(
//       String medname, double medoriginal, double quan, String manufacturecom,
//       {String stored,
//       List<String> components,
//       String warnings,
//       DateTime expire,
//       int medprice}) async {
//     List<String> indexlist = [];

//     DocumentReference ref =
//         await FirebaseFirestore.instance.collection('medicins').doc();
//     medicine.setId(ref.id);
//     for (int i = 1; i < medname.length + 1; i++) {
//       indexlist.add(medname.substring(0, i).toLowerCase());
//     }

//     ref.set({
//       'index_key': indexlist,
//       'medicin_id': medicine.getId(),
//       'medicin_name': medicine.getName(),
//       'medicin_price': medicine.getPrice(),
//       'original_price': medicine.getOriginalPrice(),
//       'manufacture_company': medicine.getManifacture(),
//     });
//   }
// }
