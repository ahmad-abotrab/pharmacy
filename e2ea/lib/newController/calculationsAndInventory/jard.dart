// import 'package:cloud_firestore/cloud_firestore.dart';

// class jard {
//   Future<List<List<Object>>> makeDayJard(var day, var month, var year) async {
//     List medsId = [];
//     List medsName = [];
//     List quantitysaled = [];
//     List presentquantity = [];
//     List buys = [];
//     List<List> jard = [];
//     var date1 = DateTime.utc(year, month, day, 0, 0, 1);
//     var date2 = DateTime.utc(year, month, day, 23, 59, 59);
//     await FirebaseFirestore.instance.collection('medicins').get().then((value) {
//       if (value.docs.isNotEmpty) {
//         value.docs.forEach((doc) {
//           medsId.add(doc.data()['medicin_id']);
//           medsName.add(doc.data()['medicin_name']);
//         });
//       }
//     });

//     for (int i = 0; i < medsId.length; i++) {
//       await FirebaseFirestore.instance
//           .collection('bills')
//           .where('bill_date', isGreaterThanOrEqualTo: date1)
//           .where('bill_date', isLessThanOrEqualTo: date2)
//           .where('medicin_id', arrayContains: medsId[i])
//           .get()
//           .then((value) {
//         if (value.docs.isNotEmpty) {
//           int quantity = 0;
//           value.docs.forEach((doc) {
//             List medsId2 = [];
//             List medsquan = [];
//             medsId2 = doc.data()['medicin_id'];
//             medsquan = doc.data()['quantity_of_medicins'];
//             for (int j = 0; j < medsId2.length; j++) {
//               if (medsId2[j] == medsId[i]) {
//                 quantity = quantity + medsquan[j];
//               }
//             }
//           });
//           quantitysaled.add(quantity);
//         } else
//           quantitysaled.add(0);
//       });

//       await FirebaseFirestore.instance
//           .collection('quantity')
//           .where('product_id', arrayContains: medsId[i])
//           .where('orderbill_date', isLessThanOrEqualTo: date1)
//           .get()
//           .then((value) {
//         int quantitytemp = 0;
//         value.docs.forEach((element) {
//           quantitytemp = quantitytemp + element.data()['quantity'];
//         });
//         presentquantity.add(quantitytemp);
//       });

//       await FirebaseFirestore.instance
//           .collection('Order-bill')
//           .where('bill_date', isGreaterThanOrEqualTo: date1)
//           .where('bill_date', isLessThanOrEqualTo: date2)
//           .where('medicin_id', arrayContains: medsId[i])
//           .get()
//           .then((value) {
//         if (value.docs.isNotEmpty) {
//           var qq = 0;
//           List mids = [];
//           List quans = [];
//           value.docs.forEach((element) {
//             mids = element.data()['medicin_id'];
//             quans = element.data()['quantitiy'];
//             for (int k = 0; k < mids.length; k++) {
//               if (mids[k] == medsId[i]) {
//                 qq = qq + quans[k];
//               }
//             }
//           });
//           buys.add(qq);
//         } else
//           buys.add(0);
//       });
//     }
//     jard.add(medsName);
//     jard.add(quantitysaled);
//     jard.add(buys);
//     jard.add(presentquantity);

//     return jard;
//   }

//   /////////////////////////////////////////////////////////////////////////////////////////
//   Future<List<List<Object>>> makeMonthJard(var month, var year) async {
//     List quantitysaled2 = [];
//     List medsId = [];
//     List medsName = [];
//     List quantitysaled = [];
//     List presentquantity = [];
//     List buys = [];
//     List<List> jard = [];
//     var date1, date2;
//     date1 = DateTime.utc(year, month, 1, 0, 0, 1);
//     if (month == 1 ||
//         month == 3 ||
//         month == 5 ||
//         month == 7 ||
//         month == 8 ||
//         month == 10 ||
//         month == 12)
//       date2 = DateTime.utc(year, month, 31, 23, 59, 59);
//     else
//       date2 = DateTime.utc(year, month, 30, 23, 59, 59);

