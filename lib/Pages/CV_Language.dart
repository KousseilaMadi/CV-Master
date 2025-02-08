import 'package:cv_maker/Pages/CV_Actions.dart';
import 'package:cv_maker/Pages/Home.dart';
import 'package:cv_maker/Pages/Sections.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/Percent.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import '../Utility/Colors.dart';
import '../Components/BottomPanel/BottomPanelOneButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class CV_Language extends StatefulWidget {
  int? cvId;

  CV_Language({this.cvId, super.key});

  @override
  State<CV_Language> createState() => _CV_Language();
}

class _CV_Language extends State<CV_Language> {
  int? pressedBtn;
  bool clickable = false;

  void onclick(int btn) {
    setState(() {
      pressedBtn = btn;
      clickable = true;
    });
  }

  int addCV() {
    st.CVs.add(CV(
      temp: 1,
      CVlanguage: '',
      educations: [EducationsT()],
      experiences: [ExperiencesT()],
      interests: [""],
      languages: [LanguagesT()],
      summary: "",
      personalInformation: PersonalInformationT(),
      references: [ReferencesT()],
      skills: [SkillsT()],
    ));
    cd.customs.add(Data(
        nameColor: 0xff212121,
        mainColor: 0xffacbcb6,
        accentColor: 0xfffdfdfd,
        levelBackgroundColor: 0xffd9d9d9,
        levelFillColor: 0xffbc6565,
        textColor: 0xff404543,
        headersColor: 0xff363636,
        subheadersColor: 0xff363636,
        textSize: 12,
        headersSize: 12,
        subheadersSize: 12,
        levelBarHeight: 12,
        levelBarWidth: 1.0));
    writeToCustomData();
    return st.CVs.length - 1;
  }

  Color selectedBtnbgc(int? i) {
    if (i == pressedBtn) return colors.highlight;
    return colors.secondary;
  }

  Color selectedBtnfgc(int? i) {
    return colors.primary;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> languages = [
      {
        'lang': AppLocalizations.of(context)!.english,
        'code': 'en',
        'image': 'English.png'
      },
      {
        'lang': AppLocalizations.of(context)!.arabic,
        'code': 'ar',
        'image': 'Arabic.png'
      },
      {
        'lang': AppLocalizations.of(context)!.french,
        'code': 'fr',
        'image': 'French.png'
      },
      {
        'lang': AppLocalizations.of(context)!.spanish,
        'code': 'es',
        'image': 'Spanish.png'
      },
      {
        'lang': AppLocalizations.of(context)!.german,
        'code': 'de',
        'image': 'German.png'
      },
      {
        'lang': AppLocalizations.of(context)!.tamazight,
        'code': 'be',
        'image': 'Tamazight.png'
      },
      {
        'lang': AppLocalizations.of(context)!.hindi,
        'code': 'hi',
        'image': 'Hindi.png'
      },
      {
        'lang': AppLocalizations.of(context)!.italian,
        'code': 'it',
        'image': 'Italian.png'
      },
      {
        'lang': AppLocalizations.of(context)!.russian,
        'code': 'ru',
        'image': 'Russian.png'
      },
      {
        'lang': AppLocalizations.of(context)!.turkish,
        'code': 'tu',
        'image': 'Turkish.png'
      },
    ];
    void onpress() {
      if (widget.cvId == null) {
        int cvId = addCV();
        st.CVs[cvId].CVlanguage = languages[pressedBtn!]['code']!;
        writeToStorage();
        Navigate(context, Sections(cvId: cvId, cameFrom: 'cvLanguage'), true);
      } else {
        print(languages[pressedBtn!]['code']!);
        st.CVs[widget.cvId!].CVlanguage = languages[pressedBtn!]['code']!;
        writeToStorage();
        Navigate(context, CV_Actions(cvId: widget.cvId!), true);
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
          title: Text(AppLocalizations.of(context)!.cvLanguage),
          backgroundColor: colors.primary,
        ),
        body: Container(
          height: percent(100, 'h', context),
          width: percent(100, 'w', context),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                children: [
                  LanguageTag(cvId: widget.cvId),
                  ...languages.map(
                    (el) {
                      return Container(
                        margin: EdgeInsets.all(2),
                        height: 70,
                        width: 370,
                        // color: colors.highlight,
                        child: ElevatedButton(
                          onPressed: () => onclick(languages.indexOf(el)),
                          style: ButtonStyle(
                              foregroundColor: WidgetStatePropertyAll(
                                  selectedBtnfgc(languages.indexOf(el))),
                              backgroundColor: WidgetStatePropertyAll(
                                  selectedBtnbgc(languages.indexOf(el)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 68,
                                width: 68,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/flags/${el['image']}'),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Text(
                                el['lang']!,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 140,
                  )
                ],
              ),
              BottomPanelOneButton(
                  clickable: clickable,
                  title: AppLocalizations.of(context)!.select,
                  onpress: onpress),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        if (widget.cvId == null) {
          Navigator.pop(context);
        } else {
          // Navigator.pop(context);

          Navigate(context, CV_Actions(cvId: widget.cvId!), false);
        }
        return true;
      },
    );
  }
}

// ignore: must_be_immutable
class LanguageTag extends StatelessWidget {
  int? cvId;
  LanguageTag({this.cvId, super.key});

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

    if (cvId != null) {
      return Align(
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
            getLang(st.CVs[cvId!].CVlanguage),
            style: TextStyle(
                fontSize: 22,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
    return Center();
  }
}
