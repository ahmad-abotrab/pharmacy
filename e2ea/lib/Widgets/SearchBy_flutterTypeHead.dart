import 'dart:async';

import 'package:e2ea/newModels/models/billmodel.dart';
import 'package:e2ea/newModels/models/customermodel.dart';
import 'package:e2ea/newModels/models/employemodel.dart';
import 'package:e2ea/newModels/models/medicinmodel.dart';
import 'package:e2ea/views/AddCustomer/AddCustomer.dart';
import 'package:e2ea/views/AddOrUpdateToMed/AddOrUpdateToMed.dart';
import 'package:e2ea/views/Register/Register.dart';
import 'package:e2ea/views/ShowBillsOrMed/ShowBillsOrMed.dart';
import 'package:e2ea/views/pageMedicine3/pageMedicine4.dart';

import '../localization/localizations_demo.dart';


import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// ignore: must_be_immutable
class SearchByFlutterTypeHead extends StatefulWidget {
  SearchByFlutterTypeHead({
    Key key,
    this.suggestionsCallback,
    this.nofoundItemHint,
    this.target,
    this.userEmployee,
    this.callbackEmployee,
    this.whereIam,
  }) : super(key: key);
  final FutureOr<Iterable<Object>> Function(String) suggestionsCallback;
  final String nofoundItemHint;
  final String target;
  final Employee userEmployee;
  Function(Object) callbackEmployee;
  final String whereIam;

  @override
  State<SearchByFlutterTypeHead> createState() =>
      _SearchByFlutterTypeHeadState();
}

class _SearchByFlutterTypeHeadState extends State<SearchByFlutterTypeHead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TypeAheadField(
        hideSuggestionsOnKeyboardHide: false,

        //debounceDuration: Duration(milliseconds: 500),
        suggestionsCallback: widget.suggestionsCallback,

        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText:
                DemoLocalizations.of(context).translate('hintTextSearchField'),
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        itemBuilder: (context, suggesstion) {
          final user = suggesstion;
          return ListTile(
            title: Text(user.name),
          );
        },
        noItemsFoundBuilder: (context) {
          return Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                FittedBox(child: Text(widget.nofoundItemHint)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => widget.target == 'customer'
                            ? AddCustomer()
                            : widget.target == 'medicine'
                                ? AddOrUpdateMed(
                                    userEmployee: widget.userEmployee,
                                  )
                                : widget.target == 'customerAndBill'
                                    ? AddCustomer()
                                    : Register(
                                        userEmployee: widget.userEmployee,
                                      ),
                      ),
                    );
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black)),
                      child: Center(child: Text('add ' + widget.target))),
                ),
              ],
            ),
          );
        },

        onSuggestionSelected: (suggesstion) {
          if (suggesstion is Medicine && widget.target == 'sale') {
            setState(() {
              widget.callbackEmployee?.call(suggesstion);
              print('here in search sale');
              print(suggesstion.basicQuantity);
              print(suggesstion.name);
              print(suggesstion.quantity_limit);
              print(suggesstion.price);
            });
          } else {
            if (suggesstion is Customer && widget.target == 'sale') {
              setState(() {
                widget.callbackEmployee?.call(suggesstion);
              });
            } else {
              if (suggesstion is Medicine) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Medicinescreen(
                              product: suggesstion,
                            )));
              } else {
                if (suggesstion is Employee &&
                    widget.whereIam == 'Accessabilty') {
                  setState(() {
                    widget.callbackEmployee?.call(suggesstion);
                  });
                }
                if (suggesstion is Customer &&
                    widget.target == 'customerAndBill') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShowBillOrMed(customer: suggesstion)));
                }
              }
            }
          }

          // Navigator.push(context, route)
        },
      ),
    );
  }

  showDialogeCustomer(Customer customer) {}
}
