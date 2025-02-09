import 'dart:convert';

import 'package:cv_maker/Components/SectionPage.dart';
import 'package:cv_maker/Utility/Dialogs.dart';
import 'package:cv_maker/Utility/Memory.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:cv_maker/Utility/hasEmptyFields.dart';
import '../Components/SectionsDrawer.dart';
import 'package:flutter/material.dart';
import '../Utility/Colors.dart';
import '../Components/Forms/Skill_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Preview.dart';

// ignore: must_be_immutable
class Skills extends StatefulWidget {
  final int cvId;
  bool mem = true;
  Skills({required this.cvId, super.key});

  @override
  State<Skills> createState() => _Skills();
}

class _Skills extends State<Skills> {
  int count = 0;
  List<SkillForm> skills = [];

  @override
  void initState() {
    super.initState();
    _initTmp();
  }

  void _initTmp() {
    memory.currentSection = 'skills';
    tmp.skills = [];
    for (int i = 0; i < st.CVs[widget.cvId].skills.length; i++) {
      tmp.skills.add(SkillsT.fromJson(
          jsonDecode(jsonEncode(st.CVs[widget.cvId].skills[i]))));
    }
  }

  void saveSkills() {
    st.CVs[widget.cvId].skills = [];
    for (int i = 0; i < tmp.skills.length; i++) {
      st.CVs[widget.cvId].skills.add(tmp.skills[i]);
    }
    skills = [];
    setState(() {});
    writeToStorage();
    setUnsavedChanges('skills', false);
  }

  void addSkill() {
    tmp.skills.add(SkillsT());
    st.CVs[widget.cvId].skills.add(SkillsT());
    skills = [];
    Future.delayed(
        Duration.zero,
        () => setState(() {
              count++;
            }));
  }

  void removeSkill() {
    if (count > 0) {
      tmp.skills.removeLast();
      st.CVs[widget.cvId].skills.removeLast();
    }
    skills = [];
    Future.delayed(
        Duration.zero,
        () => setState(() {
              if (count > 0) count--;
            }));
  }

  @override
  Widget build(BuildContext context) {
    count = (tmp.skills.isEmpty) ? 0 : tmp.skills.length;

    if (tmp.skills.isEmpty) {
      for (int i = 0; i < count; i++) {
        skills.add(SkillForm(
          cvId: widget.cvId,
          id: i,
        ));
      }
    } else {
      for (int i = 0; i < count; i++) {
        skills.add(SkillForm(
          id: i,
          cvId: widget.cvId,
          skill: tmp.skills[i],
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
            title: Text(AppLocalizations.of(context)!.skills),
            backgroundColor: colors.primary,
          ),
          drawer: SectionsDrawer(
            cvId: widget.cvId,
          ),
          body: SectionPage(
            list: skills,
            onadd: addSkill,
            onremove: removeSkill,
            onsave: saveSkills,
            onpreview: () {
              if (!hasEmptyFields(widget.cvId)) {
                if (!hasUnsavedChanges(memory.currentSection)) {
                  Navigate(context, Preview(cvId: widget.cvId));
                } else {
                  previewUnsavedChangesDialog(context, () {
                    saveSkills();
                    Navigate(context, Preview(cvId: widget.cvId));
                  });
                }
              } else {
                missingFieldsDialog(context);
              }
            },
            section: 'skills',
            cvId: widget.cvId,
          ),
        ),
        onWillPop: () async {
          if (memory.unsavedChanges.skills) {
            unsavedChangesDialog(context, saveSkills);
          }
          return true;
        });
  }
}
