import 'dart:io';

import 'package:cv_maker/Components/CustomButton.dart';
import 'package:cv_maker/Pages/CV_Language.dart';
import 'package:cv_maker/Pages/CV_Actions.dart';
import 'package:cv_maker/Pages/Preview.dart';
import 'package:cv_maker/Pages/Sections.dart';
import 'package:cv_maker/Utility/CvGen.dart';
import 'package:cv_maker/Utility/Enums.dart';
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
      Navigate(
          context,
          CV_Language(
            cameFrom: 'home',
          ));
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
        alignment: Alignment.bottomCenter,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '${AppLocalizations.of(context)!.yourCvs}:',
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: IconButton.filled(
                    onPressed: () {
                      Navigate(
                          context,
                          CV_Language(
                            cameFrom: 'languageChangeButton',
                          ));
                    },
                    icon: Icon(Icons.translate_rounded),
                    color: colors.white,
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(colors.primary)),
                    iconSize: 32,
                  ),
                )
              ],
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 233, 238, 243)),
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
          SizedBox(
            height: 120,
          )
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
            borderRadius: BorderRadius.circular(15),
            color: Color(0xffbdc3c7),
          ),
          height: percent(20, 'h', context),
          width: percent(90, 'w', context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Picture(path: cv.personalInformation.picture)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 6),
                    child: Text(
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.grey[600]),
                      getLang(cv.CVlanguage),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(6, 6, 6, 0),
                      child: Text(
                        cv.personalInformation.fullName,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: colors.primary),
                      ),
                    ),
                    Column(
                      children: [
                        CustomButton(() {
                          Navigate(context, Preview(cvId: st.CVs.indexOf(cv)));
                        },
                            AppLocalizations.of(context)!.preview,
                            42,
                            height: 40,
                            Icons.preview,
                            ButtonType.text),
                        CustomButton(
                            fgcolor: colors.primary, bgcolor: colors.white, () {
                          Navigate(
                              context, CV_Actions(cvId: st.CVs.indexOf(cv)));
                        },
                            AppLocalizations.of(context)!.edit,
                            42,
                            height: 40,
                            Icons.preview,
                            ButtonType.text),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 6),
                        child: Text(
                            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}  ${DateTime.now().hour}:${DateTime.now().minute}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600]))),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

// ignore: must_be_immutable
class Picture extends StatelessWidget {
  String path;
  Picture({required this.path, super.key});

  @override
  Widget build(BuildContext context) {
    if (path != 'assets/images/default_picture.jpg') {
      return Image(
        height: 110,
        width: 110,
        image: FileImage(File(path)),
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        height: 110,
        width: 110,
        image: AssetImage('assets/images/default_picture.jpg'),
        fit: BoxFit.cover,
      );
    }
  }
}
