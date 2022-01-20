import 'package:e2ea/newModels/models/medicinmodel.dart';



import '../../../Widgets/CategoryItem.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GridViewMedicen extends StatefulWidget {
  GridViewMedicen({
    Key key,
    @required this.mediaQueryData,
    @required this.color,
    this.typeOfMed,
  }) : super(key: key);
  final MediaQueryData mediaQueryData;
  final String typeOfMed;
  List<Medicine> color;
  
  @override
  _GridViewMedicenState createState() => _GridViewMedicenState();
}

class _GridViewMedicenState extends State<GridViewMedicen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
  
    // print('here in class grid view.  : ' +
    //     widget.enteringToBuildGrid.length.toString());
    return AnimatedContainer(
        duration: Duration(microseconds: 0),
        width: widget.mediaQueryData.size.width,
        child: AnimatedSize(
          duration: Duration(microseconds: 0),
          //curve: Curves.easeIn,
          vsync: this,
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: widget.mediaQueryData.size.width * 0.015),
            padding: EdgeInsets.symmetric(
                horizontal: widget.mediaQueryData.size.width * 0.015),
            // child: Padding(
            //padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GridView.builder(
              shrinkWrap: true,
              //physics: ,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 23,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: widget
                  .color.length, //here to ceate list of grid
              itemBuilder: (context, index) {
                return CategoryItem(
                  removeIcon: false,
                  mediaQueryData: widget.mediaQueryData,
                  product: widget.color[index],
                  index: index,
                );
              },
            ),
          ),
        ));
  }
}
