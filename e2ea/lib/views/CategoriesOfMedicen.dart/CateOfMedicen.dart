import 'package:e2ea/newModels/models/medicinmodel.dart';

import '../../counter.dart';

import '../../views/CategoriesOfMedicen.dart/components/AppBarCateMedicen.dart';
import '../../views/CategoriesOfMedicen.dart/components/Body.dart';
import '../../views/Register/Register.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoriesOfMedicen extends StatefulWidget {
  static int counter = 0;
  Map<String, List<Medicine>> cat;
  CategoriesOfMedicen({Key key, this.cat}) : super(key: key);

  @override
  _CategoriesOfMedicenState createState() => _CategoriesOfMedicenState();
}

class _CategoriesOfMedicenState extends State<CategoriesOfMedicen>
    with SingleTickerProviderStateMixin {
  //main variable
  TabController tabController;
  int selectedTab = 0;
  List order = [];
  var icongind;

  //_____________________________________

  List color = [
    {"color": Color(0xffff6968)},
    {"color": Color(0xff7a54ff)},
    {"color": Color(0xffff8f61)},
    {"color": Color(0xff2ac3ff)},
    {"color": Color(0xffff6968)},
    {"color": Color(0xff7a54ff)},
    {"color": Color(0xffff8f61)},
    {"color": Color(0xff2ac3ff)},
  ];

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: widget.cat.length, vsync: this, initialIndex: 0)
          ..addListener(
            () {
              setState(() {
                selectedTab = tabController.index;
              });
            },
          );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Counter counterproduct = Provider.of<Counter>(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // print('here in parent. : ' + widget.cat.length.toString());

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor:  Colors.white,
        ///AppBar_____________________________________
        appBar: AppBarCateMedicen(
          tabController: tabController,
          selectedIndex: selectedTab,
          tabTitle: widget.cat.keys.toList(),
        ),

        ///___________________________________________
        ///
        body: Body(
          mediaQueryData: mediaQueryData,
          tabController: tabController,
          color: widget.cat,
          selectedIndex: selectedTab,
          order: order,
        ),
        floatingActionButton: GestureDetector(
          onLongPress: () {},
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Register()));
              order = [];
            },
            child: Container(
              child: Column(
                children: [
                  Text(
                    // 'jj',
                    //CategoriesOfMedicen.counter.toString(),
                    counterproduct.counterProduct.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),

        //____________________________________________
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (BuildContext context) => Register()));
        //     order = [];
        //   },
        //   child: Container(
        //     child: Column(
        //       children: [
        //         Text(
        //           'jj',
        //           //CategoriesOfMedicen.counter.toString(),
        //          // counterproduct.counterProduct.toString(),
        //           style: TextStyle(color: Colors.white),
        //         ),
        //         Icon(
        //           Icons.shopping_cart,
        //           color: Colors.white,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        //bottomNavigationBar: BottomNavBar(mediaQueryData: mediaQueryData),

        ///_______________________________________________
      ),
    );
  }
}

// DefaultTabController(
//       length: ChoiceCategory.choiceCatefory.length,
//       child: Scaffold(
//         appBar: AppBarCateMedicen(
//           tabController: tabController1,
//         ),
//         body: SafeArea(
//           child: ListView(
//             padding: const EdgeInsets.only(left: 5.0),
//             children: <Widget>[
//               SizedBox(
//                 height: mediaQueryData.size.height * 0.015,
//               ),
//               Container(
//                 alignment: Alignment.topLeft,
//                 margin: EdgeInsets.only(left: 15),
//                 child: FittedBox(
//                   child: Text(
//                     "Categories",
//                     style: TextStyle(
//                       fontFamily: 'Varela',
//                       fontSize: 23,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: mediaQueryData.size.height * 0.01,
//               ),
//               TabBar(
//                 controller: tabController1,
//                 indicatorColor: Colors.transparent,
//                 labelColor: Color(0xFFC88D67),
//                 labelStyle: TextStyle(fontSize: 18),
//                 isScrollable: true,
//                 labelPadding: EdgeInsets.only(right: 45.0),
//                 unselectedLabelColor: Color(0xFFCDCDCD),
//                 tabs: ChoiceCategory.choiceCatefory
//                     .map((ChoiceCategory choiceCategory) {
//                   return Tab(
//                     text: choiceCategory.title,
//                     // icon: choiceCategory.icon,
//                   );
//                 }).toList(),
//               ),
//               Container(
//                   height: MediaQuery.of(context).size.height - 50.0,
//                   width: double.infinity,
//                   child: TabBarView(controller: tabController1, children: [
//                     buildContainertest(mediaQueryData),
//                     buildContainertest(mediaQueryData),
//                     buildContainertest(mediaQueryData),
//                     buildContainertest(mediaQueryData),
//                     buildContainertest(mediaQueryData),
//                     buildContainertest(mediaQueryData),
//                   ]))
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Container buildContainertest(MediaQueryData mediaQueryData) {
//     return Container(
//       height: 500,
//       width: mediaQueryData.size.width,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: GridView.builder(
//           shrinkWrap: true,
//           physics: ScrollPhysics(),
//           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 200,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 20,
//             childAspectRatio: 0.85,
//           ),
//           itemCount: color.length,
//           itemBuilder: (context, index) {
//             return CategoryItem(
//               color: color,
//               index: index,
//             );
//           },
//           scrollDirection: Axis.horizontal,
//         ),
//       ),
//     );
//   }

// body: Body(mediaQueryData: mediaQueryData, color: color),
// floatingActionButton: FloatingActionButton(
//   child: Icon(Icons.shopping_cart),
//   onPressed: () {
//     //tranfer to bill views

//   },
// ),

// Container(
//   height: 500,
//   width: mediaQueryData.size.width,
//   child: Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 8),
//     child: GridView.builder(
//       shrinkWrap: true,
//       physics: ScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 200,
//         crossAxisSpacing: 20,
//         mainAxisSpacing: 20,
//         childAspectRatio: 0.85,
//       ),
//       itemCount: color.length,
//       itemBuilder: (context, index) {
//         return CategoryItem(
//           color: color,
//           index: index,
//         );
//       },
//       scrollDirection: Axis.horizontal,
//     ),
//   ),
// ),
