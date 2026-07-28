import 'package:cv_maker/Components/BottomPanel/BottomPanelOneButton.dart';
import 'package:cv_maker/Pages/CV_Actions.dart';
import 'package:cv_maker/Pages/Educations.dart';
import 'package:cv_maker/Pages/Experiences.dart';
import 'package:cv_maker/Pages/Home.dart';
import 'package:cv_maker/Pages/Interests.dart';
import 'package:cv_maker/Pages/Languages.dart';
import 'package:cv_maker/Pages/Personal_Information.dart';
import 'package:cv_maker/Pages/Preview.dart';
import 'package:cv_maker/Pages/References.dart';
import 'package:cv_maker/Pages/Skills.dart';
import 'package:cv_maker/Utility/CvGen.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:cv_maker/Utility/hasEmptyFields.dart';
import 'package:flutter/material.dart';
import '../Utility/Colors.dart';
import '../Components/Section.dart';
import '../Pages/Summary.dart';
import 'package:cv_maker/l10n/app_localizations.dart';

class Sections extends StatelessWidget {
  final int cvId;
  String? cameFrom;

  Sections({required this.cvId, this.cameFrom, super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map> sections = [
      {
        'name': AppLocalizations.of(context)!.personalInformation,
        'widget': PersonalInformation(cvId: cvId)
      },
      {
        'name': AppLocalizations.of(context)!.summary,
        'widget': Summary(cvId: cvId)
      },
      {
        'name': AppLocalizations.of(context)!.education,
        'widget': Educations(cvId: cvId)
      },
      {
        'name': AppLocalizations.of(context)!.experiences,
        'widget': Experiences(cvId: cvId)
      },
      {
        'name': AppLocalizations.of(context)!.references,
        'widget': References(cvId: cvId)
      },
      {
        'name': AppLocalizations.of(context)!.interest,
        'widget': Interests(cvId: cvId)
      },
      {
        'name': AppLocalizations.of(context)!.skills,
        'widget': Skills(cvId: cvId)
      },
      {
        'name': AppLocalizations.of(context)!.languages,
        'widget': Languages(cvId: cvId)
      },
    ];

    String getLang(String code) {
      switch (code) {
        case 'en':
          return AppLocalizations.of(context)!.english;
        case 'ar':
          return AppLocalizations.of(context)!.arabic;
        case 'fr':
          return AppLocalizations.of(context)!.french;
        case 'es':
          return AppLocalizations.of(context)!.spanish;
        case 'de':
          return AppLocalizations.of(context)!.german;
        case 'be':
          return AppLocalizations.of(context)!.tamazight;
        case 'hi':
          return AppLocalizations.of(context)!.hindi;
        case 'it':
          return AppLocalizations.of(context)!.italian;
        case 'ru':
          return AppLocalizations.of(context)!.russian;
        case 'tu':
          return AppLocalizations.of(context)!.turkish;
        default:
          return '';
      }
    }

    return WillPopScope(
      child: Scaffold(
        backgroundColor: colors.white,
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: colors.white),
          //   onPressed: () => Navigator.pop(context),
          // ),
          foregroundColor: colors.white,
          titleTextStyle: TextStyle(fontSize: 28),
          centerTitle: true,
          toolbarHeight: 56,
          title: Text(AppLocalizations.of(context)!.sections),
          backgroundColor: colors.primary,
        ),
        body: Stack(alignment: Alignment.bottomCenter, children: [
          Positioned(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(3, 12, 3, 0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      // height: 40,
                      // width: 70,
                      margin: EdgeInsets.fromLTRB(12, 4, 0, 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: colors.gold,
                      ),
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 6),
                      child: Text(
                        getLang(st.CVs[cvId].CVlanguage),
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  ...sections.map((el) {
                    return Section(
                      title: el['name'],
                      goto: el['widget'],
                    );
                  }),
                  SizedBox(
                    height: 150,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              child: BottomPanelOneButton(
            title: AppLocalizations.of(context)!.preview,
            onpress: () async {
              await Template_01.generateNoArgs(cvId);
              Navigate(context, Preview(cvId: cvId));
            },
            page: 'sections',
          ))
        ]),
      ),
      onWillPop: () async {
        Navigator.pop(context);
        if (cameFrom != null) {
          if (cameFrom == 'cvActions') {
            Navigator.pop(context);
            Navigate(
                context,
                CV_Actions(
                  cvId: cvId,
                ));
          }
          if (cameFrom == 'cvLanguage') {
            Navigator.pop(context);
            Navigate(context, Home());
          }
        } else {
          Navigate(context, Home());
        }
        return true;
      },
    );
  }
}
