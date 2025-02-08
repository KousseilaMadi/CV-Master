import 'dart:io';
import 'package:cv_maker/Utility/CvLanguages.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'StorageHandler.dart';

class Template_01 {
  static pw.Widget Contact(
    Uint8List icon,
    String? text,
    int textColor,
    double? textSize,
  ) {
    final double iconSize = textSize!;
    if (text != '') {
      return pw.Container(
          margin: pw.EdgeInsets.fromLTRB(0, 4, 0, 4),
          child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Padding(
                    padding: pw.EdgeInsets.fromLTRB(0, 2, 10, 0),
                    child: pw.Image(pw.MemoryImage(icon), height: iconSize)),
                pw.Container(
                    width: 182,
                    child: pw.Text(
                      text ?? '',
                      style: pw.TextStyle(
                        fontSize: textSize,
                        color: PdfColor.fromInt(textColor),
                      ),
                    ))
              ]));
    }
    return pw.Text('');
  }

  static pw.Widget Reference(
    String? name,
    String? contact,
    String? position,
    int subheaderColor,
    int textColor,
    double? subheaderSize,
    double? textSize,
  ) {
    return pw.Container(
      margin: pw.EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            name ?? '',
            style: pw.TextStyle(
              fontSize: subheaderSize,
              color: PdfColor.fromInt(subheaderColor),
            ),
          ),
          pw.Text(
            contact ?? '',
            style: pw.TextStyle(
              fontSize: textSize,
              color: PdfColor.fromInt(textColor),
            ),
          ),
          pw.Text(
            position ?? '',
            style: pw.TextStyle(
              fontSize: textSize,
              color: PdfColor.fromInt(textColor),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget Skill(
    String skill,
    double level,
    int levelBackgroundColor,
    int levelFillColor,
    int textColor,
    double? levelBarHeight,
    double? levelBarWidth,
    double? textSize,
  ) {
    double borderRadius = 8;
    if (levelBarHeight! <= 18) {
      borderRadius = levelBarHeight / 2;
    }
    return pw.Container(
      margin: pw.EdgeInsets.fromLTRB(0, 6, 0, 0),
      width: 200,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            skill,
            style: pw.TextStyle(
              fontSize: textSize,
              color: PdfColor.fromInt(textColor),
            ),
          ),
          pw.Stack(
            children: [
              pw.Container(
                  decoration: pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.circular(borderRadius),
                      color: PdfColor.fromInt(levelBackgroundColor)),
                  width: 200 * 2 / 5 * levelBarWidth!, //must be between 0 and 1
                  height: levelBarHeight),
              pw.Container(
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(borderRadius),
                    color: PdfColor.fromInt(levelFillColor),
                  ),
                  width: (200 * 2 / 5) * level * levelBarWidth,
                  height: levelBarHeight),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget interests(
    List<String> interests,
    int cardColor,
    int textColor,
  ) {
    return pw.GridView(
      crossAxisCount: 2,
      childAspectRatio: 1 / 3,
      children: [
        ...interests.map((i) {
          return pw.Container(
            alignment: pw.Alignment.center,
            margin: pw.EdgeInsets.all(4),
            decoration: pw.BoxDecoration(
              color: PdfColor.fromInt(cardColor),
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Text(
              i,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                  color: PdfColor.fromInt(textColor),
                  fontWeight: pw.FontWeight.bold),
            ),
          );
        }),
      ],
    );
  }

  static pw.Widget Language(
    String language,
    double level,
    int levelBackgroundColor,
    int levelFillColor,
    int textColor,
    double? levelBarHeight,
    double? levelBarWidth,
    double? textSize,
  ) {
    double borderRadius = 8;
    if (levelBarHeight! <= 18) {
      borderRadius = levelBarHeight / 2;
    }
    return pw.Container(
      margin: pw.EdgeInsets.fromLTRB(0, 4, 12, 0),
      width: 180,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            language,
            style: pw.TextStyle(
              fontSize: textSize,
              color: PdfColor.fromInt(textColor),
            ),
          ),
          pw.Stack(
            children: [
              pw.Container(
                  decoration: pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.circular(borderRadius),
                      color: PdfColor.fromInt(levelBackgroundColor)),
                  width: 200 * 2 / 5 * levelBarWidth!,
                  height: levelBarHeight), //16 default
              pw.Container(
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(borderRadius),
                    color: PdfColor.fromInt(levelFillColor),
                  ),
                  width: (200 * 2 / 5) * level * levelBarWidth,
                  height: levelBarHeight),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget Experience(
    String companyName,
    String startDate,
    String endDate,
    String jobTitle,
    String comment,
    int subheaderColor,
    int textColor,
    double? subheaderSize,
    double? textSize,
  ) {
    pw.Widget dates = pw.Center();
    if (startDate != '' && endDate != '') {
      dates = pw.Text(
        '$startDate - $endDate',
        style: pw.TextStyle(
          fontSize: subheaderSize,
          color: PdfColor.fromInt(subheaderColor),
        ),
      );
    }

    return pw.Padding(
        padding: pw.EdgeInsets.fromLTRB(6, 8, 0, 0),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      companyName,
                      style: pw.TextStyle(
                        fontSize: subheaderSize,
                        color: PdfColor.fromInt(subheaderColor),
                      ),
                    ),
                    dates
                  ]),
              pw.Text(
                jobTitle,
                style: pw.TextStyle(
                  fontSize: textSize,
                  color: PdfColor.fromInt(textColor),
                ),
              ),
              pw.Text(
                comment,
                style: pw.TextStyle(
                  fontSize: textSize,
                  color: PdfColor.fromInt(textColor),
                ),
              ),
            ]));
  }

  static pw.Widget Education(
    String startDate,
    String endDate,
    String unviersity,
    String comment,
    int subheaderColor,
    int textColor,
    double? subheaderSize,
    double? textSize,
  ) {
    pw.Widget dates =
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      pw.Text(
        unviersity,
        style: pw.TextStyle(
          fontSize: subheaderSize,
          color: PdfColor.fromInt(subheaderColor),
        ),
      ),
    ]);
    if (startDate != '' && endDate != '') {
      dates = pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              '$startDate - $endDate',
              style: pw.TextStyle(
                fontSize: subheaderSize,
                color: PdfColor.fromInt(subheaderColor),
              ),
            ),
            pw.Text(
              unviersity,
              style: pw.TextStyle(
                fontSize: subheaderSize,
                color: PdfColor.fromInt(subheaderColor),
              ),
            ),
          ]);
    }
    return pw.Padding(
        padding: pw.EdgeInsets.fromLTRB(6, 10, 0, 0),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    dates,
                  ]),
              pw.Text(
                comment,
                style: pw.TextStyle(
                  fontSize: textSize,
                  color: PdfColor.fromInt(textColor),
                ),
              ),
            ]));
  }

  static Uint8List? addressBL;
  static Uint8List? phoneBL;
  static Uint8List? emailBL;
  static Uint8List? websiteBL;
  static Uint8List? facebookBL;
  static Uint8List? linkedinBL;
  static Uint8List? Picture;

  static pw.Widget Contacts(
    String Language,
    int cvId,
    int textColor,
    int headerColor,
    double headerSize,
    double textSize,
  ) {
    return pw.Container(
        margin: pw.EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              pw.Text(getText('contacts', Language),
                  style: pw.TextStyle(
                    fontSize: headerSize,
                    color: PdfColor.fromInt(headerColor),
                  )),
              Contact(
                phoneBL!,
                st.CVs[cvId].personalInformation.phoneNumber,
                textColor,
                textSize,
              ),
              Contact(
                emailBL!,
                st.CVs[cvId].personalInformation.email,
                textColor,
                textSize,
              ),
              Contact(
                addressBL!,
                st.CVs[cvId].personalInformation.address,
                textColor,
                textSize,
              ),
              Contact(
                websiteBL!,
                st.CVs[cvId].personalInformation.website,
                textColor,
                textSize,
              ),
            ]));
  }

  static pw.Widget References(
    String Language,
    int cvId,
    int headerColor,
    int subheaderColor,
    int textColor,
    double? headerSize,
    double? subheaderSize,
    double? textSize,
  ) {
    return pw.Container(
      margin: pw.EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            getText('references', Language),
            style: pw.TextStyle(
              fontSize: headerSize,
              color: PdfColor.fromInt(headerColor),
            ),
          ),
          ...st.CVs[cvId].references.map((el) {
            return Reference(
              el.fullName,
              el.contact,
              el.position,
              subheaderColor,
              textColor,
              subheaderSize,
              textSize,
            );
          })
        ],
      ),
    );
  }

  static pw.Widget Skills(
    String Language,
    int cvId,
    int levelBackgroundColor,
    int levelFillColor,
    int headerColor,
    int textColor,
    double? levelBarHeight,
    double? levelBarWidth,
    double? headerSize,
    double? textSize,
  ) {
    return pw.Container(
      margin: pw.EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            getText('skills', Language),
            style: pw.TextStyle(
              fontSize: headerSize,
              color: PdfColor.fromInt(headerColor),
            ),
          ),
          ...st.CVs[cvId].skills.map((el) {
            return Skill(
              el.skill,
              el.level,
              levelBackgroundColor,
              levelFillColor,
              textColor,
              levelBarHeight,
              levelBarWidth,
              textSize,
            );
          })
        ],
      ),
    );
  }

  static pw.Widget Experiences(
    String Language,
    int cvId,
    int headerColor,
    int subheaderColor,
    int textColor,
    double? headerSize,
    double? subheaderSize,
    double? textSize,
  ) {
    return pw.Container(
        margin: pw.EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                getText('experiences', Language),
                style: pw.TextStyle(
                  fontSize: headerSize,
                  color: PdfColor.fromInt(headerColor),
                ),
              ),
              ...st.CVs[cvId].experiences.map((el) {
                return Experience(
                  el.companyName,
                  el.startDate,
                  el.endDate,
                  el.jobTitle,
                  el.comment,
                  subheaderColor,
                  textColor,
                  subheaderSize,
                  textSize,
                );
              })
            ]));
  }

  static pw.Widget Educations(
    String Language,
    int cvId,
    int headerColor,
    int subheaderColor,
    int textColor,
    double? headerSize,
    double? subheaderSize,
    double? textSize,
  ) {
    return pw.Container(
        margin: pw.EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                getText('education', Language),
                style: pw.TextStyle(
                  fontSize: headerSize,
                  color: PdfColor.fromInt(headerColor),
                ),
              ),
              ...st.CVs[cvId].educations.map((el) {
                return Education(
                  el.startDate,
                  el.endDate,
                  el.university,
                  el.comment,
                  subheaderColor,
                  textColor,
                  subheaderSize,
                  textSize,
                );
              })
            ]));
  }

  static pw.Widget Languages(
    String language,
    int cvId,
    int levelBackgroundColor,
    int levelFillColor,
    int headerColor,
    int textColor,
    double? levelBarHeight,
    double? levelBarWidth,
    double? headerSize,
    double? textSize,
  ) {
    return pw.Container(
      margin: pw.EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Text(
            getText('languages', language),
            style: pw.TextStyle(
              fontSize: headerSize,
              color: PdfColor.fromInt(headerColor),
            ),
          ),
          pw.GridView(
            crossAxisCount: 2,
            childAspectRatio: 1 / 8,
            children: [
              ...st.CVs[cvId].languages.map((el) {
                return Language(
                  el.language,
                  el.level,
                  levelBackgroundColor,
                  levelFillColor,
                  textColor,
                  levelBarHeight,
                  levelBarWidth,
                  textSize,
                );
              })
            ],
          )
        ],
      ),
    );
  }

  static String getText(String text, String lang) {
    List<CvLanguage> LangsList = [
      CvLanguage(
          lang: 'en',
          summary: 'Summary',
          contacts: 'Contacts',
          references: 'References',
          skills: 'Skills',
          interests: 'interests',
          experiences: 'Experiences',
          education: 'Education',
          languages: 'Languages'),
      CvLanguage(
          lang: 'ar',
          summary: 'ملخَّص',
          contacts: 'التَّواصل',
          references: 'مراجع',
          skills: 'المهارات',
          interests: 'الاهتمامات',
          experiences: 'الخِبرات',
          education: 'التَّعليم',
          languages: 'اللُّغات'),
      CvLanguage(
          lang: 'fr',
          summary: 'Résumé',
          contacts: 'Coordonnées',
          references: 'Références',
          skills: 'Compétences',
          interests: 'intérêts',
          experiences: 'Expériences',
          education: 'Éducation',
          languages: 'Langues'),
      CvLanguage(
          lang: 'es',
          summary: 'Resumen',
          contacts: 'Contactos',
          references: 'Referencias',
          skills: 'Habilidades',
          interests: 'intereses',
          experiences: 'Experiencias',
          education: 'Educación',
          languages: 'Idiomas'),
      CvLanguage(
          lang: 'de',
          summary: 'Zusammenfassung',
          contacts: 'Kontakt',
          references: 'Verweise',
          skills: 'Fähigkeiten',
          interests: 'interessen',
          experiences: 'Erlebnisse',
          education: 'Ausbildung',
          languages: 'Sprachen'),
      CvLanguage(
          lang: 'be',
          summary: 'Asegzi',
          contacts: 'Anermis',
          references: 'Tismektiwin',
          skills: 'Timusniwin',
          interests: 'Tifaskiwin',
          experiences: 'Tirmitin',
          education: 'Aselmed',
          languages: 'Tutlayin'),
      CvLanguage(
          lang: 'hi',
          summary: 'आम भाषा में',
          contacts: 'संपर्क',
          references: 'संदर्भ',
          skills: 'कौशल',
          interests: 'रूचियाँ',
          experiences: 'अनुभव',
          education: 'शिक्षा',
          languages: 'भाषा'),
      CvLanguage(
          lang: 'it',
          summary: 'Riepilogo',
          contacts: 'Contatto',
          references: 'Riferimenti',
          skills: 'Competenze',
          interests: 'interessi',
          experiences: 'Esperienze',
          education: 'Istruzione',
          languages: 'Lingue'),
      CvLanguage(
          lang: 'ru',
          summary: 'Краткое содержание',
          contacts: 'Контакт',
          references: 'Ссылки',
          skills: 'Навыки',
          interests: 'Интересы',
          experiences: 'Опыт',
          education: 'Образование',
          languages: 'Языки'),
      CvLanguage(
          lang: 'tu',
          summary: 'ಸಾರ',
          contacts: 'ಸಂಪರ್ಕ',
          references: 'ಉಲ್ಲೇಖೊಲು',
          skills: 'ಕಸುಬುದಾರಿಕೆ',
          interests: 'ಆಸಕ್ತಿಲು',
          experiences: 'ಅನುಭವೊಲು',
          education: 'ಕಲ್ಪಾಟಿಗೆ',
          languages: 'ಭಾಷೆಲು'),
    ];
    for (int i = 0; i < LangsList.length; i++) {
      if (LangsList[i].lang == lang) return LangsList[i].toJson()[text]!;
    }
    return '';
  }

  static Future<void> generateNoArgs(int cvId) async {
    await Template_01.generate(
        cvId,
        cd.customs[cvId].nameColor,
        cd.customs[cvId].mainColor,
        cd.customs[cvId].accentColor,
        cd.customs[cvId].levelBackgroundColor,
        cd.customs[cvId].levelFillColor,
        cd.customs[cvId].textColor,
        cd.customs[cvId].headersColor,
        cd.customs[cvId].subheadersColor,
        cd.customs[cvId].textSize,
        cd.customs[cvId].headersSize,
        cd.customs[cvId].subheadersSize,
        cd.customs[cvId].levelBarHeight,
        cd.customs[cvId].levelBarWidth);
  }

  static Future<void> generate(
    cvId,
    int nameColor,
    int mainColor,
    int accentColor,
    int levelBackgroundColor,
    int levelFillColor,
    int textColor,
    int headersColor,
    int subheaderColor,
    double textSize,
    double headersSize,
    double subheadersSize,
    double levelBarHeight,
    double levelBarWidth,
  ) async {
    final pdf = pw.Document();

    String Language = st.CVs[cvId].CVlanguage;

    ByteData bytes = await rootBundle.load('assets/icons/address.png');
    addressBL = bytes.buffer.asUint8List();
    bytes = await rootBundle.load('assets/icons/email.png');
    emailBL = bytes.buffer.asUint8List();
    bytes = await rootBundle.load('assets/icons/facebook.png');
    facebookBL = bytes.buffer.asUint8List();
    bytes = await rootBundle.load('assets/icons/linkedin.png');
    linkedinBL = bytes.buffer.asUint8List();
    bytes = await rootBundle.load('assets/icons/phone.png');
    phoneBL = bytes.buffer.asUint8List();
    bytes = await rootBundle.load('assets/icons/website.png');
    websiteBL = bytes.buffer.asUint8List();
    File imageFile;
    if (st.CVs[cvId].personalInformation.picture != '' &&
        !st.CVs[cvId].personalInformation.defaultPicture) {
      imageFile = File(st.CVs[cvId].personalInformation.picture);
      Picture = await imageFile.readAsBytes();
    } else {
      ByteData bd = await rootBundle.load('assets/images/default_picture.jpg');
      Picture = bd.buffer.asUint8List();
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(0),
        build: (pw.Context context) {
          return pw.Row(
            children: [
              pw.Container(
                color: PdfColor.fromInt(mainColor),
                height: context.page.pageFormat.height,
                width: context.page.pageFormat.width * 3 / 8,
                child: pw.Column(
                  children: [
                    pw.Container(
                      margin: pw.EdgeInsets.fromLTRB(0, 16, 0, 0),
                      height: 200,
                      width: 200,
                      child: pw.ClipRRect(
                        verticalRadius: 100,
                        horizontalRadius: 100,
                        child: pw.Image(
                          fit: pw.BoxFit.cover,
                          pw.MemoryImage(Picture!),
                        ),
                      ),
                      decoration: pw.BoxDecoration(
                          color: PdfColor.fromInt(0xffffff),
                          borderRadius: pw.BorderRadius.circular(100)),
                    ),
                    pw.Container(
                      margin: pw.EdgeInsets.fromLTRB(18, 18, 18, 0),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          Contacts(Language, cvId, textColor, headersColor,
                              headersSize, textSize),
                          References(
                            Language,
                            cvId,
                            headersColor,
                            subheaderColor,
                            textColor,
                            headersSize,
                            subheadersSize,
                            textSize,
                          ),
                          pw.Text(
                            getText('interests', Language),
                            style: pw.TextStyle(
                              fontSize: headersSize,
                              color: PdfColor.fromInt(headersColor),
                            ),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.fromLTRB(0, 0, 0, 12),
                            child: interests([
                              ...st.CVs[cvId].interests.map(
                                (el) {
                                  return el;
                                },
                              ),
                            ], accentColor, mainColor),
                          ),
                          Skills(
                            Language,
                            cvId,
                            levelBackgroundColor,
                            levelFillColor,
                            headersColor,
                            textColor,
                            levelBarHeight,
                            levelBarWidth,
                            headersSize,
                            textSize,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                  color: PdfColor.fromInt(accentColor),
                  height: context.page.pageFormat.height,
                  width: context.page.pageFormat.width * 5 / 8,
                  child: pw.Container(
                    margin: pw.EdgeInsets.fromLTRB(18, 18, 18, 0),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                            margin: pw.EdgeInsets.fromLTRB(0, 0, 0, 12),
                            child: pw.Text(
                              st.CVs[cvId].personalInformation.fullName,
                              style: pw.TextStyle(
                                  fontSize: 56,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromInt(nameColor)),
                            )),
                        pw.Container(
                          margin: pw.EdgeInsets.fromLTRB(0, 0, 0, 4),
                          child: pw.Text(
                            getText('summary', Language),
                            style: pw.TextStyle(
                              fontSize: headersSize,
                              color: PdfColor.fromInt(headersColor),
                            ),
                          ),
                        ),
                        pw.Container(
                            margin: pw.EdgeInsets.fromLTRB(0, 0, 0, 12),
                            child: pw.Text(
                                style: pw.TextStyle(
                                  fontSize: textSize,
                                  color: PdfColor.fromInt(textColor),
                                ),
                                st.CVs[cvId].summary)),
                        Experiences(
                          Language,
                          cvId,
                          headersColor,
                          subheaderColor,
                          textColor,
                          headersSize,
                          subheadersSize,
                          textSize,
                        ),
                        Educations(
                          Language,
                          cvId,
                          headersColor,
                          subheaderColor,
                          textColor,
                          headersSize,
                          subheadersSize,
                          textSize,
                        ),
                        Languages(
                          Language,
                          cvId,
                          levelBackgroundColor,
                          levelFillColor,
                          headersColor,
                          textColor,
                          levelBarHeight,
                          levelBarWidth,
                          headersSize,
                          textSize,
                        )
                      ],
                    ),
                  )),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File(
        '${output.path}/${st.CVs[cvId].personalInformation.fullName}_CV.pdf');
    file.writeAsBytes(await pdf.save());
    // previewPDF(
    //     '${(await getTemporaryDirectory()).path}/example.pdf', 'template 01');
  }

  static void previewPDF(int cvId) async {
    await Printing.sharePdf(
        bytes: File(
                '/data/user/0/com.ukiyo.cvmaster/cache/${st.CVs[cvId].personalInformation.fullName}_CV.pdf')
            .readAsBytesSync(),
        filename: '${st.CVs[cvId].personalInformation.fullName}_CV.pdf');
  }
}
