import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e2ea/newModels/models/consumptionModel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

class consumption_tendency {
  List medicin_count = [];
  var max;
  var min;
  List medicins_max_final = [];
  List medicins_min_final = [];

  Future<Object> calculateHowMuchSaleProduct(Medicine medicine,var date1,var date2) async {
    int counter = 0;
  
    await FirebaseFirestore.instance.collection('bills').where('bill_date', isGreaterThanOrEqualTo: date1).where('bill_date',isLessThanOrEqualTo: date2).get().then((value) {
     

    });
  }

  Future<ConsumptionRateModel> calculate_max_consumption1() async {
    ConsumptionRateModel consumptionRate = new ConsumptionRateModel();
    await FirebaseFirestore.instance
        .collection('medicins')
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        medicin_count.add(element.data()['count_for_consumption']);
      });
    });
    max = medicin_count[0];

    consumptionRate.quantity = max;

    for (int i = 1; i < medicin_count.length; i++) {
      if (medicin_count != null && max < medicin_count[i])
        max = medicin_count[i];
    }
    consumptionRate.quantity = max.toInt();
    await FirebaseFirestore.instance
        .collection('medicins')
        .where('count_for_consumption', isEqualTo: max)
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        consumptionRate.name = element.data()['medicin_name'];
      });
    });
    return consumptionRate;
  }

  Future<ConsumptionRateModel> calculate_min_consumption1() async {
    ConsumptionRateModel consumptionRate = new ConsumptionRateModel();
    await FirebaseFirestore.instance
        .collection('medicins')
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        medicin_count.add(element.data()['count_for_consumption']);
      });
    });
    min = medicin_count[0];
  
    for (int i = 1; i < medicin_count.length; i++) {
      if (medicin_count != null && min > medicin_count[i])
        min = medicin_count[i];
    }
    consumptionRate.quantity = min.toInt();
    await FirebaseFirestore.instance
        .collection('medicins')
        .where('count_for_consumption', isEqualTo: min)
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        consumptionRate.name = element.data()['medicin_name'];
      });
    });
    return consumptionRate;
  }
}
