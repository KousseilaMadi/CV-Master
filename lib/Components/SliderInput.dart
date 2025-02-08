import 'package:cv_maker/Utility/Colors.dart';
import 'package:cv_maker/Utility/Memory.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SliderInput extends StatefulWidget {
  int id;
  String section;
  double initValue;
  double tmpValue;
  SliderInput(
      {required this.id,
      required this.initValue,
      required this.section,
      required this.tmpValue,
      super.key});

  @override
  State<SliderInput> createState() => _SliderInputState();
}

class _SliderInputState extends State<SliderInput> {
  // double v = .4;
  Color thumbcolor = colors.gold;
  @override
  Widget build(BuildContext context) {
    return Slider(
        min: .18,
        activeColor: colors.primary,
        thumbColor: thumbcolor,
        value: widget.initValue,
        onChanged: (double nv) {
          if (nv != widget.tmpValue) {
            thumbcolor = colors.primary;
            setUnsavedChanges(widget.section, true);
          } else {
            thumbcolor = colors.secondary;
            setUnsavedChanges(widget.section, false);
          }
          if (widget.section == 'languages') {
            tmp.languages[widget.id].level = nv;
          }
          if (widget.section == 'skills') {
            tmp.skills[widget.id].level = nv;
          }
          setState(() {
            widget.initValue = nv;
          });
        });
  }
}
