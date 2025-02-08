import 'package:cv_maker/Utility/Memory.dart';
import 'package:flutter/material.dart';
import 'BottomPanel/BottomPanelFourButtons.dart';
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
        ListView(
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
            Fluttertoast.showToast(msg: 'Saved');
          },
          onpreview: onpreview,
          cvId: cvId,
        )
      ],
    );
  }
}
