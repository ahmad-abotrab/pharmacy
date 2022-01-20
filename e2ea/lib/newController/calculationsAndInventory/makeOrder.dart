import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newModels/models/billmodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

import 'addMedicin.dart';

class addOrderBill {
/////////////////////////////////////////////////////////////////////////////////
  Future<void> addquan(Medicine medicine, String order_id) async {
    DocumentReference thisquan =
        await FirebaseFirestore.instance.collection('quantity').doc();
    thisquan.set({
      'quantity_id': thisquan.id,
      'quantity': medicine.getQuantity(),
      'orderbill_date': DateTime.now(),
      'orderbill_id': order_id,
      'original_price': medicine.getOriginalPrice(),
      'product_id': medicine.getId(),
      'price': medicine.getPrice(),
      'expire_date': medicine.getExpire(),
    });
  }

//////////////////////////////////////////////////////////////////////////////////
  Future<void> orderbill(Bill bill) async {
    DocumentReference col_bill =
        await FirebaseFirestore.instance.collection('Order-bill').doc();
    var elem;
    var q = 0;
    var fetchmed;
    List fetchid = [];
    List fetchprice = [];
    List fetchquan = [];
    double sum = 0;
    //update medicine price and original price to collection medicine
    for (int i = 0; i < bill.basket.length; i++) {
      await FirebaseFirestore.instance
          .collection('medicins')
          .doc((bill.basket[i] as Medicine).getId())
          .update({
        'price': (bill.basket[i] as Medicine).getPrice(),
        'original_price': (bill.basket[i] as Medicine).getOriginalPrice()
      });
    }
    QuerySnapshot fetch_emp = await FirebaseFirestore.instance
        .collection('Employee')
        .where('employee_name', isEqualTo: bill.getEmployee().getName())
        .get()
        .then((value) {
      value.docs.forEach((element) {
        elem = element.data()['employee_id'];
      });
    });
    for (int i = 0; i < bill.getBasket().length; i++) {
      await FirebaseFirestore.instance
          .collection('medicins')
          .where('medicin_name',
              isEqualTo: (bill.basket[i] as Medicine).getName())
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          value.docs.forEach((element) {
            (bill.basket[i] as Medicine).setId(element.data()['medicin_id']);
            fetchid.add(element.data()['medicin_id']);
            fetchprice.add(element.data()['original_price']);
            var price = element.data()['original_price'];
            if (price != (bill.basket[i] as Medicine).getOriginalPrice()) {
              element.reference.update({
                'original_price': (bill.basket[i] as Medicine).original_price
              });
              fetchprice.length--;
              fetchprice.add(element.data()['original_price']);
            }
            print('quantity limit is  : ' +
                bill.basket[i].quantity_limit.toString());
            addquan(bill.basket[i], col_bill.id);
          });
        } else {
          Medicine y = new Medicine();
          y.setName((bill.basket[i] as Medicine).getName());
          y.setManifacture((bill.basket[i] as Medicine).getManifacture());
          // y.setExpire(bill.basket[i].getExpire());
          y.setOriginalPrice((bill.basket[i] as Medicine).getOriginalPrice());
          // y.setPrice(bill.basket[i].getPrice());
          y.setQuantity((bill.basket[i] as Medicine).getQuantity());
          // y.setStored(bill.basket[i].getStored());
          //y.setWarnings(bill.basket[i].getWarnings());
          // await y.uploadata(y);

          addNewPrpduct().addProdyct(y);

          var med = await FirebaseFirestore.instance
              .collection('medicins')
              .where('medicin_name',
                  isEqualTo: (bill.basket[i] as Medicine).getName())
              .get()
              .then((value) {
            value.docs.forEach((element) {
              fetchid.add(element.data()['medicin_id']);
              y.setId(element.data()['medicin_id']);
              fetchprice.add(element.data()['original_price']);
              print(fetchid);
              addquan(y, col_bill.id);
            });
          });
        }
      });
    }

    for (int i = 0; i < bill.basket.length; i++) {
      await FirebaseFirestore.instance
          .collection('medicins')
          .doc(bill.basket[i].id)
          .update({
        'quantity_limit': bill.basket[i].quantity_limit,
      });
    }
    for (int i = 0; i < bill.basket.length; i++) {
      sum = (sum +
          ((bill.basket[i] as Medicine).getQuantity() *
              (bill.basket[i] as Medicine).getOriginalPrice()));
    }
    for (int j = 0; j < bill.basket.length; j++) {
      fetchquan.add((bill.basket[j] as Medicine).getQuantity());
    }
    await col_bill.set({
      'orderbill_id': col_bill.id,
      'bill_date': DateTime.now(),
      'bill_type': bill.getType(),
      'employee_id': elem,
      'company_name': (bill.basket[0] as Medicine).getManifacture(),
      'medicin_id': fetchid,
      'prices': fetchprice,
      'quantitiy': fetchquan,
      'total_bill_price': sum
    });
  }
}
