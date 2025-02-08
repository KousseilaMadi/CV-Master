import 'package:flutter/material.dart';

void Navigate(BuildContext context, Widget to, bool pop) {
  if (pop) Navigator.pop(context);
  Navigator.push(context, MaterialPageRoute(builder: (context) => to));
  // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => to));
  // });
}
