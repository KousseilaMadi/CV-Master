import 'dart:io';

import 'package:cv_maker/Pages/CV_Language.dart';
import 'package:cv_maker/Pages/CV_Actions.dart';
import 'package:cv_maker/Utility/CvGen.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/Percent.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import '../Utility/Colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Components/BottomPanel/BottomPanelOneButton.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    void onpress() {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => CV_Language()));
      Navigate(context, CV_Language(), false);
    }

    return Scaffold(
      backgroundColor: colors.white,
      appBar: AppBar(
        leading: Icon(Icons.abc_outlined, color: colors.primary),
        foregroundColor: colors.white,
        titleTextStyle: TextStyle(fontSize: 28),
        centerTitle: true,
        toolbarHeight: 56,
        title: Text(AppLocalizations.of(context)!.home),
        backgroundColor: colors.primary,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          CVsList(),
          BottomPanelOneButton(
              title: AppLocalizations.of(context)!.createNew, onpress: onpress),
        ],
      ),
    );
  }
}

class CVsList extends StatelessWidget {
  const CVsList({super.key});

  @override
  Widget build(BuildContext context) {
    if (st.CVs.isNotEmpty) {
      return GridView.count(
        padding: EdgeInsets.fromLTRB(4, 22, 4, 150),
        childAspectRatio: (4 / 6),
        crossAxisCount: 2,
        children: [
          ...st.CVs.map((cv) {
            return cvInstance(cv: cv);
          }),
        ],
      );
    }
    return Center(child: Text(AppLocalizations.of(context)!.youDontHaveAnyCVs));
  }
}

// ignore: must_be_immutable
class cvInstance extends StatelessWidget {
  CV cv;
  cvInstance({required this.cv, super.key});

  @override
  Widget build(BuildContext context) {
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

    return Center(
      child: InkWell(
        onTap: () async {
          Data custom = cd.customs[st.CVs.indexOf(cv)];
          await Template_01.generateNoArgs(st.CVs.indexOf(cv));
          Navigate(
              context,
              CV_Actions(
                cvId: st.CVs.indexOf(cv),
              ),
              false);
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: colors.secondary,
                border: Border.all(width: 1)),
            height: percent(100, 'h', context),
            width: percent(100, 'w', context),
            margin: EdgeInsets.all(2),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: percent(35, 'w', context) / 2,
                      height: percent(35, 'w', context) / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey[600],
                      ),
                      margin: EdgeInsets.fromLTRB(percent(2, 'w', context) / 2,
                          percent(5, 'w', context) / 2, 0, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Picture(
                            defaultP: cv.personalInformation.defaultPicture,
                            path: cv.personalInformation.picture),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          cv.personalInformation.fullName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ))
                  ],
                ),
                Positioned(
                  bottom: 8,
                  right: 12,
                  child: Text(
                    getLang(cv.CVlanguage),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

// ignore: must_be_immutable
class Picture extends StatelessWidget {
  String path;
  bool defaultP;
  Picture({required this.defaultP, required this.path, super.key});

  @override
  Widget build(BuildContext context) {
    if (!defaultP && path != '') {
      return Image(
        image: FileImage(File(path)),
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage('assets/images/default_picture.jpg'),
        fit: BoxFit.cover,
      );
    }
  }
}
