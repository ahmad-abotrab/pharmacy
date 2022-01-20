import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/calculationsAndInventory/limitNotification.dart';
import 'package:e2ea/newModels/models/billmodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';


class ReturnMid {
  Future<void> return0midwithbill(
      Bill bill, List<Medicine> medicine, List quantity) async {
    List mednames = [];
    int index;
    var newquan;
    List billmed = [];
    List billquan = [];
    List billquanid = [];
    List billprices = [];

    for (int i = 0; i < medicine.length; i++) {
      await FirebaseFirestore.instance
          .collection('medicins')
          .where('name', isEqualTo: medicine[i].getName())
          .get()
          .then((value) {
        value.docs.forEach((element) {
          mednames.add(element.data()['medicin_id']);
        });
      });
    }
    await FirebaseFirestore.instance
        .collection('Bill')
        .where('bill_id', isEqualTo: bill.getId())
        .get()
        .then((value) {
      print(value.docs.length);

      int sum;
      value.docs.forEach((element) async {
        billmed = List.from(await element.data()['medicin_id']);
        billquan = List.from(await element.data()['quantity_of_medicins']);
        billquanid = List.from(await element.data()['quantity_id']);
        billprices = List.from(await element.data()['prices_with_details']);
        for (int i = 0; i < mednames.length; i++) {
          for (int j = 0; j < billmed.length; j++) {
            print(billmed[j]);
            if (billmed[j] == mednames[i]) {
              index = j;
              print(index);
            }
          }
          billquan[index] = billquan[index] - quantity[i];

          if (billquan[index] == 0) {
            billquan.removeAt(index);
            billquanid.removeAt(index);
            billprices.removeAt(index);
            billmed.removeAt(index);
            element.reference.update({'quantity_of_medicins': billquan});
            element.reference.update({'quantity_id': billquanid});
            element.reference.update({'prices_with_details': billprices});
            element.reference.update({'medicin_id': billmed});
          } else {
            element.reference.update({'quantity_of_medicins': billquan});
          }
          await FirebaseFirestore.instance
              .collection('Quantity')
              .where('quantity_id', isEqualTo: billquanid[index])
              .get()
              .then((value) {
            value.docs.forEach((element) {
              newquan = (element.data()['quantity'] + quantity[i]);
              element.reference.update({'quantity': newquan});
            });
          });
        }

        double sum = 0;
        for (int k = 0; k < billmed.length; k++) {
          sum = sum + (billprices[k] * billquan[k]);
        }
        element.reference.update({'total_bill_price': sum});
      });
    });

    limitNotification y = new limitNotification();
    List<Medicine> l = [];
    l = await y.getT();
    for (int i = 0; i < l.length; i++) {
      print(l[i].getName());
      print(l[i].getQuantity());
    }
  }
}
