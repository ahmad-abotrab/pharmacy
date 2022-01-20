import 'package:cloud_firestore/cloud_firestore.dart';

class DailyBoxCalc {
  Future<double> calculation(var dailyDate, var dailyDate2) async {
    List<double> e = [];
    double result = 0;
    if (dailyDate != '' && dailyDate != null) {
      QuerySnapshot f = await FirebaseFirestore.instance
          .collection('bills')
          .where('bill_date', isGreaterThanOrEqualTo: dailyDate)
          .where('bill_date', isLessThanOrEqualTo: dailyDate2)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          e.add(double.parse(element.data()['total_bill_price']));
          return e;
        });
      });
      for (int i = 0; i < e.length; i++) result = result + e[i];
    }
    return result;
  }
}
