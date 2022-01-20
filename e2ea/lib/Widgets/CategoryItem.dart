import 'package:e2ea/newModels/models/medicinmodel.dart';

import '../localization/localizations_demo.dart';

import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import 'package:provider/provider.dart';

import '../counter.dart';

// ignore: must_be_immutable
class CategoryItem extends StatefulWidget {
  CategoryItem(
      {Key key,
      @required this.product,
      this.index,
      @required this.mediaQueryData,
      this.mapBody,
      this.quantity,
      this.removeIcon,
      this.callback,
      this.callbackToChangeQuantityPropertyProduct,
      this.callbackToChangeTotalyCost,
      this.totaleCost,
      this.callbackNewQuantity})
      : super(key: key);

  final Medicine product;
  double totaleCost;
  List quantity = [];
  final int index;
  final MediaQueryData mediaQueryData;
  int quantity1;
  bool removeIcon;

  //int counter;
  Function(Object) callback;
  Function(Object) callbackToChangeQuantityPropertyProduct;
  Function(Object) callbackToChangeTotalyCost;
  Function(Object) callbackNewQuantity;

  Function(Object) callbackWhenMakeMinus;

  var mapBody = {};
  int counter = 0;

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem>
    with SingleTickerProviderStateMixin {
  Widget build(BuildContext context) {
    final Counter counterProduct = Provider.of<Counter>(context);

    widget.product.restOfAmount != null
        ? widget.quantity1 = widget.product.restOfAmount - widget.counter
        : widget.quantity1 = 0;

    return GestureDetector(
      //on one click active this event
      onTap: () {
        //transfer to all medicen in this category

        if (widget.product.choiceQuantity > 0) {
          if (widget.product.ifCanUseWithoutPrescription) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  DemoLocalizations.of(context).translate('NeedPrescription'),
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.end,
                  textDirection: ui.TextDirection.rtl,
                ),
                content: Text(DemoLocalizations.of(context)
                    .translate('contentPrescription')),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          widget.product.restOfAmount = widget.quantity1;

                          counterProduct.counterProduct += widget.counter;

                          if (widget.product.choiceQuantity >=
                              widget.product.restOfAmount) {
                            widget.product.choiceQuantity = widget.counter;
                          }
                          widget.totaleCost +=
                              widget.counter * widget.product.price;
                          if (widget.quantity[widget.index] == null) {
                            widget.quantity.add(widget.counter);
                          } else {
                            widget.quantity[widget.index] = widget.counter;
                          }

                          setState(() {
                            widget.callbackToChangeQuantityPropertyProduct
                                ?.call(widget.product);
                            widget.callbackToChangeTotalyCost
                                ?.call(widget.totaleCost);
                            widget.callbackNewQuantity?.call(widget.quantity);
                          });

                          //build snack bar
                          final snackBar = snackBarAcceptedChoice();
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                        },
                        child: Text(DemoLocalizations.of(context)
                            .translate('OkayButton')),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            widget.quantity1 += widget.counter;
                            widget.counter = 0;
                          });

                          Navigator.pop(context);
                        },
                        child: Text(DemoLocalizations.of(context)
                            .translate('CloseButton')),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            counterProduct.counterProduct += widget.counter;
            widget.product.restOfAmount = widget.quantity1;
            if (widget.product.choiceQuantity >= widget.product.restOfAmount) {
              widget.product.choiceQuantity = widget.counter;
            }

            print('quantity take it  : ' +
                widget.product.choiceQuantity.toString());

            widget.totaleCost += widget.counter * widget.product.price;
            if (widget.quantity[widget.index] == null) {
              widget.quantity.add(widget.counter);
            } else {
              widget.quantity[widget.index] = widget.counter;
            }
            setState(() {
              widget.callbackToChangeQuantityPropertyProduct
                  ?.call(widget.product);
              widget.callbackToChangeTotalyCost?.call(widget.totaleCost);
              widget.callbackNewQuantity?.call(widget.quantity);
            });

