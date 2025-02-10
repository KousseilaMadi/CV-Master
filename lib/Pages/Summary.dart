import 'dart:convert';

import 'package:cv_maker/Components/BottomPanel/BottomPanelTwoButtons.dart';
import 'package:cv_maker/Components/Textinput.dart';
import 'package:cv_maker/Pages/Preview.dart';
import 'package:cv_maker/Utility/Dialogs.dart';
import 'package:cv_maker/Utility/Enums.dart';
import 'package:cv_maker/Utility/Memory.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:cv_maker/Utility/hasEmptyFields.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Utility/Colors.dart';
import '../Components/SectionsDrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Summary extends StatefulWidget {
  final int cvId;
  Summary({required this.cvId, super.key});
  @override
  State<Summary> createState() => _Summary();
}

class _Summary extends State<Summary> {
  TextEditingController summaryController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _initTmp();
  }

  void _initTmp() {
    memory.currentSection = 'summary';
    tmp.summary = jsonDecode(jsonEncode(st.CVs[widget.cvId].summary));
  }

  void saveSummary() {
    st.CVs[widget.cvId].summary = jsonDecode(jsonEncode(tmp.summary));
    setState(() {});
    writeToStorage();
    setUnsavedChanges('summary', false);
  }

  summaryListener(String value) {
    tmp.summary = value;
  }

  @override
  Widget build(BuildContext context) {
    summaryController.text = tmp.summary;
    // ignore: deprecated_member_use
    return WillPopScope(
        child: Scaffold(
          backgroundColor: colors.white,
          appBar: AppBar(
            foregroundColor: colors.white,
            titleTextStyle: TextStyle(fontSize: 28),
            centerTitle: true,
            toolbarHeight: 56,
            title: Text(AppLocalizations.of(context)!.summary),
            backgroundColor: colors.primary,
          ),
          body: Stack(
            children: [
              ListView(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                children: [
                  Textinput(
                    type: InputType.comment,
                    onchange: summaryListener,
                    inputController: summaryController,
                    title: '${AppLocalizations.of(context)!.summary}*',
                    heightValue: 280,
                    tmpValue: tmp.summary,
                    section: 'summary',
                  )
                ],
              ),
              BottomPanelTwoButtons(
                onpreview: () {
                  if (!hasUnsavedChanges(memory.currentSection)) {
                    Navigate(context, Preview(cvId: widget.cvId));
                  } else {
                    previewUnsavedChangesDialog(context, () {
                      saveSummary();
                      Navigate(context, Preview(cvId: widget.cvId));
                    });
                  }
                },
                title2ndBtn: AppLocalizations.of(context)!.save,
                on2ndBtnPress: () {
                  saveSummary();
                  Fluttertoast.showToast(msg: 'Saved');
                },
              ),
            ],
          ),
          drawer: SectionsDrawer(
            cvId: widget.cvId,
          ),
        ),
        onWillPop: () async {
          if (memory.unsavedChanges.summary) {
            unsavedChangesDialog(context, saveSummary);
          }
          return true;
        });
  }
}
