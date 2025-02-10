import 'dart:convert';

import 'package:cv_maker/Components/SectionPage.dart';
import 'package:cv_maker/Pages/Preview.dart';
import 'package:cv_maker/Utility/Dialogs.dart';
import 'package:cv_maker/Utility/Memory.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:cv_maker/Utility/hasEmptyFields.dart';
import 'package:flutter/material.dart';
import '../Utility/Colors.dart';
import '../Components/Forms/Language_form.dart';
import '../Components/SectionsDrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Languages extends StatefulWidget {
  final int cvId;
  const Languages({required this.cvId, super.key});
  @override
  State<Languages> createState() => _LanguageState();
}

class _LanguageState extends State<Languages> {
  int count = 0;
  List<LanguageForm> languages = [];

  @override
  void initState() {
    super.initState();
    _initTmp();
  }

  void _initTmp() {
    memory.currentSection = 'languages';
    tmp.languages = [];
    for (int i = 0; i < st.CVs[widget.cvId].languages.length; i++) {
      tmp.languages.add(LanguagesT.fromJson(
          jsonDecode(jsonEncode(st.CVs[widget.cvId].languages[i]))));
    }
  }

  void saveLanguages() {
    st.CVs[widget.cvId].languages = [];
    for (int i = 0; i < tmp.languages.length; i++) {
      st.CVs[widget.cvId].languages
          .add(LanguagesT.fromJson(jsonDecode(jsonEncode(tmp.languages[i]))));
    }
    languages = [];
    setState(() {});
    writeToStorage();
    setUnsavedChanges('languages', false);
  }

  void addLanguage() {
    tmp.languages.add(LanguagesT());
    st.CVs[widget.cvId].languages.add(LanguagesT());
    print(memory.unsavedChanges.languages);
    languages = [];
    Future.delayed(
        Duration.zero,
        () => setState(() {
              count++;
            }));
  }

  void removeLanguage() {
    if (count > 0) {
      tmp.languages.removeLast();
      st.CVs[widget.cvId].languages.removeLast();
    }
    languages = [];
    Future.delayed(
        Duration.zero,
        () => setState(() {
              if (count > 0) count--;
            }));
  }

  @override
  Widget build(BuildContext context) {
    count = (tmp.languages.isEmpty) ? 0 : tmp.languages.length;
    if (tmp.languages.isEmpty) {
      for (int i = 0; i < count; i++) {
        languages.add(LanguageForm(
          id: i,
          cvId: widget.cvId,
        ));
      }
    } else {
      for (int i = 0; i < count; i++) {
        languages.add(LanguageForm(
          id: i,
          cvId: widget.cvId,
          language: tmp.languages[i],
        ));
      }
    }
    // ignore: deprecated_member_use
    return WillPopScope(
        child: Scaffold(
          backgroundColor: colors.white,
          appBar: AppBar(
            foregroundColor: colors.white,
            titleTextStyle: TextStyle(fontSize: 28),
            centerTitle: true,
            toolbarHeight: 56,
            title: Text(AppLocalizations.of(context)!.languages),
            backgroundColor: colors.primary,
          ),
          drawer: SectionsDrawer(
            cvId: widget.cvId,
          ),
          body: SectionPage(
            list: languages,
            onadd: addLanguage,
            onremove: removeLanguage,
            onsave: saveLanguages,
            onpreview: () {
              if (!hasUnsavedChanges(memory.currentSection)) {
                Navigate(context, Preview(cvId: widget.cvId));
              } else {
                previewUnsavedChangesDialog(context, () {
                  saveLanguages();
                  Navigate(context, Preview(cvId: widget.cvId));
                });
              }
            },
            section: AppLocalizations.of(context)!.languages,
            cvId: widget.cvId,
          ),
        ),
        onWillPop: () async {
          if (memory.unsavedChanges.languages) {
            unsavedChangesDialog(context, saveLanguages);
          }
          for (var i = st.CVs[widget.cvId].languages.length - 1; i >= 0; i--) {
            if (st.CVs[widget.cvId].languages[i].toJson().toString() ==
                LanguagesT().toJson().toString()) {
              st.CVs[widget.cvId].languages.removeLast();
            }
          }
          return true;
        });
  }
}
