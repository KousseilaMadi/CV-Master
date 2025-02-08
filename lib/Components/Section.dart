import 'package:cv_maker/Utility/Colors.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String title;
  final Widget goto;
  const Section({required this.title, required this.goto, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(4, 2, 4, 0),
        height: 190,
        width: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45), color: colors.secondary),
        child: TextButton(
            onPressed: () => {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => goto))
                },
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 34,
                  color: colors.primary,
                  fontWeight: FontWeight.w400),
            )));
  }
}
