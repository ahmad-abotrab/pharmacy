import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';

import 'customermodel.dart';
import 'employemodel.dart';

class Bill {
  String type;
  String id;
  List<dynamic> basket;
  List<dynamic> quantityList;
  double total_price;
  dynamic employee;
  dynamic customer;
  double quantity;
  Timestamp date;
  String customer_notice;

  Bill({
    this.type,
    this.id,
    this.employee,
    this.customer,
    this.customer_notice,
    this.basket,
    this.quantity,
    this.date,
    this.total_price,
    this.quantityList,
  });

  void setType(String type) {
    this.type = type;
  }

  void setId(String id) {
    this.id = id;
  }

  void setTotal_price(double total_price) {
    this.total_price = total_price;
  }

  void setBasket(List<dynamic> medicine) {
    this.basket = medicine;
  }

  void setQuantity(double quantity) {
    this.quantity = quantity;
  }

  void setDate(Timestamp date) {
    this.date = date;
  }

  void setEmployee(Employee employee) {
    this.employee = employee;
  }

  void setCustomer(customer) {
    this.customer = customer;
  }

  void set_cus_notice() {
    this.customer_notice = customer_notice;
  }

  String getType() {
    return type;
  }

  String getId() {
    return id;
  }

  double getTotal_price() {
    return total_price;
  }

  List<Object> getBasket() {
    return basket;
  }

  double getQuantity() {
    return quantity;
  }

  Timestamp getDate() {
    return date;
  }

  Employee getEmployee() {
    return employee;
  }

  Customer getCustomer() {
    return customer;
  }

  String getcus_notice() {
    return customer_notice;
  }
}
  // Map<String, dynamic> toJson() => {
  //       'type': this.type,
  //       'id': this.id,
  //       'employee': this.employee,
  //       'customer': this.customer,
  //       'customer_notice': this.customer_notice,
  //       'basket': this.basket,
  //       'quantity': this.quantity,
  //       'date': this.date,
  //       'total_price': this.total_price,
  //     };
  // Bill.fromJson(Map json) {
  //   this.type = json['type'];
  //   this.id = json['id'];
  //   this.employee = json['employee'];
  //   this.customer = json['customer'];

  //   this.basket = json['basket'];
  //   this.quantity = json['quantity'];
  //   this.date = json['date'];
  //   this.total_price = json['total_price'];
  // }