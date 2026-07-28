import 'dart:convert';

import 'package:cv_maker/Components/SectionPage.dart';
import 'package:cv_maker/Pages/Preview.dart';
import 'package:cv_maker/Utility/Dialogs.dart';
import 'package:cv_maker/Utility/Memory.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/isValidInput.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Utility/StorageHandler.dart';
import 'package:cv_maker/Components/SectionsDrawer.dart';
import 'package:flutter/material.dart';
import '../Utility/Colors.dart';
import '../Components/Forms/Education_form.dart';
import 'package:cv_maker/l10n/app_localizations.dart';

class Educations extends StatefulWidget {
  final int cvId;
  const Educations({required this.cvId, super.key});

  @override
  State<Educations> createState() => _EducationState();
}

class _EducationState extends State<Educations> {
  int count = 0;
  List<EducationForm> educations = [];

  @override
  void initState() {
    super.initState();
    _initTmp();
  }

  void _initTmp() {
    memory.currentSection = 'education';
    tmp.educations = [];
    for (int i = 0; i < st.CVs[widget.cvId].educations.length; i++) {
      tmp.educations.add(EducationsT.fromJson(
          jsonDecode(jsonEncode(st.CVs[widget.cvId].educations[i]))));
    }
  }

  void saveEducation() {
    if (checkIfDateIsValid()) {
      st.CVs[widget.cvId].educations = [];
      for (int i = 0; i < tmp.educations.length; i++) {
        st.CVs[widget.cvId].educations.add(
            EducationsT.fromJson(jsonDecode(jsonEncode(tmp.educations[i]))));
      }
    } else {
      customDialog(context, AppLocalizations.of(context)!.invalidFormat,
          AppLocalizations.of(context)!.dateFieldIsntFormedCorrectly);
    }
    educations = [];
    setState(() {});
    writeToStorage();
    setUnsavedChanges('education', false);
    Fluttertoast.showToast(msg: 'Saved');
  }

  void addEducation() {
    tmp.educations.add(EducationsT());
    st.CVs[widget.cvId].educations.add(EducationsT());
    educations = [];
    Future.delayed(
        Duration.zero,
        () => setState(() {
              count++;
            }));
  }

  bool checkIfDateIsValid() {
    for (var el in tmp.educations) {
      if ((el.startDate != '' && !Isvalidinput.date(el.startDate)) ||
          (el.endDate != '' && !Isvalidinput.date(el.endDate))) {
        return false;
      }
    }
    return true;
  }

  void removeEducation() {
    if (count > 0) {
      tmp.educations.removeLast();
      st.CVs[widget.cvId].educations.removeLast();
    }

    educations = [];
    Future.delayed(
        Duration.zero,
        () => setState(() {
              if (count > 0) count--;
            }));
  }

  @override
  Widget build(BuildContext context) {
    count = (tmp.educations.isEmpty) ? 0 : tmp.educations.length;

    if (tmp.educations.isEmpty) {
      for (int i = 0; i < count; i++) {
        educations.add(EducationForm(
          id: i,
          cvId: widget.cvId,
        ));
      }
    } else {
      for (int i = 0; i < count; i++) {
        educations.add(EducationForm(
          id: i,
          cvId: widget.cvId,
          education: tmp.educations[i],
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
            title: Text(AppLocalizations.of(context)!.education),
            backgroundColor: colors.primary,
          ),
          drawer: SectionsDrawer(
            cvId: widget.cvId,
          ),
          body: SectionPage(
            list: educations,
            onadd: addEducation,
            onremove: removeEducation,
            onsave: saveEducation,
            onpreview: () {
              if (checkIfDateIsValid()) {
                if (!hasUnsavedChanges(memory.currentSection)) {
                  Navigate(context, Preview(cvId: widget.cvId));
                } else {
                  previewUnsavedChangesDialog(context, () {
                    saveEducation();
                    Navigate(context, Preview(cvId: widget.cvId));
                  });
                }
              } else {
                customDialog(
                    context,
                    AppLocalizations.of(context)!.invalidFormat,
                    AppLocalizations.of(context)!.dateFieldIsntFormedCorrectly);
              }
            },
            section: AppLocalizations.of(context)!.education,
            cvId: widget.cvId,
          ),
        ),
        onWillPop: () async {
          if (checkIfDateIsValid()) {
            if (memory.unsavedChanges.education) {
              unsavedChangesDialog(context, saveEducation);
            }
            for (var i = st.CVs[widget.cvId].educations.length - 1;
                i >= 0;
                i--) {
              if (st.CVs[widget.cvId].educations[i].toJson().toString() ==
                  EducationsT().toJson().toString()) {
                st.CVs[widget.cvId].educations.removeLast();
              }
            }
          } else {
            customDialog(context, AppLocalizations.of(context)!.invalidFormat,
                AppLocalizations.of(context)!.dateFieldIsntFormedCorrectly);
          }

          return true;
        });
  }
}
