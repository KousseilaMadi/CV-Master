// ignore_for_file: deprecated_member_use

import 'package:cv_maker/Pages/CV_Actions.dart';
import 'package:cv_maker/Pages/ColorPickerButton.dart';
import 'package:cv_maker/Pages/Preview.dart';
import 'package:cv_maker/Utility/Colors.dart';
import 'package:cv_maker/Utility/CvGen.dart';
import 'package:cv_maker/Utility/Dialogs.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/Percent.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class Customization extends StatefulWidget {
  int cvId;
  Customization({required this.cvId, super.key});

  @override
  State<Customization> createState() => _Customization();
}

class _Customization extends State<Customization> {
  void setDefault() {
    cd.customs[widget.cvId].nameColor = 0xff323232;
    cd.customs[widget.cvId].mainColor = 0xffacbcb6;
    cd.customs[widget.cvId].accentColor = 0xfffdfdfd;
    cd.customs[widget.cvId].levelBackgroundColor = 0xffd9d9d9;
    cd.customs[widget.cvId].levelFillColor = 0xffbc6565;
    cd.customs[widget.cvId].textColor = 0xff404543;
    cd.customs[widget.cvId].headersColor = 0xff363636;
    cd.customs[widget.cvId].subheadersColor = 0xff363636;
    cd.customs[widget.cvId].textSize = 12;
    cd.customs[widget.cvId].headersSize = 12;
    cd.customs[widget.cvId].subheadersSize = 12;
    cd.customs[widget.cvId].levelBarHeight = 12;
    cd.customs[widget.cvId].levelBarWidth = 1.0;
    writeToCustomData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Center(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: colors.white),
                  onPressed: () => {Navigator.pop(context)}),
              foregroundColor: colors.white,
              titleTextStyle: TextStyle(fontSize: 28),
              centerTitle: true,
              toolbarHeight: 56,
              title: Text(AppLocalizations.of(context)!.customize),
              backgroundColor: colors.primary,
            ),
            floatingActionButton: Container(
                width: percent(42, 'w', context),
                height: 60,
                child: FloatingActionButton.large(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.secondary,
                  onPressed: () async {
                    await Template_01.generateNoArgs(widget.cvId);
                    Navigate(context, Preview(cvId: widget.cvId));
                  },
                  child: Text(
                    AppLocalizations.of(context)!.preview,
                    style: TextStyle(fontSize: 24),
                  ),
                )),
            body: Container(
                height: percent(100, 'h', context),
                width: percent(100, 'w', context),
                color: colors.secondary,
                child: ListView(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Title(
                            title: AppLocalizations.of(context)!.colors,
                            size: 24,
                          ),
                          TextButton(
                              onPressed: () {
                                confirmationDialog(context, setDefault);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.reset,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: colors.gold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: colors.gold),
                              ))
                        ],
                      ),
                      //color
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Title(title: AppLocalizations.of(context)!.name),
                          ColorPickerButton(
                              cvId: widget.cvId, field: 'nameColor'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Title(title: AppLocalizations.of(context)!.main),
                          ColorPickerButton(
                              cvId: widget.cvId, field: 'mainColor'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Title(title: AppLocalizations.of(context)!.accent),
                          ColorPickerButton(
                              cvId: widget.cvId, field: 'accentColor'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Title(
                              title: AppLocalizations.of(context)!
                                  .levelBackground),
                          ColorPickerButton(
                              cvId: widget.cvId, field: 'levelBackgroundColor'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Title(title: AppLocalizations.of(context)!.levelFill),
                          ColorPickerButton(
                              cvId: widget.cvId, field: 'levelFillColor'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Title(title: AppLocalizations.of(context)!.text),
                          ColorPickerButton(
                              cvId: widget.cvId, field: 'textColor'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Title(title: AppLocalizations.of(context)!.headers),
                          ColorPickerButton(
                              cvId: widget.cvId, field: 'headersColor'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Title(
                              title: AppLocalizations.of(context)!.subheaders),
                          ColorPickerButton(
                              cvId: widget.cvId, field: 'subheadersColor'),
                        ],
                      ),
                      Title(
                        title: AppLocalizations.of(context)!.fontSize,
                        size: 24,
                      ),
                      //fonttitle: size
                      Title(title: AppLocalizations.of(context)!.textSize),
                      SliderC(
                        minValue: 8,
                        maxValue: 26,
                        onchange: (value) {
                          cd.customs[widget.cvId].textSize = value;
                          writeToCustomData();
                        },
                        value: cd.customs[widget.cvId].textSize,
                      ),
                      Title(title: AppLocalizations.of(context)!.headersSize),
                      SliderC(
                        minValue: 10,
                        maxValue: 30,
                        onchange: (value) {
                          print(value);
                          cd.customs[widget.cvId].headersSize = value;
                          writeToCustomData();
                        },
                        value: cd.customs[widget.cvId].headersSize,
                      ),
                      Title(
                          title: AppLocalizations.of(context)!.subheadersSize),
                      SliderC(
                        minValue: 10,
                        maxValue: 28,
                        onchange: (value) {
                          cd.customs[widget.cvId].subheadersSize = value;
                          writeToCustomData();
                        },
                        value: cd.customs[widget.cvId].subheadersSize,
                      ),
                      Title(
                          title: AppLocalizations.of(context)!.levelBarHeight),
                      SliderC(
                        minValue: 2,
                        maxValue: 30,
                        onchange: (value) {
                          cd.customs[widget.cvId].levelBarHeight = value;
                          writeToCustomData();
                        },
                        value: cd.customs[widget.cvId].levelBarHeight,
                      ),
                      Title(title: AppLocalizations.of(context)!.levelBarWidth),
                      SliderC(
                        minValue: .2,
                        maxValue: 1,
                        onchange: (value) {
                          cd.customs[widget.cvId].levelBarWidth = value;
                          writeToCustomData();
                        },
                        value: cd.customs[widget.cvId].levelBarWidth,
                      ),

                      //text helper

                      // Title(title: AppLocalizations.of(context)!.fixCasing),
                      // CheckboxC(),
                      SizedBox(
                        height: 80,
                      )
                    ],
                  )
                ])),
          ),
        ),
        onWillPop: () async {
          await Template_01.generateNoArgs(widget.cvId);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigate(context, CV_Actions(cvId: widget.cvId));
          return true;
        });
  }
}

// ignore: must_be_immutable
class Title extends StatelessWidget {
  String title;
  double? size;
  Title({required this.title, this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(12, 14, 2, 10),
        child: Text(
          '$title',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: size ?? 20),
        ));
  }
}

// ignore: must_be_immutable
class SliderC extends StatefulWidget {
  final double maxValue;
  final double minValue;
  double value;
  Function onchange;
  SliderC(
      {required this.maxValue,
      required this.minValue,
      required this.onchange,
      required this.value,
      super.key});

  @override
  State<SliderC> createState() => _SliderC();
}

class _SliderC extends State<SliderC> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: widget.value,
      onChanged: (value) => {
        setState(() {
          widget.value = value;
          widget.onchange(value);
        })
      },
      max: widget.maxValue,
      activeColor: colors.primary,
      inactiveColor: colors.white,
      thumbColor: colors.secondary,
      min: widget.minValue,
    );
  }
}

class CheckboxC extends StatefulWidget {
  const CheckboxC({super.key});

  @override
  State<CheckboxC> createState() => _CheckboxCState();
}

class _CheckboxCState extends State<CheckboxC> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: checked,
        onChanged: (v) => {
              setState(() {
                checked = v!;
              })
            });
  }
}
