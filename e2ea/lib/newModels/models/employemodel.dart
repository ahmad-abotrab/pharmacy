import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  String name;
  String id;
  String email;
  String password;
  int age;
  double salary;
  String sex;
  String phoneNumber;
  int workHours;
  int sales;
  double costEachWorkHour;
  dynamic state;
  var impression_map;
  DateTime dateStartWork;

  Employee({
    this.name,
    this.id,
    this.email,
    this.password,
    this.age,
    this.salary,
    this.sex,
    this.phoneNumber,
    this.workHours,
    this.sales,
    this.impression_map,
    this.costEachWorkHour,
    this.dateStartWork,
    this.state,
  });

  void setName(String name) {
    this.name = name;
  }

  void setId(String id) {
    this.id = id;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void setAge(int age) {
    this.age = age;
  }

  void setSalary(double salary) {
    this.salary = salary;
  }

  void setHours(int workHours) {
    this.workHours = workHours;
  }

  void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  void setSales(int sales) {
    this.sales = sales;
  }

  String getName() {
    return name;
  }

  String getPhoneNumber() {
    return phoneNumber;
  }

  String getId() {
    return id;
  }

  String getEmail() {
    return email;
  }

  String getPassword() {
    return password;
  }

  int getAge() {
    return age;
  }

  double getSalary() {
    return salary;
  }

  int getWorkHours() {
    return workHours;
  }

  int getSales() {
    return sales;
  }

  void set_impression(var impression_map) {
    this.impression_map = impression_map;
  }

  Map getMap() {
    return impression_map;
  }
}
