import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class expireDateNotification {
  Future<List<Medicine>> getNot() async {
    List medsName = [];
    List medsId = [];
    List<Medicine> result = [];
    List quanid = [];

    await FirebaseFirestore.instance.collection('medicins').get().then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          medsId.add(doc.data()['medicin_id']);
          medsName.add(doc.data()['medicin_name']);
        });
      }
    });

    for (int i = 0; i < medsName.length; i++) {
          await FirebaseFirestore.instance
          .collection('quantity')
          .where('product_id', isEqualTo: medsId[i])
          .get()
          .then((value) {
           value.docs.forEach((element) {
           if (DateTime.now().isAfter((element.data()['expire_date'].toDate())) &&
              (element.data()['quantity'])!= 0 ) {
            print('kkkkkkkkoj');
            Medicine newmed = Medicine();
            newmed.setName(medsName[i]);
            newmed.setId(medsId[i]);
            newmed.setQuantity(element.data()['quantity']);
            newmed.setExpire(element.data()['expire_date']);
            newmed.setOriginalPrice(element.data()['original_price']);
            result.add(newmed);
            
            print(result.length);
            quanid.add(element.data()['quantity_id']);
            element.reference.update({'quantity': 0});
         
          }
    
        });
                print('oj');
      });
    }

    print(result.length);
    for (int i = 0; i < result.length; i++) {
      //print(result[i].getName());
      DocumentReference newexpire =
          await FirebaseFirestore.instance.collection('Expired').doc();
      newexpire.set({
        'date_enterd_intoExpire':DateTime.now(),
        'medicin_name': result[i].getName(),
        'medicin_id': result[i].getId(),
        'quantity': result[i].getQuantity(),
        'quantity_id': quanid[i],
        'original_price': result[i].getOriginalPrice(),
        'expire_date': result[i].getExpire()

      });
     
    }
 print(result);
    return result;
  }
}
