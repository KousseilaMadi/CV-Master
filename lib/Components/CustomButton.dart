import 'package:flutter/material.dart';
import '../Utility/Enums.dart';
import '../Utility/Percent.dart';
import '../Utility/Colors.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double? height;
  final ButtonType type;
  final IconData icon;
  final String title;
  final Color? fgcolor;
  final Color? bgcolor;
  final VoidCallback onpress;
  const CustomButton(this.onpress, this.title, this.width, this.icon, this.type,
      {this.height, this.fgcolor, this.bgcolor, super.key});

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.text) {
      return Container(
        height: height ?? 55,
        margin: EdgeInsets.all(2),
        width: percent(width, 'w', context),
        child: ElevatedButton(
          onPressed: onpress,
          style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(fgcolor ?? colors.white),
              backgroundColor:
                  WidgetStatePropertyAll(bgcolor ?? colors.primary)),
          child: Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(2),
        width: percent(width, 'w', context),
        child: ElevatedButton(
          onPressed: onpress,
          style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(colors.white),
              backgroundColor: WidgetStatePropertyAll(colors.primary)),
          child: Icon(
            icon,
            size: 34,
            color: colors.white,
          ),
        ),
      );
    }
  }
}
