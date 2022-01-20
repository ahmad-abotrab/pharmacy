import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newModels/models/billmodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

class MakeBill {
  List<String> customernames = [];
  int count = 0;
  var variable;
  var el;
  List bill_ref = [];
  var id_cust;
  void bill(Bill bill, bool s) async {
    // if (bill.customer != null) {
    //   List billsForCustomer = await FirebaseFirestore.instance
    //       .collection('Customer')
    //       .where("name", isEqualTo: bill.customer.name)
    //       .get()
    //       .then((value) {
    //     List bills = [];
    //     value.docs.forEach((element) {
    //       bills = element.data()['bills'];
    //     });
    //     return bills;
    //   });
    //   if (billsForCustomer == null) {
    //     billsForCustomer = [];
    //     billsForCustomer.add(bill);
    //   }
    //   else{
    //     billsForCustomer.add(bill);
    //   }

    //   await FirebaseFirestore.instance
    //       .collection('Customer')
    //       .doc(bill.customer.id)
    //       .update({
    //     'bills': billsForCustomer,
    //   });
    // }
    
    var elem;
    DocumentReference col_bill =
        await FirebaseFirestore.instance.collection('bills').doc(bill.id);
    List fetchquan = [];
    List<String> fetchid = [];
    List fetchprice = [];
    List details_result = [];
    double sum = 0.0;
    var fetch_emp = await FirebaseFirestore.instance
        .collection('Employee')
        .where('employee_name', isEqualTo: bill.getEmployee().getName())
        .get()
        .then((value) {
      value.docs.forEach((element) {
        elem = element.data()['employee_id'];
      });
    });
    for (int i = 0; i < bill.getBasket().length; i++) {
      // print('sdfghgwserfgf');
      // print((bill.basket[0] as Medicine).getName());

      await FirebaseFirestore.instance
          .collection('medicins')
          .where("medicin_name",
              isEqualTo: (bill.basket[i] as Medicine).getName())
          .get()
          .then((value) {
        value.docs.forEach((element) async {
          // print('towwwww');
          if (DateTime.now().day == 1 && DateTime.now().hour < 9) {
            await FirebaseFirestore.instance
                .collection('medicins')
                .get()
                .then((value) {
              value.docs.forEach((element1) {
                element1.reference.update({'count_for_consumption': 0});
              });
            });
          }
          fetchid.add(element.data()['medicin_id']);
          fetchprice.add(element.data()['price']);
          // print('fetchprice inside');
          // print(fetchprice);
        });
      });
      // print('fetchprice outside');
      // print(fetchprice);

      fetchquan.add((bill.getBasket()[i] as Medicine).getQuantity());
      details_result.add(fetchprice[i]);
      sum =
          sum + ((bill.basket[i] as Medicine).getQuantity() * (fetchprice[i]));
    }
    if (s == true) {
      List q = await confirmBuy(bill.getBasket());

      col_bill.set({
        'bill_id': bill.id,
        'bill_date': bill.getDate(),
        'bill_type': bill.getType(),
        'employee_id': elem,
        'customer_name': bill.customer== null ? " " :bill.customer.name,
        'medicin_id': fetchid,
        'quantity_of_medicins': fetchquan,
        'prices_with_details': details_result,
        'total_bill_price': sum.toString(),
        'quantity_id': q,
      });
      await FirebaseFirestore.instance
          .collection('customer')
          .where('customer_name', isEqualTo: bill.customer.name)
          .get()
          .then((value) async {
        value.docs.forEach((element) {
          id_cust = element.data()['customer_id'];
          bill_ref.add(col_bill.id);
        });
        if (id_cust != null) {
          await FirebaseFirestore.instance
              .collection('customer')
              .doc(id_cust)
              .update({'bills_id': bill_ref});
        }
      });
    }
  }

  Future<List> confirmBuy(List<Medicine> basket) async {
    List quantityid = [];
    var min;
    for (int i = 0; i < basket.length; i++) {
      await FirebaseFirestore.instance
          .collection('medicins')
          .where("medicin_name", isEqualTo: basket[i].getName())
          .get()
          .then((value) {
        value.docs.forEach((element) async {
          var elem2 = element.data()['medicin_id'];
          var sum = element.data()['count_for_consumption'] + 1.0;
          element.reference.update({'count_for_consumption': sum});

          await FirebaseFirestore.instance
              .collection('quantity')
              .where('product_id', isEqualTo: elem2)
              .get()
              .then((value) async {
            List<Timestamp> temp = [];
            value.docs.forEach((element) {
              if (element.data()['quantity'] != 0)
                temp.add(element.data()['orderbill_date']);
            });
            min = temp[0];
            if (temp.length > 1) {
              for (int h = 0; h < temp.length; h++) {
                if (temp[i].compareTo(min) <= 0) min = temp[i];
              }
            }
            DateTime d = (min as Timestamp).toDate();
            var day = d.day;

            var month = d.month;
            var year = d.year;
            var compare1 = DateTime.utc(year, month, day, 0, 0, 1);
            var compare2 = DateTime.utc(year, month, day, 23, 59, 59);

            await FirebaseFirestore.instance
                .collection('quantity')
                .where('orderbill_date', isGreaterThanOrEqualTo: compare1)
                .where('orderbill_date', isLessThanOrEqualTo: compare2)
                .where('product_id', isEqualTo: elem2)
                .get()
                .then((value) {
              value.docs.forEach((element) async {
                quantityid.add(element.data()['quantity_id']);
                var neww = element.data()['quantity'];
                var varr = basket[i].getQuantity();
                var result = neww - varr;
                element.reference.update({'quantity': result});
              });
            });
          });
        });
      });
    }

    //  limitNotification y = new limitNotification();
    // List<Medicine> l = [];
    //  l = await y.getT();
    //  for (int i = 0; i < l.length; i++) {
    //  print(l[i].getName());
    // print(l[i].getQuantity());
    // }
    // print('nanana');
    return quantityid;
  }
}
