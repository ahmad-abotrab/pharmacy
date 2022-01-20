//import 'package:last/views/MainHome/MainScreen.dart';
import 'package:flutter/material.dart';

class ItemBottomNavBar {
  IconData iconData;
  String text;
  Color color;
  ItemBottomNavBar({this.text, this.color, this.iconData});
}

// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    Key key,
    @required this.mediaQueryData,
  }) : super(key: key);

  final MediaQueryData mediaQueryData;
  int selectedIndex = 0;
  bool isSelected = false;
  int durationAnimated = 300;
  List<ItemBottomNavBar> list_itemBottomNavBar = [
    ItemBottomNavBar(
        text: 'Home', color: Colors.blue[300], iconData: Icons.home),
    ItemBottomNavBar(
        text: 'Sales', color: Colors.pink[400], iconData: Icons.sailing),
    ItemBottomNavBar(
        text: 'buying', color: Colors.grey, iconData: Icons.search),
    ItemBottomNavBar(
        text: 'profile', color: Colors.green, iconData: Icons.person),
  ];

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      elevation: 1,
      color: Colors.white54,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: widget.mediaQueryData.size.height * 0.01,
            top: widget.mediaQueryData.size.height * 0.01,
            left: widget.mediaQueryData.size.height * 0.015,
            right: widget.mediaQueryData.size.height * 0.015),
        //padding: EdgeInsets.all(widget.mediaQueryData.size.height * 0.01),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              buildItemInNavBar(durationAnimated: widget.durationAnimated),
        ),
      ),
    );
  }

  buildItemInNavBar({int durationAnimated}) {
    List<Widget> buildItems = [];
    ItemBottomNavBar itemBottomNavBar = new ItemBottomNavBar();
    for (int i = 0; i < widget.list_itemBottomNavBar.length; i++) {
      itemBottomNavBar = widget.list_itemBottomNavBar[i];
      widget.isSelected = widget.selectedIndex == i;

      buildItems.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            widget.selectedIndex = i;
          });
        },
        child: buildAnimatedContainer(durationAnimated, itemBottomNavBar),
      ));
    }
    return buildItems;
  }

  AnimatedContainer buildAnimatedContainer(
      int durationAnimated, ItemBottomNavBar itemBottomNavBar) {
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      duration: Duration(milliseconds: durationAnimated),
      decoration: BoxDecoration(
        color: widget.isSelected
            ? itemBottomNavBar.color.withOpacity(0.6)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            itemBottomNavBar.iconData,
            color: widget.isSelected ? itemBottomNavBar.color : Colors.black,
          ),
          SizedBox(
            width: widget.mediaQueryData.size.width * 0.01,
          ),
          AnimatedSize(
            duration: Duration(milliseconds: durationAnimated),
            vsync: this,
            curve: Curves.easeInCubic,
            child: Text(
              widget.isSelected ? itemBottomNavBar.text : "",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'DancingScript',
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
