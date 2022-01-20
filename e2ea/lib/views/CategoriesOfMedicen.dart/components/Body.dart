//import 'package:last/counter.dart';

import 'package:e2ea/newModels/models/medicinmodel.dart';

import '../../../views/CategoriesOfMedicen.dart/components/GridViewMedicen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  Body({
    Key key,
    @required this.mediaQueryData,
    @required this.tabController,
    @required this.color,
    this.order,
    this.selectedIndex,
    this.counter,
  }) : super(key: key);

  final MediaQueryData mediaQueryData;
  final TabController tabController;
  final Map<String, List<Medicine>> color;
  List order;
  int selectedIndex;
  int counter;
  Radius radius;

  List<Widget> children() {
    List<Widget> childrenReturn = [];
    for (int i = 0; i < color.length; i++) {
      childrenReturn.add(GridViewMedicen(
          mediaQueryData: mediaQueryData, color: color.values.toList()[i]));
    }
    return childrenReturn;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: mediaQueryData.size.height * 0.004,
          ),
          Container(////////////////////////////////
            height: mediaQueryData.size.height,
            /////////////////////////////////////////
            width: double.infinity,
            child: TabBarView(
              physics: ClampingScrollPhysics(),
              controller: tabController,
              children: children(),
            ),
          ),
        ],
      ),
    );
  }
}

//test many of grid view
// SafeArea(
//       child: SingleChildScrollView(
//         child: Column(children: <Widget>[
//           SizedBox(
//             height: mediaQueryData.size.height * 0.03,
//           ),
//           Container(
//             height: 500,
//             width: mediaQueryData.size.width,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: ScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                   maxCrossAxisExtent: 200,
//                   crossAxisSpacing: 20,
//                   mainAxisSpacing: 20,
//                   childAspectRatio: 0.85,
//                 ),
//                 itemCount: color.length,
//                 itemBuilder: (context, index) {
//                   return CategoryItem(
//                     color: color,
//                     index: index,
//                   );
//                 },
//                 scrollDirection: Axis.horizontal,
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
