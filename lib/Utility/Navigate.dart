import 'package:flutter/material.dart';

void Navigate(BuildContext context, Widget to) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => to));
}
