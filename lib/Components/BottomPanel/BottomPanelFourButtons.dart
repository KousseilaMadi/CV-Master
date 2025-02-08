import 'package:flutter/material.dart';
import '../../Utility/Colors.dart';
import '../../Utility/Percent.dart';
import '../../Utility/Enums.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../CustomButton.dart';

class BottomPanelFourButtons extends StatelessWidget {
  final VoidCallback onadd, onremove, onsave, onpreview;
  final int cvId;
  const BottomPanelFourButtons(
      {required this.onadd,
      required this.onremove,
      required this.onsave,
      required this.onpreview,
      required this.cvId,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      width: percent(100, 'w', context),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 6,
            ),
            BoxShadow(
              color: colors.secondary,
            ),
          ],
        ),
        height: 110,
        padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton(onadd, '', 22, Icons.add, ButtonType.icon),
                  CustomButton(onremove, '', 22, Icons.remove, ButtonType.icon),
                  CustomButton(onpreview, AppLocalizations.of(context)!.preview,
                      45, Icons.abc, ButtonType.text),
                ],
              ),
            ),
            Expanded(
                child: CustomButton(onsave, AppLocalizations.of(context)!.save,
                    95, Icons.abc, ButtonType.text))
          ],
        ),
      ),
    );
  }
}
