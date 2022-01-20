// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/api_createPDf/pdf_api.dart';
import 'package:e2ea/newModels/models/billmodel.dart';
import 'package:e2ea/newModels/models/customermodel.dart';
import 'package:e2ea/newModels/models/employemodel.dart';
import 'package:flutter/material.dart' as dm;
import 'package:flutter/widgets.dart' as dw;
import 'package:intl/intl.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfBill {
  Future<File> generatpdf(Bill bill) async {
    Employee emp = bill.employee;
    Customer cust = bill.customer;
    final pdf = Document();
    pdf.addPage(
      MultiPage(
        build: (context) => <Widget>[
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          buildCustomHeader(bill),
          SizedBox(height: 2 * PdfPageFormat.cm),
          Container(
              width: 2,
              child: Text(" Pharmacist : " + emp.getName(),
                  style: TextStyle(
                    color: PdfColors.green800,
                    fontSize: 24,
                  )),
              padding: EdgeInsets.all(4),
              color: PdfColors.indigo300),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Container(
            color: PdfColors.grey500,
            width: 2,
            child: (cust.getName() != null)
                ? Text(" Patient :" + cust.getName(),
                    style: TextStyle(color: PdfColors.green800, fontSize: 24))
                : Text(" Patient :" + "cust.getName",
                    style: TextStyle(color: PdfColors.green800, fontSize: 24)),
            padding: EdgeInsets.all(4),
          ),
          SizedBox(height: 2 * PdfPageFormat.cm),
          Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 3, color: PdfColors.blueAccent400))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Product name"),
                    Text("Producr Price"),
                    Text("product Quantity"),
                    Text("Total")
                  ])),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          for (int i = 0; i < bill.basket.length; i++)
            CreatLine(bill.basket[i].name, bill.basket[i].getQuantity(),
                bill.basket[i].price),
          SizedBox(height: 0.18 * PdfPageFormat.cm),
          Container(
              alignment: Alignment.centerRight,
              child: (bill.total_price != null || bill.total_price != 0)
                  ? Text("Total price is " + bill.total_price.toString())
                  : Text(" tot")),
        ],
        footer: (context) {
          final text = 'Page ${context.pageNumber} of ${context.pagesCount}';
          return Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 1),
            child: Text(
              text,
              style: TextStyle(color: PdfColors.black),
            ),
          );
        },
      ),
    );
    return PdfApi.saveDocument(name: bill.id + '.pdf', pdf: pdf);
  }

  String formatTimestamp(Timestamp timestamp) {
    var format = new DateFormat('y-MM-d'); // 'hh:mm' for hour & min
    var gg = format.format(timestamp.toDate());
  }

  static Widget buildCustomHeader(Bill bill) {
    var format = new DateFormat('y-MM-d'); // 'hh:mm' for hour & min
    var gg = format.format(bill.date.toDate());
    return Container(
      padding: EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 2, color: PdfColors.blue)),
      ),
      child: Row(
        children: [
          PdfLogo(),
          SizedBox(width: 0.5 * PdfPageFormat.cm),
          Text(
            ' Pharmacy Bill Order ',
            style: TextStyle(fontSize: 20, color: PdfColors.blue),
          ),
          SizedBox(width: 4 * PdfPageFormat.cm),
          Column(children: [
            (bill.id != null)
                ? Text(" ID : " + bill.id,
                    style: TextStyle(color: PdfColors.blue600))
                : Text(" ID : " + "bill.id",
                    style: TextStyle(color: PdfColors.blue600)),
            (gg != null)
                ? Text("Date : " + gg,
                    style: TextStyle(color: PdfColors.blue600))
                : Text("Date : " + "formattedDate",
                    style: TextStyle(color: PdfColors.blue600)),
          ])
        ],
      ),
    );
  }

  static Widget buildCustomHeadline() => Header(
        child: Text(
          'My Third Headline',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(color: PdfColors.red),
      );

  static Widget CreatLine(
    String medname,
    int quantity,
    double price,
  ) {
    var ff = quantity * price;

    return Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 2, color: PdfColors.blueAccent400))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  child: Center(
                child: Text('$medname'),
              )),
              Container(
                child: Center(
                  child: Text('$quantity'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('$price'),
                ),
              ),
              Container(
                child: Center(child: Text('$ff')),
              ),
            ]));
  }
}
