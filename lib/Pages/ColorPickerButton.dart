// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:cv_maker/Pages/CV_Actions.dart';
import 'package:cv_maker/Utility/Colors.dart';
import 'package:cv_maker/Utility/Percent.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import 'package:cv_maker/l10n/app_localizations.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerButton extends StatefulWidget {
  int cvId;
  String field;

  ColorPickerButton({required this.cvId, required this.field, super.key});

  @override
  State<ColorPickerButton> createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
                Color(cd.customs[widget.cvId].toJson()[widget.field]))),
        onPressed: () {
          Color tmpColor =
              Color(cd.customs[widget.cvId].toJson()[widget.field]);
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Text(AppLocalizations.of(context)!.pickAColor),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        hexInputBar: true,
                        enableAlpha: false,
                        paletteType: PaletteType.hsvWithValue,
                        pickerColor: Color(
                            cd.customs[widget.cvId].toJson()[widget.field]),
                        onColorChanged: (Color c) {
                          tmpColor = c;
                        },
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: Text(AppLocalizations.of(context)!.done),
                        onPressed: () {
                          Map<String, dynamic> TMP = jsonDecode(
                              jsonEncode(cd.customs[widget.cvId].toJson()));
                          TMP[widget.field] = tmpColor.value;
                          cd.customs[widget.cvId] =
                              Data.fromJson(jsonDecode(jsonEncode(TMP)));
                          setState(() => ());
                          writeToCustomData();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ));
        },
        child: Container(
          height: 45,
          width: percent(20, 'w', context),
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.change,
              style: TextStyle(fontSize: 18, color: colors.highlight),
            ),
          ),
        ),
      ),
    );
  }
}
