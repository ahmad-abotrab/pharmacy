import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

class limitNotification {
  Future<List<Medicine>> getT() async {
    List medsName = [];
    List medsLimit = [];
    List medsId = [];
    List<Medicine> result = [];

    await FirebaseFirestore.instance.collection('medicins').get().then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          medsLimit.add(doc.data()['quantity_limit']!=null?doc.data()['quantity_limit']:0);
          medsId.add(doc.data()['medicin_id']);
          medsName.add(doc.data()['medicin_name']);
        });
      }
    });
    print(medsId.length);
   
    for (int i = 0; i < medsId.length; i++) {
      var quansum = 0;
      await FirebaseFirestore.instance
          .collection('quantity')
          .where('product_id', isEqualTo: medsId[i])
          .get()
          .then((value) {
        value.docs.forEach((element) {
          quansum = quansum + element.data()['quantity'];
        });
        if (medsLimit[i] >= quansum) {
          Medicine newmed = Medicine();
          newmed.setName(medsName[i]);
          newmed.setQuantity(quansum);
          result.add(newmed);
        }
      });
    }
    return result;
  }
}
