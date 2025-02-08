import 'package:flutter/material.dart';
import '../../Utility/Colors.dart';
import '../../Utility/Percent.dart';

// ignore: must_be_immutable
class BottomPanelOneButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  bool? clickable;

  BottomPanelOneButton(
      {required this.title, required this.onpress, this.clickable, super.key});

  Color buttonColor = colors.primary;
  setbuttonColor() {
    if (clickable ?? true)
      buttonColor = colors.primary;
    else
      buttonColor = colors.secondary;
  }

  @override
  Widget build(BuildContext context) {
    setbuttonColor();
    return Positioned(
      bottom: 0,
      width: percent(100, 'w', context),
      child: Container(
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
            child: Text(
              title,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
            ),
          )),
    );
  }
}
