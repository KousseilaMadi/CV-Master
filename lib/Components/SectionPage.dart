import 'package:cv_maker/Utility/Memory.dart';
import 'package:flutter/material.dart';
import 'BottomPanel/BottomPanelFourButtons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class SectionPage extends StatelessWidget {
  final List<StatelessWidget> list;
  VoidCallback onadd, onremove, onsave, onpreview;
  String section;
  final int cvId;
  SectionPage(
      {required this.list,
      required this.onadd,
      required this.onremove,
      required this.onsave,
      required this.onpreview,
      required this.section,
      required this.cvId,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        (list.length == 0)
            ? Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.all(20),
                child: Text(
                  '${AppLocalizations.of(context)!.youDontHaveAny} ${section}\n ${AppLocalizations.of(context)!.clickPlusToAdd}',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView(
                children: [
                  ...list,
                  SizedBox(
                    height: 120,
                  )
                ],
              ),
        BottomPanelFourButtons(
          onadd: onadd,
          onremove: onremove,
          onsave: () {
            onsave();
          },
          onpreview: onpreview,
          cvId: cvId,
        )
      ],
    );
  }
}