            //widget.order.add(pair);
            //build snack bar
            final snackBar = snackBarAcceptedChoice();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else {
          //build AlertDialoge For warning contite
          warningShowDialog(context);
        }
      },

      //long press
      onLongPress: () {
        // showAboutDialog(context: context);
        scientificInformationAboutMedicine(context);
      }, //here to show scientifc information about medicen

      onDoubleTap: () {
        setState(() {
          int orderedQuantity =
              (widget.mapBody[widget.product.barcode].basicQuantity -
                  widget.mapBody[widget.product.barcode].restOfAmount);

          widget.totaleCost -=
              (orderedQuantity * widget.mapBody[widget.product.barcode].price);

          counterProduct.counterProduct -= orderedQuantity;

          print("total totalCost " + widget.totaleCost.toString());

          widget.mapBody[widget.product.barcode].restOfAmount =
              widget.mapBody[widget.product.barcode].basicQuantity;
          widget.product.choiceQuantity = 0;

          widget.callbackToChangeTotalyCost?.call(widget.totaleCost);

          widget.mapBody.remove(widget.product.barcode);
          widget.callback?.call(widget.mapBody);

          // widget.bodyOfPage.removeAt(widget.index);
          // widget.callback?.call(widget.bodyOfPage);
        });
      },
      //shape of one grid
      child: Container(
        //margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        decoration: BoxDecoration(
          color: Color.fromRGBO(239, 252, 226, 1.0),
          //239, 252, 226, 1.0
          //212, 240, 185, 0.8

          borderRadius: BorderRadius.circular(12),
        ),
        child: contentOfGrid(
          pathToImage: "assets/images/panadol.png",
          context: context,
        ),
      ),
    );
  }

  // Scientific Information About Medicine
  Future<dynamic> scientificInformationAboutMedicine(BuildContext context) {
    TextStyle textStyleScintificText = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    );
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        elevation: 3.0,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(DemoLocalizations.of(context).translate('indecators'),
                //strutStyle: StrutStyle(fontWeight: FontWeight.bold, fontSize: 20),
                style: textStyleScintificText),
            Text(widget.product.indications == null
                ? ''
                : widget.product.indications),
            Text(
              DemoLocalizations.of(context).translate('notUses'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colors.red,
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: widget.product.notUses
                    .map(
                      (e) => FittedBox(
                        child: new Text(
                          e == null ? '' : e,
                          textAlign: TextAlign.end,
                          textDirection: ui.TextDirection.rtl,
                        ),
                      ),
                    )
                    .toList()),
            Text(DemoLocalizations.of(context).translate('warnings'),
                style: textStyleScintificText),
            Text(
                widget.product.warnings == null ? '' : widget.product.warnings),
          ],
        ),
        actions: <Widget>[
          SizedBox(
            height: widget.mediaQueryData.size.height * 0.2,
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(DemoLocalizations.of(context).translate('CloseButton')),
          ),
        ],
      ),
    );
  }

  //SnackBar Accepted Choice
  SnackBar snackBarAcceptedChoice() {
    return SnackBar(
      content: Text("add ${widget.counter} form Name Medicen"),
      duration: Duration(milliseconds: 1000),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }

  //Warning Show Dialog
  Future<dynamic> warningShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DemoLocalizations.of(context).translate('warnings'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.warning, color: Colors.yellow[700]),
                ],
              ),
              actions: [
                FittedBox(
                  alignment: Alignment.center,
                  child: Text(
                    DemoLocalizations.of(context).translate('ifQuantityZero'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: widget.mediaQueryData.size.height * 0.01,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(DemoLocalizations.of(context)
                        .translate('CloseButton'))),
              ],
            ));
  }

  //Content Of Grid
  Column contentOfGrid({
    String pathToImage,
    @required BuildContext context,
  }) {
    int temp;
    widget.product.restOfAmount != null
        ? temp = widget.product.restOfAmount
        : temp = 0;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: widget.mediaQueryData.size.height * 0.01),
              height: widget.mediaQueryData.size.height * 0.09,
              width: widget.mediaQueryData.size.width * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.product.urlImage != null
                        ? NetworkImage(widget.product.urlImage)
                        : AssetImage("assets/images/notFound.png"),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle),
            ),
            SizedBox(
              width: 5,
            ),
            Flexible(
              child: Text(
                widget.product.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed,
                    fontWeight: FontWeight.bold,
                    decorationThickness: 2),
              ),
            ),
          ],
        ),
        SizedBox(
          height: widget.mediaQueryData.size.height * 0.018,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                // SizedBox(
                //   width: widget.mediaQueryData.size.width * 0.152,
                // ),
                Flexible(
                  child: Text(
                    temp == 0
                        ? DemoLocalizations.of(context)
                                .translate('QuantityAvailable') +
                            ' :  0'
                        : DemoLocalizations.of(context)
                                .translate('QuantityAvailable') +
                            '  : $temp',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            FittedBox(
              child: Text(
                DemoLocalizations.of(context).translate('Price'),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            FittedBox(
              child: Text(
                widget.product.price == null
                    ? "  : 0"
                    : " : " + widget.product.price.toString(),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        Spacer(
          flex: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                //////////////////////////////////////////////////////////////////////////////
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12)),
                ////////////////////////////////////////////////////ss
                // color: Colors.black,
                margin: EdgeInsets.only(bottom: 15, left: 5),
                // padding: EdgeInsets.all(3),
                width: widget.mediaQueryData.size.width * 0.13,
                height: widget.mediaQueryData.size.height * 0.05,
                // ignore: deprecated_member_use

                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      if (widget.product.choiceQuantity <= 0) {
                        widget.counter = 0;
                        widget.product.choiceQuantity = 0;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(DemoLocalizations.of(context)
                                .translate('ifQuantityIsOver')),
                            actions: [
                              MaterialButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(DemoLocalizations.of(context)
                                      .translate('OkayButton')))
                            ],
                          ),
                        );
                      } else {
                        widget.product.choiceQuantity--;
                        widget.counter--;
                      }
                    });
                  },
                  // child: Text( " ― " , style: TextStyle( fontSize: 15 , color: Colors.red),),
                  child: Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                  color: Colors.red[200],
                ),
              ),
            ),
            SizedBox(
              width: widget.mediaQueryData.size.width * 0.05,
            ),
            Container(
              height: widget.mediaQueryData.size.height * 0.06,
              child: Text(
                widget.product.restOfAmount != null
                    ? widget.product.choiceQuantity >=
                            widget.product.restOfAmount
                        ? widget.counter.toString()
                        : widget.product.choiceQuantity.toString()
                    : '0',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            SizedBox(
              width: widget.mediaQueryData.size.width * 0.04,
            ),
            Expanded(
              child: Container(
                  // decoration:
                  //     BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.only(bottom: 15),
                  // padding: EdgeInsets.all(3),
                  width: widget.mediaQueryData.size.width * 0.1,
                  height: widget.mediaQueryData.size.height * 0.05,
                  // ignore: deprecated_member_use
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        if (widget.quantity1 <= 0) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text(
                                DemoLocalizations.of(context)
                                    .translate('ifQuantityIsOver'),
                                textAlign: TextAlign.end,
                              ),
                              actions: [
                                MaterialButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(DemoLocalizations.of(context)
                                        .translate('OkayButton')))
                              ],
                            ),
                          );
                        } else {
                          if (widget.quantity1 <=
                              widget.product.quantity_limit) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text(
                                  ' هل تود المتابعة ام لا؟؟\n  يمكنك بيع هذا المنتج لكن سيتم تذكيرك بأن تقوم بعملية شراء\n أصبحت الكمية من هذا الدواء أقل من الكمية المسموح تجاوزها ',
                                  textAlign: TextAlign.end,
                                ),
                                actions: [
                                  MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.product.choiceQuantity++;
                                          widget.counter++;
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Text(DemoLocalizations.of(context)
                                          .translate('OkayButton'))),
                                  MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('no')),
                                ],
                              ),
                            );
                          } else {
                            widget.product.choiceQuantity++;
                            widget.counter++;
                          }
                        }
                      });
                    },
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(right: 40.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    // child: Text(
                    //   "+",
                    //   style: TextStyle(fontSize: 20, color: Colors.blue),
                    // ),

                    color: Colors.blue[300],
                  )),
            ),
            SizedBox(
              width: widget.mediaQueryData.size.width * 0.014,
            ),
          ],
        ),
        Spacer(),
      ],
    );
  }
}
