import 'package:cv_maker/Pages/Home.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import 'package:cv_maker/l10n/app_localizations.dart';

void customDialog(
  BuildContext context,
  String title,
  String text,
) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      // surfaceTintColor: colors.highlight,
      title: Text(title),
      content: Text(text),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.ok),
        ),
      ],
    ),
  );
}

void unsavedChangesDialog(BuildContext context, Function onsave) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      // surfaceTintColor: colors.highlight,
      title: Text(AppLocalizations.of(context)!.unsavedChanged),
      content: Text(AppLocalizations.of(context)!
          .youHaveUnsavedChangesAreYouSureYouWantToLeaveThisPage),
      actions: [
        TextButton(
          onPressed: () {
            onsave();
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.leave),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
    ),
  );
}

void previewUnsavedChangesDialog(BuildContext context, Function onpreview) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      // surfaceTintColor: colors.highlight,
      title: Text(AppLocalizations.of(context)!.unsavedChanged),
      content: Text(AppLocalizations.of(context)!
          .youHaveUnsavedChangesAreYouSureYouWantToLeaveThisPage),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onpreview();
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
    ),
  );
}

void confirmationDialog(BuildContext context, Function onpress) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      // surfaceTintColor: colors.highlight,
      title: Text(AppLocalizations.of(context)!.reset),
      content: Text(AppLocalizations.of(context)!
          .doYouWantToResetTheColorsAndSizesToDefaultValues),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onpress();
          },
          child: Text(AppLocalizations.of(context)!.yes),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.no),
        ),
      ],
    ),
  );
}

void drawerUnsavedChangesDialog(BuildContext context, Function onleave) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      // surfaceTintColor: colors.highlight,
      title: Text(AppLocalizations.of(context)!.unsavedChanged),
      content: Text(AppLocalizations.of(context)!
          .youHaveUnsavedChangesAreYouSureYouWantToLeaveThisPage),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onleave();
          },
          child: Text(AppLocalizations.of(context)!.leave),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
    ),
  );
}

void deleteConfirmationDialog(BuildContext context, int cvId) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      // surfaceTintColor: colors.highlight,
      title: Text(AppLocalizations.of(context)!.areYouSure),
      content: Text(AppLocalizations.of(context)!
          .ifYouDeleteThisCVYouCantGetItBackDoYouWantToProceed),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigate(context, Home());
            cd.customs.removeAt(cvId);
            st.CVs.removeAt(cvId);
            writeToStorage();
            writeToCustomData();
          },
          child: Text(AppLocalizations.of(context)!.delete),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
    ),
  );
}

void missingFieldsDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      // surfaceTintColor: colors.highlight,
      title: Text(AppLocalizations.of(context)!.missingFields),
      content: Text(AppLocalizations.of(context)!
          .youCantPreviewBeforeFillingAllTheRequiredFields),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.ok),
        ),
      ],
    ),
  );
}
