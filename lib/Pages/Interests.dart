import 'dart:convert';

import 'package:cv_maker/Components/SectionPage.dart';
import 'package:cv_maker/Pages/Preview.dart';
import 'package:cv_maker/Utility/CvGen.dart';
import 'package:cv_maker/Utility/Dialogs.dart';
import 'package:cv_maker/Utility/Memory.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:cv_maker/Utility/hasEmptyFields.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Utility/Colors.dart';
import '../Components/Forms/Interest_form.dart';
import '../Components/SectionsDrawer.dart';
import 'package:cv_maker/l10n/app_localizations.dart';

class Interests extends StatefulWidget {
  final int cvId;

  const Interests({required this.cvId, super.key});

  @override
  State<Interests> createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {
  int count = 0;
  List<InterestForm> interests = [];

  @override
  void initState() {
    super.initState();
    _initTmp();
  }

  void _initTmp() {
    memory.currentSection = 'interests';
    tmp.interests = [];
    for (int i = 0; i < st.CVs[widget.cvId].interests.length; i++) {
      tmp.interests
          .add(jsonDecode(jsonEncode(st.CVs[widget.cvId].interests[i])));
    }
  }

  void saveInterests() {
    st.CVs[widget.cvId].interests = [];
    for (int i = 0; i < tmp.interests.length; i++) {
      st.CVs[widget.cvId].interests
          .add(jsonDecode(jsonEncode(tmp.interests[i])));
    }
    interests = [];
    setState(() {});
    writeToStorage();
    setUnsavedChanges('interests', false);
    Fluttertoast.showToast(msg: 'Saved');
  }

  void addInterest() {
    tmp.interests.add('');
    st.CVs[widget.cvId].interests.add('');
    interests = [];
    Future.delayed(
        Duration.zero,
        () => setState(() {
              count++;
            }));
  }

  void removeInterest() {
    if (count > 0) {
      tmp.interests.removeLast();
      st.CVs[widget.cvId].interests.removeLast();
    }
    interests = [];
    Future.delayed(
        Duration.zero,
        () => setState(() {
              if (count > 0) count--;
            }));
  }

  @override
  Widget build(BuildContext context) {
    count = (tmp.interests.isEmpty) ? 0 : tmp.interests.length;

    if (tmp.interests.isEmpty) {
      for (int i = 0; i < count; i++) {
        interests.add(InterestForm(
          id: i,
          cvId: widget.cvId,
        ));
      }
    } else {
      for (int i = 0; i < count; i++) {
        interests.add(InterestForm(
          id: i,
          cvId: widget.cvId,
          interest: tmp.interests[i],
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
            title: Text(AppLocalizations.of(context)!.interests),
            backgroundColor: colors.primary,
          ),
          drawer: SectionsDrawer(
            cvId: widget.cvId,
          ),
          body: SectionPage(
            list: interests,
            onadd: addInterest,
            onremove: removeInterest,
            onsave: saveInterests,
            onpreview: () async {
              await Template_01.generateNoArgs(widget.cvId);
              if (!hasUnsavedChanges(memory.currentSection)) {
                Navigate(context, Preview(cvId: widget.cvId));
              } else {
                previewUnsavedChangesDialog(context, () {
                  saveInterests();
                  Navigate(context, Preview(cvId: widget.cvId));
                });
              }
            },
            section: AppLocalizations.of(context)!.interests,
            cvId: widget.cvId,
          ),
        ),
        onWillPop: () async {
          if (memory.unsavedChanges.interests) {
            unsavedChangesDialog(context, saveInterests);
          }
          for (var i = st.CVs[widget.cvId].interests.length - 1; i >= 0; i--) {
            print('value:${st.CVs[widget.cvId].interests[i].toString()}');
            if (st.CVs[widget.cvId].interests[i].toString() == '') {
              st.CVs[widget.cvId].interests.removeLast();
            }
          }
          return true;
        });
  }
}
