import 'dart:convert';

import 'package:cv_maker/Pages/Preview.dart';
import 'package:cv_maker/Utility/Dialogs.dart';
import 'package:cv_maker/Utility/Memory.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/hasEmptyFields.dart';

import '../Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import '../Utility/Colors.dart';
import '../Components/Forms/Experience_form.dart';
import '../Components/SectionsDrawer.dart';
import '../Components/SectionPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Experiences extends StatefulWidget {
  final int cvId;
  const Experiences({required this.cvId, super.key});
  @override
  State<Experiences> createState() => _ExperiencesState();
}

class _ExperiencesState extends State<Experiences> {
  int count = 0;
  List<ExperienceForm> experiences = [];

  @override
  void initState() {
    super.initState();
    _initTmp();
  }

  void _initTmp() {
    memory.currentSection = 'experiences';
    tmp.experiences = [];
    for (int i = 0; i < st.CVs[widget.cvId].experiences.length; i++) {
      tmp.experiences.add(ExperiencesT.fromJson(
          jsonDecode(jsonEncode(st.CVs[widget.cvId].experiences[i]))));
    }
  }

  void saveExperiences() {
    st.CVs[widget.cvId].experiences = [];
    for (int i = 0; i < tmp.experiences.length; i++) {
      st.CVs[widget.cvId].experiences.add(
          ExperiencesT.fromJson(jsonDecode(jsonEncode(tmp.experiences[i]))));
    }
    experiences = [];
    setState(() {});
    writeToStorage();
    setUnsavedChanges('experiences', false);
  }

  void addExperience() {
    tmp.experiences.add(ExperiencesT());
    st.CVs[widget.cvId].experiences.add(ExperiencesT());
    experiences = [];
    Future.delayed(
        Duration.zero,
        () => setState(() {
              count++;
            }));
  }

  void removeExperience() {
    if (count > 0) {
      tmp.experiences.removeLast();
      st.CVs[widget.cvId].experiences.removeLast();
    }
    experiences = [];
    Future.delayed(
        Duration.zero,
        () => setState(() {
              if (count > 0) count--;
            }));
  }

  @override
  Widget build(BuildContext context) {
    experiences = [];
    count = (tmp.experiences.isEmpty) ? 0 : tmp.experiences.length;
    if (tmp.educations.isEmpty) {
      for (int i = 0; i < count; i++) {
        experiences.add(ExperienceForm(
          id: i,
          cvId: widget.cvId,
        ));
      }
    } else {
      for (int i = 0; i < count; i++) {
        experiences.add(ExperienceForm(
          id: i,
          cvId: widget.cvId,
          experience: tmp.experiences[i],
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
            title: Text(AppLocalizations.of(context)!.experiences),
            backgroundColor: colors.primary,
          ),
          drawer: SectionsDrawer(
            cvId: widget.cvId,
          ),
          body: SectionPage(
            list: experiences,
            onadd: addExperience,
            onremove: removeExperience,
            onsave: saveExperiences,
            onpreview: () {
              if (!hasUnsavedChanges(memory.currentSection)) {
                Navigate(context, Preview(cvId: widget.cvId));
              } else {
                previewUnsavedChangesDialog(context, () {
                  saveExperiences();
                  Navigate(context, Preview(cvId: widget.cvId));
                });
              }
            },
            section: AppLocalizations.of(context)!.experiences,
            cvId: widget.cvId,
          ),
        ),
        onWillPop: () async {
          if (memory.unsavedChanges.experiences) {
            unsavedChangesDialog(context, saveExperiences);
          }
          for (var i = st.CVs[widget.cvId].experiences.length - 1;
              i >= 0;
              i--) {
            if (st.CVs[widget.cvId].experiences[i].toJson().toString() ==
                ExperiencesT().toJson().toString()) {
              st.CVs[widget.cvId].experiences.removeLast();
            }
          }
          return true;
        });
  }
}