//     await FirebaseFirestore.instance.collection('medicins').get().then((value) {
//       if (value.docs.isNotEmpty) {
//         value.docs.forEach((doc) {
//           medsId.add(doc.data()['medicin_id']);
//           medsName.add(doc.data()['medicin_name']);
//         });
//       }
//     });
//     for (int i = 0; i < medsId.length; i++) {
//       await FirebaseFirestore.instance
//           .collection('bills')
//           .where('bill_date', isGreaterThanOrEqualTo: date1)
//           .where('bill_date', isLessThanOrEqualTo: date2)
//           .where('medicin_id', arrayContains: medsId[i])
//           .get()
//           .then((value) {
//         if (value.docs.isNotEmpty) {
//           int quantity = 0;
//           value.docs.forEach((doc) {
//             List medsId2 = [];
//             List medsquan = [];
//             medsId2 = doc.data()['medicin_id'];
//             medsquan = doc.data()['quantity_of_medicins'];
//             for (int j = 0; j < medsId2.length; j++) {
//               if (medsId2[j] == medsId[i]) {
//                 quantity = quantity + medsquan[j];
//               }
//             }
//           });
//           quantitysaled.add(quantity);
//         } else
//           quantitysaled.add(0);
//       });

//       await FirebaseFirestore.instance
//           .collection('Order-bill')
//           .where('bill_date', isLessThanOrEqualTo: date2)
//           .where('medicin_id', arrayContains: medsId[i])
//           .get()
//           .then((value) async {
//         int quantitytemp = 0;
//         var quantitytemp2 = 0;
//         value.docs.forEach((element) {
//           List medsId2 = [];
//           List medsquan = [];
//           medsId2 = element.data()['medicin_id'];
//           medsquan = element.data()['quantity'];
//           if (medsquan == null) {
//             for (int j = 0; j < medsId2.length; j++) {
//               if (medsId2[j] == medsId[i]) {
//                 quantitytemp = quantitytemp + 0;
//               }
//             }
//           } else {
//             for (int j = 0; j < medsId2.length; j++) {
//               if (medsId2[j] == medsId[i]) {
//                 quantitytemp = quantitytemp + medsquan[j];
//               }
//             }
//           }
//         });

//         await FirebaseFirestore.instance
//             .collection('bills')
//             .where('bill_date', isLessThanOrEqualTo: date2)
//             .where('medicin_id', arrayContains: medsId[i])
//             .get()
//             .then((value) {
//           if (value.docs.isNotEmpty) {
//             int quantity = 0;
//             value.docs.forEach((doc) {
//               List medsId2 = [];
//               List medsquan = [];
//               medsId2 = doc.data()['medicin_id'];
//               medsquan = doc.data()['quantity_of_medicins'];
//               for (int j = 0; j < medsId2.length; j++) {
//                 if (medsId2[j] == medsId[i]) {
//                   quantity = quantity + medsquan[j];
//                 }
//               }
//             });
//             quantitysaled2.add(quantity);
//           } else
//             quantitysaled2.add(0);
//         });

//         quantitytemp2 = quantitytemp - quantitysaled2[i];
//         presentquantity.add(quantitytemp2);
//       });

//       await FirebaseFirestore.instance
//           .collection('Order-bill')
//           .where('bill_date', isGreaterThanOrEqualTo: date1)
//           .where('bill_date', isLessThanOrEqualTo: date2)
//           .where('medicin_id', arrayContains: medsId[i])
//           .get()
//           .then((value) {
//         if (value.docs.isNotEmpty) {
//           var qq = 0;
//           List mids = [];
//           List quans = [];
//           value.docs.forEach((element) {
//             mids = element.data()['medicin_id'];
//             quans = element.data()['quantities'];
//             if (quans != null) {
//               for (int k = 0; k < mids.length; k++) {
//                 if (mids[k] == medsId[i]) {
//                   qq = qq + quans[k];
//                 }
//               }
//             } else {
//               for (int k = 0; k < mids.length; k++) {
//                 print('mids[k]  ' + mids[k]);
//                 print('medsId[i] ' + medsId[i]);
//                 if (mids[k] == medsId[i]) {
//                   qq = qq + 0;
//                 }
//               }
//             }
//           });
//           buys.add(qq);
//         } else
//           buys.add(0);
//       });
//     }
//     jard.add(medsName);
//     jard.add(quantitysaled);
//     jard.add(presentquantity);
//     jard.add(buys);

//     return jard;
//   }

//   ////////////////////////////////////////////////////////////////////////////////////
//   Future<List<List<Object>>> makeYearJard(var year) async {
//     List quantitysaled2 = [];
//     List medsId = [];
//     List medsName = [];
//     List quantitysaled = [];
//     List presentquantity = [];
//     List buys = [];
//     List<List> jard = [];
//     var date1, date2;
//     date1 = DateTime.utc(year, 1, 1, 0, 0, 1);
//     date2 = DateTime.utc(year, 12, 31, 23, 59, 59);

