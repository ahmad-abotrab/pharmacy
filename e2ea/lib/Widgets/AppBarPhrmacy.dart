import 'package:flutter/material.dart';

class AppBarPharmacy extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> buttons;
  final double titleSpaceing;
  final String title;
  const AppBarPharmacy({Key key, this.buttons, this.titleSpaceing, this.title})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: FittedBox(
        child: Text(
          title,
          // textDirection:
          //     Utility.isArabic(title) ? TextDirection.rtl : TextDirection.ltr,
        ),
      ),
      actions: buttons,
      titleSpacing: titleSpaceing,
    );
  }
}

/*
  final List<Widget> buttons;
  final double titleSpaceing;
  final String title;


    @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title,
        // textDirection:
        //     Utility.isArabic(title) ? TextDirection.rtl : TextDirection.ltr,
      ),
      actions: buttons,
      titleSpacing: titleSpaceing,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
*/
