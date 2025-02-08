import 'package:flutter/material.dart';
import '../../Utility/Colors.dart';
import '../../Utility/Percent.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class BottomPanelTwoButtons extends StatelessWidget {
  VoidCallback onpreview, on2ndBtnPress;
  String title2ndBtn;
  BottomPanelTwoButtons(
      {required this.onpreview,
      required this.on2ndBtnPress,
      required this.title2ndBtn,
      super.key});

  @override
  Widget build(BuildContext context) {
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
        height: 90,
        padding: EdgeInsets.fromLTRB(4, 26, 4, 8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  width: percent(45, 'w', context),
                  child: ElevatedButton(
                    onPressed: onpreview,
                    style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(colors.white),
                        backgroundColor:
                            WidgetStatePropertyAll(colors.primary)),
                    child: Text(
                      AppLocalizations.of(context)!.preview,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  )),
              Container(
                  width: percent(45, 'w', context),
                  child: ElevatedButton(
                    onPressed: on2ndBtnPress,
                    style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(colors.white),
                        backgroundColor:
                            WidgetStatePropertyAll(colors.primary)),
                    child: Text(
                      title2ndBtn,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  )),
            ]),
      ),
    );
  }
}