//     await FirebaseFirestore.instance.collection('medicins').get().then((value) {
//       if (value.docs.isNotEmpty) {
//         value.docs.forEach((doc) {
//           medsId.add(doc.data()['medicin_id']);
//           medsName.add(doc.data()['medicin_name']);
//         });
//       }
//     });
//     for (int i = 0; i < medsId.length; i++) {
//       await FirebaseFirestore.instance
//           .collection('bills')
//           .where('bill_date', isGreaterThanOrEqualTo: date1)
//           .where('bill_date', isLessThanOrEqualTo: date2)
//           .where('medicin_id', arrayContains: medsId[i])
//           .get()
//           .then((value) {
//         if (value.docs.isNotEmpty) {
//           int quantity = 0;
//           value.docs.forEach((doc) {
//             List medsId2 = [];
//             List medsquan = [];
//             medsId2 = doc.data()['medicin_id'];
//             medsquan = doc.data()['quantity_of_medicins'];
//             for (int j = 0; j < medsId2.length; j++) {
//               if (medsId2[j] == medsId[i]) {
//                 quantity = quantity + medsquan[j];
//               }
//             }
//           });
//           quantitysaled.add(quantity);
//         } else
//           quantitysaled.add(0);
//       });

//       await FirebaseFirestore.instance
//           .collection('Order-bill')
//           .where('bill_date', isLessThanOrEqualTo: date2)
//           .where('medicin_id', arrayContains: medsId[i])
//           .get()
//           .then((value) async {
//         int quantitytemp = 0;
//         var quantitytemp2 = 0;
//         value.docs.forEach((element) {
//           List medsId2 = [];
//           List medsquan = [];
//           medsId2 = element.data()['medicin_id'];
//           medsquan = element.data()['quantities'];
//           for (int j = 0; j < medsId2.length; j++) {
//             if (medsId2[j] == medsId[i]) {
//               quantitytemp = quantitytemp + medsquan[j];
//             }
//           }
//         });

//         await FirebaseFirestore.instance
//             .collection('bills')
//             .where('bill_date', isLessThanOrEqualTo: date2)
//             .where('medicin_id', arrayContains: medsId[i])
//             .get()
//             .then((value) {
//           if (value.docs.isNotEmpty) {
//             int quantity = 0;
//             value.docs.forEach((doc) {
//               List medsId2 = [];
//               List medsquan = [];
//               medsId2 = doc.data()['medicin_id'];
//               medsquan = doc.data()['quantity_of_medicins'];
//               for (int j = 0; j < medsId2.length; j++) {
//                 if (medsId2[j] == medsId[i]) {
//                   quantity = quantity + medsquan[j];
//                 }
//               }
//             });
//             quantitysaled2.add(quantity);
//           } else
//             quantitysaled2.add(0);
//         });

//         quantitytemp2 = quantitytemp - quantitysaled2[i];
//         presentquantity.add(quantitytemp2);
//       });

//       await FirebaseFirestore.instance
//           .collection('Order-bill')
//           .where('bill_date', isGreaterThanOrEqualTo: date1)
//           .where('bill_date', isLessThanOrEqualTo: date2)
//           .where('medicin_id', arrayContains: medsId[i])
//           .get()
//           .then((value) {
//         if (value.docs.isNotEmpty) {
//           var qq = 0;
//           List mids = [];
//           List quans = [];
//           value.docs.forEach((element) {
//             mids = element.data()['medicin_id'];
//             quans = element.data()['quantity'];
//             for (int k = 0; k < mids.length; k++) {
//               if (mids[k] == medsId[i]) {
//                 qq = qq + quans[k];
//               }
//             }
//           });
//           buys.add(qq);
//         } else
//           buys.add(0);
//       });
//     }
//     jard.add(medsName);
//     jard.add(quantitysaled);
//     jard.add(presentquantity);
//     jard.add(buys);

