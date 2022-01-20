import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  String dropDownValue = '';
  int _tempCounter = 0;
  int _counterProduct = 0;
  int _counterNotification = 0;
  List<String> barCodeProducts = [];
  DateTime firstDateProvidor = DateTime.now();
  DateTime secondDateProvidor = DateTime.now();
  DateTime expireDateMedicin = DateTime.now();

  int counterAddingMedicens = 0;
  List temp = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  List<List<TextEditingController>> textEditingController = [];

  addElementToList(int indexRow) {
    this.textEditingController.add(new List<TextEditingController>.generate(
        20, (textEditingController) => new TextEditingController(),
        growable: true));
    //this.textEditingController[indexRow].add(new TextEditingController());
    notifyListeners();
  }

  setDropDownValue(String s) {
    dropDownValue = s;
    notifyListeners();
  }

  setnewDateFirst(date) {
    firstDateProvidor = date;
    notifyListeners();
  }

  setnewDateExpire(date) {
    firstDateProvidor = date;
    notifyListeners();
  }

  setnewDateSecond(date) {
    secondDateProvidor = date;
    notifyListeners();
  }

  getYearFromFirst() {
    return firstDateProvidor.year;
  }

  getMonthFromFirst() {
    return firstDateProvidor.month;
  }

  getdayFromFirst() {
    return firstDateProvidor.day;
  }

  getYearFromSecond() {
    return secondDateProvidor.year;
  }

  getMonthFromSecond() {
    return secondDateProvidor.month;
  }

  getdayFromSecond() {
    return secondDateProvidor.day;
  }

  setBarCode(String barCode) {
    this.barCodeProducts.add(barCode);
    notifyListeners();
  }

  makeClassifiacation() {
    //notifyListeners();
  }

  void increaseCounterAddingMed() {
    counterAddingMedicens++;
    notifyListeners();
  }

  int get counterProduct => _counterProduct;
  int get counterNotification => _counterNotification;
  int get tempCounter => _tempCounter;

  set counterProduct(int value) {
    _counterProduct = value;
    notifyListeners();
  }

  set counterNotification(int value) {
    _counterNotification = value;
    notifyListeners();
  }

  set tempCounter(int value) {
    _tempCounter = value;
    notifyListeners();
  }

  set listOrder(int value) {}

  incrementProduct() {
    _counterProduct++;
    _tempCounter++;
    notifyListeners();
  }

  incrementNotification() {
    _tempCounter++;
    _counterNotification++;
    notifyListeners();
  }

  decrementProduct() {
    _counterProduct--;
    _tempCounter--;
    notifyListeners();
  }

  decrementNotification() {
    _tempCounter--;
    _counterNotification--;
    notifyListeners();
  }
}
