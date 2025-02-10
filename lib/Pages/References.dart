import 'dart:convert';

import 'package:cv_maker/Components/SectionPage.dart';
import 'package:cv_maker/Components/SectionsDrawer.dart';
import 'package:cv_maker/Pages/Preview.dart';
import 'package:cv_maker/Utility/Dialogs.dart';
import 'package:cv_maker/Utility/Memory.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:cv_maker/Utility/hasEmptyFields.dart';
import 'package:flutter/material.dart';
import '../Utility/Colors.dart';
import '../Components/Forms/Reference_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class References extends StatefulWidget {
  final int cvId;
  const References({required this.cvId, super.key});

  @override
  State<References> createState() => _References();
}

class _References extends State<References> {
  int count = 0;
  List<ReferenceForm> references = [];

  @override
  void initState() {
    super.initState();
    _initTmp();
  }

  void _initTmp() {
    memory.currentSection = 'references';
    tmp.references = [];
    for (int i = 0; i < st.CVs[widget.cvId].references.length; i++) {
      tmp.references.add(ReferencesT.fromJson(
          jsonDecode(jsonEncode(st.CVs[widget.cvId].references[i]))));
    }
  }

  void saveReferences() {
    st.CVs[widget.cvId].references = [];
    for (int i = 0; i < tmp.references.length; i++) {
      st.CVs[widget.cvId].references.add(tmp.references[i]);
    }
    references = [];
    setState(() {});
    writeToStorage();
    setUnsavedChanges('references', false);
  }

  void addReferences() {
    tmp.references.add(ReferencesT());
    st.CVs[widget.cvId].references.add(ReferencesT());
    references = [];
    Future.delayed(
        Duration.zero,
        () => setState(() {
              count++;
            }));
  }

  void removeReferences() {
    if (count > 0) tmp.references.removeLast();
    st.CVs[widget.cvId].references.removeLast();
    references = [];
    Future.delayed(
        Duration.zero,
        () => setState(() {
              if (count > 0) count--;
            }));
  }

  @override
  Widget build(BuildContext context) {
    count = (tmp.references.isEmpty) ? 0 : tmp.references.length;
    if (tmp.references.isEmpty) {
      for (int i = 0; i < count; i++) {
        references.add(ReferenceForm(
          id: i,
          cvId: widget.cvId,
        ));
      }
    } else {
      for (int i = 0; i < count; i++) {
        references.add(ReferenceForm(
          id: i,
          cvId: widget.cvId,
          reference: tmp.references[i],
        ));
      }
    }
    return WillPopScope(
        child: Scaffold(
          backgroundColor: colors.white,
          appBar: AppBar(
            foregroundColor: colors.white,
            titleTextStyle: TextStyle(fontSize: 28),
            centerTitle: true,
            toolbarHeight: 56,
            title: Text(AppLocalizations.of(context)!.references),
            backgroundColor: colors.primary,
          ),
          drawer: SectionsDrawer(
            cvId: widget.cvId,
          ),
          body: SectionPage(
            list: references,
            onadd: addReferences,
            onremove: removeReferences,
            onsave: saveReferences,
            onpreview: () {
              if (!hasUnsavedChanges(memory.currentSection)) {
                Navigate(context, Preview(cvId: widget.cvId));
              } else {
                previewUnsavedChangesDialog(context, () {
                  saveReferences();
                  Navigate(context, Preview(cvId: widget.cvId));
                });
              }
            },
            section: AppLocalizations.of(context)!.references,
            cvId: widget.cvId,
          ),
        ),
        onWillPop: () async {
          if (memory.unsavedChanges.references) {
            unsavedChangesDialog(context, saveReferences);
          }
          for (var i = st.CVs[widget.cvId].references.length - 1; i >= 0; i--) {
            if (st.CVs[widget.cvId].references[i].toJson().toString() ==
                ReferencesT().toJson().toString()) {
              st.CVs[widget.cvId].references.removeLast();
            }
          }
          return true;
        });
  }
}
