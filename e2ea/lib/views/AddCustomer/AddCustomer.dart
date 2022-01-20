import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e2ea/newController/calculationsAndInventory/addCustomer.dart';
import 'package:e2ea/newController/search/SearchCustomer.dart';
import 'package:e2ea/newModels/models/customermodel.dart';

import '../../Widgets/FieldAdding.dart';
import '../../localization/localizations_demo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// ignore: must_be_immutable
class AddCustomer extends StatefulWidget {
  AddCustomer({Key key}) : super(key: key);
  bool isSearching = false;
  Customer customer = new Customer();
  List<TextEditingController> textEditingControllerList =
      List<TextEditingController>.generate(
          4, (index) => new TextEditingController());
  List notes = [];

  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: !widget.isSearching
            ? FittedBox(child: Text('Add New Customer'))
            : TypeAheadField(
                hideSuggestionsOnKeyboardHide: false,
                textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                        hintText: DemoLocalizations.of(context)
                            .translate('hintTextSearchField'))),
                suggestionsCallback:
                    SearchCustomer().searchingWithOneParamerter,
                itemBuilder: (context, suggestion) {
                  final user = suggestion;
                  return ListTile(
                    title: Text(user.name),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  widget.customer = suggestion;
                  setState(() {
                    widget.textEditingControllerList[0].text =
                        widget.customer.name;
                  });
                },
                // ignore: missing_return
                noItemsFoundBuilder: (context) {
                  return Center(
                    child: FittedBox(
                      child: Text(
                        'Not Found',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
        actions: [
          widget.isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      widget.isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      widget.isSearching = true;
                    });
                  },
                ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 700,
            decoration: BoxDecoration(
              gradient: Gradient.lerp(
                  LinearGradient(colors: [
                    Colors.blueGrey.withOpacity(0.25),
                    Colors.blueGrey.withOpacity(0.7)
                  ]),
                  RadialGradient(colors: [
                    Colors.blueGrey.withOpacity(0.6),
                    Colors.blueGrey.withOpacity(0.9)
                  ]),
                  0.15),
            ),
            child: Column(
              children: [
                FieldAdding(
                  textEditingControllerList:
                      widget.textEditingControllerList[0],
                  hintText: 'Name',
                  iconData: Icons.qr_code,
                  press: () {
                    widget.textEditingControllerList[0].text = '';
                  },
                ),
                FieldAdding(
                  textEditingControllerList:
                      widget.textEditingControllerList[1],
                  hintText: 'notes',
                  iconData: Icons.qr_code,
                  press: () {
                    widget.notes.add(widget.textEditingControllerList[1].text);
                    widget.textEditingControllerList[1].text = '';
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.06),
            child: FloatingActionButton(
              heroTag: 'addbtn',
              child: Icon(Icons.upload_file),
              onPressed: () async {
                print(widget.customer.id);
                print(widget.customer.name);
                print('here before add ' + widget.notes.length.toString());
                widget.notes.addAll(widget.customer.notice);
                print('here after add ' + widget.notes.length.toString());
                widget.customer.notice.addAll(widget.notes);


                //Here update customer 
                addcustomer().customerupdate(widget.customer);
                for (int i = 0;
                    i < widget.textEditingControllerList.length;
                    i++) {
                  widget.textEditingControllerList[i].text = '';
                }
                widget.notes = [];
              },
            ),
          ),
          FloatingActionButton(
            heroTag: 'uploadbtn',
            child: Icon(Icons.add),
            onPressed: () async {
              DocumentReference ref =
                  FirebaseFirestore.instance.collection('Customer').doc();
              ref.set({
                'id': ref.id,
                'name': widget.textEditingControllerList[0].text,
                'notes': widget.notes,
              });
              for (int i = 0;
                  i < widget.textEditingControllerList.length;
                  i++) {
                widget.textEditingControllerList[i].text = '';
              }
              widget.notes = [];
            },
          )
        ],
      ),
    );
  }
}
