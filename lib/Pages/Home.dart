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
      Navigate(
          context,
          CV_Language(
            cameFrom: 'home',
          ),
          false);
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
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigate(
            context,
            CV_Language(
              cameFrom: 'languageChangeButton',
            ),
            false);
      }),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Positioned(
                left: 0,
                top: 0,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Your CVs:',
                    style: TextStyle(fontSize: 26),
                  ),
                )),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: colors.secondary),
                width: percent(92, 'w', context),
                height: percent(80, 'h', context),
                child: CVsList(),
              ),
            )
          ]),
          Positioned(
              child: BottomPanelOneButton(
            title: AppLocalizations.of(context)!.createNew,
            onpress: onpress,
            page: 'home',
          )),
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
      return ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          ...st.CVs.map((cv) {
            return Column(children: [
              SizedBox(
                height: 2,
              ),
              cvInstance(cv: cv)
            ]);
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
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: colors.secondary,
          ),
          height: percent(18, 'h', context),
          width: percent(100, 'w', context),
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
