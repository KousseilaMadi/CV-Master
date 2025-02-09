import 'package:flutter/material.dart';
import '../../Utility/Colors.dart';
import '../../Utility/Percent.dart';

// ignore: must_be_immutable
class BottomPanelOneButton extends StatelessWidget {
  final String title;
  String page;
  final VoidCallback onpress;
  bool? clickable;

  BottomPanelOneButton(
      {required this.title,
      required this.onpress,
      required this.page,
      this.clickable,
      super.key});

  Color buttonColor = colors.primary;
  setbuttonColor() {
    if (clickable ?? true)
      buttonColor = colors.primary;
    else
      buttonColor = colors.secondary;
  }

  @override
  Widget build(BuildContext context) {
    Widget addIcon;
    if (page == 'home') {
      addIcon = Container(
          child: Row(children: [
        SizedBox(
          width: 20,
        ),
        Icon(
          Icons.add_circle_outline_rounded,
          size: 30,
          color: colors.white,
        )
      ]));
    } else {
      addIcon = Center();
    }

    setbuttonColor();
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 6,
        ),
        BoxShadow(
          color: colors.secondary,
        ),
      ]),
      height: 100,
      padding: EdgeInsets.fromLTRB(4, 18, 4, 8),
      child: ElevatedButton(
        onPressed: () => {if (clickable ?? true) onpress()},
        style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(colors.white),
            backgroundColor: WidgetStatePropertyAll(buttonColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
            ),
            addIcon,
          ],
        ),
      ),
    );
  }
}
