import 'package:cv_maker/Utility/Enums.dart';
import 'package:cv_maker/Utility/Memory.dart';
import 'package:flutter/material.dart';
import '../Utility/Colors.dart';

// ignore: must_be_immutable
class Textinput extends StatefulWidget {
  final String title;
  final InputType type;
  final Function(String) onchange;
  final TextEditingController inputController;
  final double? heightValue;
  final String? hint;
  String tmpValue;
  final String section;

  Textinput(
      {required this.type,
      required this.title,
      required this.onchange,
      required this.inputController,
      this.heightValue,
      this.hint,
      required this.tmpValue,
      required this.section,
      super.key});

  @override
  State<Textinput> createState() => _Textinput();
}

class _Textinput extends State<Textinput> {
  @override
  void initState() {
    super.initState();
    setUnsavedChanges(widget.section, false);
  }

  BoxDecoration? border;
  bool allowexit = true;
  BoxDecoration editedBorder = BoxDecoration(
    color: colors.secondary,
    border: Border.all(color: colors.primary, width: 2),
    borderRadius: BorderRadius.circular(14),
  );
  BoxDecoration nonEditedBorder = BoxDecoration(
    color: colors.secondary,
    border: Border.all(color: colors.secondary, width: 2),
    borderRadius: BorderRadius.circular(14),
  );
  @override
  Widget build(BuildContext context) {
    // sets the borders of the input fields to indicate weather there is unsaved changes or not
    // ps: it's called here cause after rerendering due to dismissing keyboard this conditionn will proov useful
    if (widget.tmpValue != widget.inputController.text) {
      border = editedBorder;
    } else {
      border = nonEditedBorder;
    }
    //updates the unsaved changes object and sets the borders as well to the corresponding border on every key stroke
    void change(String v) {
      widget.onchange(v);
      if (widget.tmpValue != widget.inputController.text) {
        border = editedBorder;
        setUnsavedChanges(widget.section, true);
      } else {
        setUnsavedChanges(widget.section, false);
        border = nonEditedBorder;
      }
      setState(() {});
    }

    if (widget.type == InputType.nocomment) {
      return Container(
        height: 80,
        decoration: border,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(8, 0, 8, 4),
        child: TextField(
          onChanged: change,
          controller: widget.inputController,
          cursorHeight: 26,
          cursorColor: colors.primary,
          style: TextStyle(fontSize: 24, color: colors.primary),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: 20),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: widget.title,
            border: InputBorder.none,
            labelStyle: TextStyle(fontSize: 28, color: colors.primary),
          ),
        ),
      );
    }
    return Container(
      height: widget.heightValue ?? 180,
      padding: EdgeInsets.all(10),
      decoration: border,
      margin: EdgeInsets.fromLTRB(8, 0, 8, 4),
      child: TextField(
        onChanged: change,
        controller: widget.inputController,
        cursorHeight: 26,
        cursorColor: colors.primary,
        keyboardType: TextInputType.multiline,
        maxLines: 6,
        style: TextStyle(fontSize: 24, color: colors.primary),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(fontSize: 20),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.title,
          border: InputBorder.none,
          labelStyle: TextStyle(fontSize: 28, color: colors.primary),
        ),
      ),
    );
  }
}