//     return jard;
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class jard {
  Future<List<List<Object>>> makeDayJard(var day, var month, var year) async {
    List medsId = [];
    List medsName = [];
    List quantitysaled = [];
    List presentquantity = [];
    List buys = [];
    List<List> jard = [];
    var date1 = DateTime.utc(year, month, day, 0, 0, 1);
    var date2 = DateTime.utc(year, month, day, 23, 59, 59);
    await FirebaseFirestore.instance.collection('medicins').get().then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          medsId.add(doc.data()['medicin_id']);
          medsName.add(doc.data()['medicin_name']);
        });
      }
    });

    for (int i = 0; i < medsId.length; i++) {
      await FirebaseFirestore.instance
          .collection('bills')
          .where('bill_date', isGreaterThanOrEqualTo: date1)
          .where('bill_date', isLessThanOrEqualTo: date2)
          .where('medicin_id', arrayContains: medsId[i])
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          int quantity = 0;
          value.docs.forEach((doc) {
            List medsId2 = [];
            List medsquan = [];
            medsId2 = doc.data()['medicin_id'];
            medsquan = doc.data()['quantity_of_medicins'];
            for (int j = 0; j < medsId2.length; j++) {
              if (medsId2[j] == medsId[i]) {
                quantity = quantity + medsquan[j];
              }
            }
          });
          quantitysaled.add(quantity);
        } else
          quantitysaled.add(0);
      });

      await FirebaseFirestore.instance
          .collection('quantity')
          .where('product_id', isEqualTo: medsId[i])
          .where('orderbill_date', isLessThanOrEqualTo: date1)
          .get()
          .then((value) {
        int quantitytemp = 0;
        value.docs.forEach((element) {
          quantitytemp = quantitytemp + element.data()['quantity'];
        });
        presentquantity.add(quantitytemp);
      });

      await FirebaseFirestore.instance
          .collection('Order-bill')
          .where('bill_date', isGreaterThanOrEqualTo: date1)
          .where('bill_date', isLessThanOrEqualTo: date2)
          .where('medicin_id', arrayContains: medsId[i])
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          var qq = 0;
          List mids = [];
          List quans = [];
          value.docs.forEach((element) {
            mids = element.data()['medicin_id'];
            quans = element.data()['quantitiy'];
            for (int k = 0; k < mids.length; k++) {
              if (mids[k] == medsId[i]) {
                qq = qq + quans[k];
              }
            }
          });
          buys.add(qq);
        } else
          buys.add(0);
      });
    }
    jard.add(medsName);
    jard.add(quantitysaled);
    jard.add(buys);
    jard.add(presentquantity);

    return jard;
  }

  /////////////////////////////////////////////////////////////////////////////////////////
  Future<List<List<Object>>> makeMonthJard(var month, var year) async {
    List quantitysaled2 = [];
    List medsId = [];
    List medsName = [];
    List quantitysaled = [];
    List presentquantity = [];
    List buys = [];
    List<List> jard = [];
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
    await FirebaseFirestore.instance.collection('medicins').get().then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          medsId.add(doc.data()['medicin_id']);
          medsName.add(doc.data()['medicin_name']);
        });
      }
    });
    for (int i = 0; i < medsId.length; i++) {
      await FirebaseFirestore.instance
          .collection('bills')
          .where('bill_date', isGreaterThanOrEqualTo: date1)
          .where('bill_date', isLessThanOrEqualTo: date2)
          .where('medicin_id', arrayContains: medsId[i])
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          int quantity = 0;
          value.docs.forEach((doc) {
            List medsId2 = [];
            List medsquan = [];
            medsId2 = doc.data()['medicin_id'];
            medsquan = doc.data()['quantity_of_medicins'];
            for (int j = 0; j < medsId2.length; j++) {
              if (medsId2[j] == medsId[i]) {
                quantity = quantity + medsquan[j];
              }
            }
          });
          quantitysaled.add(quantity);
        } else
          quantitysaled.add(0);
      });

      await FirebaseFirestore.instance
          .collection('Order-bill')
          .where('bill_date', isLessThanOrEqualTo: date2)
          .where('medicin_id', arrayContains: medsId[i])
          .get()
          .then((value) async {
        int quantitytemp = 0;
        var quantitytemp2 = 0;
        value.docs.forEach((element) {
          List medsId2 = [];
          List medsquan = [];
          medsId2 = element.data()['medicin_id'];
          medsquan = element.data()['quantitiy'];
          for (int j = 0; j < medsId2.length; j++) {
            if (medsId2[j] == medsId[i]) {
              quantitytemp = quantitytemp + medsquan[j];
            }
          }
        });

        await FirebaseFirestore.instance
            .collection('bills')
            .where('bill_date', isLessThanOrEqualTo: date2)
            .where('medicin_id', arrayContains: medsId[i])
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            int quantity = 0;
            value.docs.forEach((doc) {
              List medsId2 = [];
              List medsquan = [];
              medsId2 = doc.data()['medicin_id'];
              medsquan = doc.data()['quantity_of_medicins'];
              for (int j = 0; j < medsId2.length; j++) {
                if (medsId2[j] == medsId[i]) {
                  quantity = quantity + medsquan[j];
                }
              }
            });
            quantitysaled2.add(quantity);
          } else
            quantitysaled2.add(0);
        });

        quantitytemp2 = quantitytemp - quantitysaled2[i];
        presentquantity.add(quantitytemp2);
      });

      await FirebaseFirestore.instance
          .collection('Order-bill')
          .where('bill_date', isGreaterThanOrEqualTo: date1)
          .where('bill_date', isLessThanOrEqualTo: date2)
          .where('medicin_id', arrayContains: medsId[i])
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          var qq = 0;
          List mids = [];
          List quans = [];
          value.docs.forEach((element) {
            mids = element.data()['medicin_id'];
            quans = element.data()['quantitiy'];
            for (int k = 0; k < mids.length; k++) {
              if (mids[k] == medsId[i]) {
                qq = qq + quans[k];
              }
            }
          });
          buys.add(qq);
        } else
          buys.add(0);
      });
    }
    jard.add(medsName);
    jard.add(quantitysaled);
    jard.add(buys);
    jard.add(presentquantity);

    return jard;
  }

  ////////////////////////////////////////////////////////////////////////////////////
  Future<List<List<Object>>> makeYearJard(var year) async {
    List quantitysaled2 = [];
    List medsId = [];
    List medsName = [];
    List quantitysaled = [];
    List presentquantity = [];
    List buys = [];
    List<List> jard = [];
    var date1, date2;
    date1 = DateTime.utc(year, 1, 1, 0, 0, 1);
    date2 = DateTime.utc(year, 12, 31, 23, 59, 59);

    await FirebaseFirestore.instance.collection('medicins').get().then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          medsId.add(doc.data()['medicin_id']);
          medsName.add(doc.data()['medicin_name']);
        });
      }
    });
    for (int i = 0; i < medsId.length; i++) {
      await FirebaseFirestore.instance
          .collection('bills')
          .where('bill_date', isGreaterThanOrEqualTo: date1)
          .where('bill_date', isLessThanOrEqualTo: date2)
          .where('medicin_id', arrayContains: medsId[i])
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          int quantity = 0;
          value.docs.forEach((doc) {
            List medsId2 = [];
            List medsquan = [];
            medsId2 = doc.data()['medicin_id'];
            medsquan = doc.data()['quantity_of_medicins'];
            for (int j = 0; j < medsId2.length; j++) {
              if (medsId2[j] == medsId[i]) {
                quantity = quantity + medsquan[j];
              }
            }
          });
          quantitysaled.add(quantity);
        } else
          quantitysaled.add(0);
      });

      await FirebaseFirestore.instance
          .collection('Order-bill')
          .where('bill_date', isLessThanOrEqualTo: date2)
          .where('medicin_id', arrayContains: medsId[i])
          .get()
          .then((value) async {
        int quantitytemp = 0;
        var quantitytemp2 = 0;
        value.docs.forEach((element) {
          List medsId2 = [];
          List medsquan = [];
          medsId2 = element.data()['medicin_id'];
          medsquan = element.data()['quantitiy'];
          for (int j = 0; j < medsId2.length; j++) {
            if (medsId2[j] == medsId[i]) {
              quantitytemp = quantitytemp + medsquan[j];
            }
          }
        });

        await FirebaseFirestore.instance
            .collection('bills')
            .where('bill_date', isLessThanOrEqualTo: date2)
            .where('medicin_id', arrayContains: medsId[i])
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            int quantity = 0;
            value.docs.forEach((doc) {
              List medsId2 = [];
              List medsquan = [];
              medsId2 = doc.data()['medicin_id'];
              medsquan = doc.data()['quantity_of_medicins'];
              for (int j = 0; j < medsId2.length; j++) {
                if (medsId2[j] == medsId[i]) {
                  quantity = quantity + medsquan[j];
                }
              }
            });
            quantitysaled2.add(quantity);
          } else
            quantitysaled2.add(0);
        });

        quantitytemp2 = quantitytemp - quantitysaled2[i];
        presentquantity.add(quantitytemp2);
      });
      await FirebaseFirestore.instance
          .collection('Order-bill')
          .where('bill_date', isGreaterThanOrEqualTo: date1)
          .where('bill_date', isLessThanOrEqualTo: date2)
          .where('medicin_id', arrayContains: medsId[i])
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          var qq = 0;
          List mids = [];
          List quans = [];
          value.docs.forEach((element) {
            mids = element.data()['medicin_id'];
            quans = element.data()['quantitiy'];
            for (int k = 0; k < mids.length; k++) {
              if (mids[k] == medsId[i]) {
                qq = qq + quans[k];
              }
            }
          });
          buys.add(qq);
        } else
          buys.add(0);
      });
    }
    jard.add(medsName);
    jard.add(quantitysaled);

    jard.add(buys);
    jard.add(presentquantity);
    return jard;
  }
}
