import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/calculationsAndInventory/inventory.dart';
import 'package:e2ea/newModels/models/billmodel.dart';


 class AnnualInventory implements Inventory{
  @override
  List<Object> inventor;
  Bill store=new Bill();
  @override
  Future<List<Object>> inven(var specificDay1,var specificDay2) async {
 var s = await FirebaseFirestore.instance
        .collection('bills')
        .where("bill_date", isGreaterThanOrEqualTo:specificDay1)
        .where('bill_date', isLessThanOrEqualTo: specificDay2)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          store.setBasket( element.data()['medicin_id']);
          store.setQuantity(double.parse(element.data()['quantity_of_medicins']));  
        inventor.add(store);
 
  });}

        });
   return inventor;
  } 


 }        

  


  