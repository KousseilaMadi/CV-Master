import 'package:flutter/material.dart';

percent(double value, String axis, BuildContext context) {
  return (axis == 'h')
      ? ((value / 100) * MediaQuery.of(context).size.height)
      : ((value / 100) * MediaQuery.of(context).size.width);
}
