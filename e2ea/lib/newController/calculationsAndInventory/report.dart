import 'package:cloud_firestore/cloud_firestore.dart';

class Reports {
  Future<Object> calcTodayBox() async {
    double totalSell = 0.0;
    var date1 = DateTime.utc(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 1);
    var date2 = DateTime.utc(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        DateTime.now().hour,
        DateTime.now().minute,
        DateTime.now().second);
    return await FirebaseFirestore.instance
        .collection('bills')
        .where('bill_date', isGreaterThanOrEqualTo: date1)
        .where('bill_date', isLessThanOrEqualTo: date2)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          totalSell += double.parse(doc.data()['total_bill_price']);
        });
      }
      return totalSell;
    });
  }

  Future<List> makeDayReport(var day, var month, var year) async {
    double tottalSell = 0.0;
    double tottalBuy = 0.0;
    double profits = 0.0;
    double losses = 0.0;
    List l = [];
    List add1 = [];
    List medsId = [];
    List quantitysaled = [];
    List result = [];
    List quanmedid = [];
    List quan = [];
    double sum = 0;

    var date1 = DateTime.utc(year, month, day, 0, 0, 1);
    var date2 = DateTime.utc(year, month, day, 23, 59, 59);

    await FirebaseFirestore.instance
        .collection('bills')
        .where('bill_date', isGreaterThanOrEqualTo: date1)
        .where('bill_date', isLessThanOrEqualTo: date2)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          medsId.add(doc.data()['medicin_id']);
          quantitysaled.add(doc.data()['quantity_of_medicins']);
          tottalSell += double.parse(doc.data()['total_bill_price']);
        });
      }
      l.add(tottalSell);
    });
    print('total sell ' + l[0].toString());

    await FirebaseFirestore.instance
        .collection('Order-bill')
        .where('bill_date', isGreaterThanOrEqualTo: date1)
        .where('bill_date', isLessThanOrEqualTo: date2)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          add1.add(doc.data()['total_bill_price']);
        });
      }
      for (int i = 0; i < add1.length; i++) tottalBuy += add1[i];

      l.add(tottalBuy);
    });
    print('total buy ' + l[1].toString());
    await FirebaseFirestore.instance
        .collection('Expired')
        .where('date_enterd_intoExpire', isGreaterThanOrEqualTo: date1)
        .where('date_enterd_intoExpire', isLessThanOrEqualTo: date2)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          double quantityyy = double.parse(doc.data()['quantity']);
          losses += double.parse(doc.data()['original_price']) * quantityyy;
        });
      }
      l.add(losses);
    });
    print('losses ' + l[2].toString());
    await FirebaseFirestore.instance
        .collection('bills')
        .where('bill_date', isGreaterThanOrEqualTo: date1)
        .where('bill_date', isLessThanOrEqualTo: date2)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) async {
          List price = [];
          double nateja = 0;

          quanmedid = doc.data()['quantity_id'];
          quan = doc.data()['quantity_of_medicins'];

          for (int i = 0; i < quanmedid.length; i++) {
            await FirebaseFirestore.instance
                .collection('quantity')
                .where('quantity_id', isEqualTo: quanmedid[i])
                .get()
                .then((value) {
              if (value.docs.isNotEmpty) {
                value.docs.forEach((doc) {
                  price.add(doc.data()['original_price']);
                  nateja = nateja + (price[i] * quan[i]);
                });
              }
            });
          }
          result.add(nateja);

          for (int i = 0; i < result.length; i++) {
            sum = sum + result[i];
          }

          profits = tottalSell - sum;
        });
        print(profits);
      }
      l.add(profits);
    });
    print('profits ' + l[3].toString());
    return l;
  }

  /////////////////////////////////////////////////////////////////////////////////////////
  Future<List> makeMonthReport(var month, var year) async {
    List<double> finall = [];
    double tottalSell = 0.0;
    double tottalBuy = 0.0;
    double profits = 0.0;
    double losses = 0.0;
    List medsId = [];
    List<double> test = [];
    double pricebought = 0.0;
    List quantitysaled = [];

    var date1, date2;
    date1 = DateTime.utc(year, month, 1, 0, 0, 1);
    if (month == 1 ||
        month == 3 ||
        month == 5 ||
        month == 7 ||
        month == 8 ||
        month == 10 ||
        month == 12)
      date2 = DateTime.utc(year, month, 31, 23, 59, 59);
    else
      date2 = DateTime.utc(year, month, 30, 23, 59, 59);

    await FirebaseFirestore.instance
        .collection('bills')
        .where('bill_date', isGreaterThanOrEqualTo: date1)
        .where('bill_date', isLessThanOrEqualTo: date2)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          medsId.add(doc.data()['medicin_id']);
          test.add(double.parse(doc.data()['total_bill_price']));
          quantitysaled.add(doc.data()['quantity_of_medicins']);
          for (int i = 0; i < medsId.length; i++) tottalSell += test[i];
        });
      }
    });
    finall.add(tottalSell);
    await FirebaseFirestore.instance
        .collection('Order-bill')
        .where('orderbill_date', isGreaterThanOrEqualTo: date1)
        .where('orderbill_date', isLessThanOrEqualTo: date2)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          tottalBuy += doc.data()['total_bill_price'];
        });
      }
    });
    finall.add(tottalBuy);
    await FirebaseFirestore.instance
        .collection('Expired')
        .where('date_enterd_intoExpire', isGreaterThanOrEqualTo: date1)
        .where('date_enterd_intoExpire', isLessThanOrEqualTo: date2)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          List<double> quantity = [];
          List orgprice = [];
          quantity.add(doc.data()['quantity']);
          orgprice.add(doc.data()['original_price']);
          for (int i = 0; i < quantity.length; i++)
            losses += quantity[i] * orgprice[i];
        });
      }
    });
    finall.add(losses);
    for (int i = 0; i < medsId.length; i++) {
      await FirebaseFirestore.instance
          .collection('Order-bill')
          .where('medicin_id', isEqualTo: medsId[i])
          .where('orderbill_date', isGreaterThanOrEqualTo: date1)
          .where('orderbill_date', isLessThanOrEqualTo: date2)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          value.docs.forEach((doc) {
            pricebought +=
                double.parse(doc.data()['prices'] * quantitysaled[i]);
          });
        }
      });
    }

    profits = tottalSell - pricebought;
    finall.add(profits);

    return finall;
  }

  ////////////////////////////////////////////////////////////////////////////////////
  Future<List> makeYearReport(var year) async {
    double tottalSell = 0.0;
    double tottalBuy = 0.0;
    double profits = 0.0;
    double losses = 0.0;
    List medsId = [];
    double pricebought = 0.0;
    List quantitysaled = [];

    var date1, date2;
    date1 = DateTime.utc(year, 1, 1, 0, 0, 1);
    date2 = DateTime.utc(year, 12, 31, 23, 59, 59);

    await FirebaseFirestore.instance
        .collection('bills')
        .where('bill_date', isGreaterThanOrEqualTo: date1)
        .where('bill_date', isLessThanOrEqualTo: date2)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          medsId.add(doc.data()['medicin_id']);
          quantitysaled.add(doc.data()['quantity_of_medicins']);
          tottalSell += doc.data()['total_bill_price'];
        });
      }
    });

    await FirebaseFirestore.instance
        .collection('Order-bill')
        .where('orderbill_date', isGreaterThanOrEqualTo: date1)
        .where('orderbill_date', isLessThanOrEqualTo: date2)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          tottalBuy += doc.data()['total_bill_price'];
        });
      }
    });

    await FirebaseFirestore.instance
        .collection('Expired')
        .where('date_enterd_intoExpire', isGreaterThanOrEqualTo: date1)
        .where('date_enterd_intoExpire', isLessThanOrEqualTo: date2)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          int quantity = doc.data()['quantity'];
          losses += (doc.data()['original_price']) * quantity;
        });
      }
    });

    for (int i = 0; i < medsId.length; i++) {
      /// moba3een
      await FirebaseFirestore.instance
          .collection('Order-bill')
          .where('medicin_id', isEqualTo: medsId[i])
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          value.docs.forEach((doc) {
            pricebought += doc.data()['prices'] * quantitysaled[i]; //ras almal
          });
        }
      });
    }

    profits = tottalSell - pricebought;
    Reports r = new Reports();
  }
}
