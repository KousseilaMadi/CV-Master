import 'package:cv_maker/Pages/CV_Language.dart';
import 'package:cv_maker/Pages/Customization.dart';
import 'package:cv_maker/Pages/Home.dart';
import 'package:cv_maker/Pages/Sections.dart';
import 'package:cv_maker/Utility/CvGen.dart';
import 'package:cv_maker/Utility/Dialogs.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/Percent.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../Utility/Colors.dart';
import 'package:cv_maker/Utility/hasEmptyFields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class CV_Actions extends StatelessWidget {
  int cvId;
  CV_Actions({required this.cvId, super.key});

  @override
  Widget build(BuildContext context) {
    void deleteCv(int cvId) {
      deleteConfirmationDialog(context, cvId);
    }

    Template_01.generateNoArgs(cvId);
    Widget? pdfPreview;
    if (hasEmptyFields(cvId)) {
      pdfPreview = Center(
          child: Text(
        AppLocalizations.of(context)!.pleaseFillAllRequiredFieldsToPreview,
        textAlign: TextAlign.center,
      ));
    } else {
      pdfPreview = PDFView(
        filePath:
            '/data/user/0/com.ukiyo.cvmaster/cache/${st.CVs[cvId].personalInformation.fullName}_CV.pdf',
      );
    }
    return WillPopScope(
      child: Scaffold(
        backgroundColor: colors.white,
        appBar: AppBar(
          foregroundColor: colors.white,
          titleTextStyle: TextStyle(fontSize: 28),
          centerTitle: true,
          toolbarHeight: 56,
          title: Text(AppLocalizations.of(context)!.yourCv),
          backgroundColor: colors.primary,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 18),
          height: percent(100, 'h', context),
          width: percent(100, 'w', context),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: 0,
                  child: Container(
                    color: colors.secondary,
                    height: 1.414 * percent(60, 'w', context),
                    width: 1.0 * percent(60, 'w', context),
                    child: pdfPreview,
                  )),
              Positioned(
                width: percent(100, 'w', context),
                bottom: 0,
                child: Column(
                  children: [
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Button(
                          width: 45,
                          title: AppLocalizations.of(context)!.edit,
                          onpress: () => {
                            Navigate(
                                context,
                                Sections(
                                  cvId: cvId,
                                  cameFrom: 'cvActions',
                                ),
                                false)
                          },
                        ),
                        Button(
                          width: 45,
                          title: AppLocalizations.of(context)!.customize,
                          onpress: () => {
                            Navigate(context, Customization(cvId: cvId), false)
                          },
                        )
                      ],
                    ),
                    Button(
                      title: AppLocalizations.of(context)!.changeLanguage,
                      onpress: () =>
                          {Navigate(context, CV_Language(cvId: cvId), true)},
                    ),
                    Button(
                      title: AppLocalizations.of(context)!.delete,
                      onpress: () => {deleteCv(cvId)},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigate(context, Home(), false);
        return true;
      },
    );
  }
}

// ignore: must_be_immutable
class Button extends StatelessWidget {
  String title;
  VoidCallback onpress;
  double? width;
  Button({this.width, required this.title, required this.onpress, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.fromLTRB(2, 0, 2, 4),
      width: percent(width ?? 95, 'w', context),
      child: ElevatedButton(
        onPressed: onpress,
        style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(colors.primary),
            backgroundColor: WidgetStatePropertyAll(colors.secondary)),
        child: Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
