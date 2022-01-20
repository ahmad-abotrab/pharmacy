
// import 'package:last/src/models/billmodel.dart';
// import 'package:last/src/models/employemodel.dart';
// import 'package:last/src/models/medicinmodel.dart';
// import 'package:last/src/search/search.dart';
// import 'package:last/src/search/searchBillByEmployee.dart';
// import 'package:last/src/search/searchBillByName.dart';
// import 'package:last/src/search/searchEmployeeName.dart';
// import 'package:last/src/search/searchbillbetween.dart';
// import 'package:last/src/search/searchmidbyname.dart';
// class AllSearchName extends Search {
//   List<Object> searchResult = [];
//   @override
//   Future<List<Object>> searching(v1, {v2}) async {
//     Search s = new SearchEmployee();
//     Search s1 = new SearchMidByName();
//     Search s2 = new SearchBillByName();
//     Search s3 = new SearchBillByEmployee();

//     List<Object> nums = [];
//     List<Medicine> med = [];
//     List<Bill> billname = [];
//     List<Bill> billemp = [];
//     List<Employee> emp = [];

//     med = await s1.searching(v1) as List<Medicine>;
//     billname = await s2.searching(v1) as List<Bill>;
//     billemp = await s3.searching(v1) as List<Bill>;
//     emp = await s.searching(v1) as List<Employee>;

//     if (med != null) {
//       for (int i = 0; i < med.length; i++) {
//         nums.add(med[i]);
//       }
//     }
//     if (billname != null) {
//       for (int j = 0; j < billname.length; j++) {
//         nums.add(billname[j]);
//       }
//     }
//     if (billemp != null) {
//       for (int k = 0; k < billemp.length; k++) {
//         nums.add(billemp[k]);
//       }
//     }

//     if (emp != null) {
//       for (int c = 0; c < emp.length; c++) {
//         nums.add(emp[c]);
//       }
//     }

//     if (nums != null) {
//       searchResult
//           .add(nums.reduce((curr, next) => curr.toString() + next.toString()));
//       return nums;
//     } else
//       return [];
//   }
// }