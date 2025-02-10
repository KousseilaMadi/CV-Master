import 'package:cv_maker/Pages/Home.dart';
import 'package:cv_maker/Pages/Personal_Information.dart';
import 'package:cv_maker/Pages/Sections.dart';
import 'package:cv_maker/Pages/Skills.dart';
import 'package:cv_maker/Utility/Dialogs.dart';
import 'package:cv_maker/Utility/Memory.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:flutter/material.dart';
import '../Utility/Colors.dart';
import '../Pages/References.dart';
import '../Pages/Educations.dart';
import '../Pages/Experiences.dart';
import '../Pages/Interests.dart';
import '../Pages/Languages.dart';
import '../Pages/Summary.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class SectionsDrawer extends StatelessWidget {
  int cvId;
  SectionsDrawer({required this.cvId, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: colors.primary, boxShadow: [
              BoxShadow(
                  color: colors.primary, blurRadius: 2, offset: Offset(0, 3))
            ]),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                AppLocalizations.of(context)!.sections,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: colors.secondary),
              ),
            ),
          ),
          Tile(
            tileIcon: Icons.home_rounded,
            goto: Home(),
            title: AppLocalizations.of(context)!.home,
          ),
          Tile(
            tileIcon: Icons.align_horizontal_left_sharp,
            goto: Sections(cvId: cvId),
            title: AppLocalizations.of(context)!.sections,
          ),
          Tile(
            tileIcon: Icons.photo_camera_front_outlined,
            goto: PersonalInformation(cvId: cvId),
            title: AppLocalizations.of(context)!.personalInformation,
            section: 'personalInformation',
          ),
          Tile(
            tileIcon: Icons.add_comment_rounded,
            goto: Summary(cvId: cvId),
            title: AppLocalizations.of(context)!.summary,
            section: 'summary',
          ),
          Tile(
            tileIcon: Icons.app_shortcut,
            goto: References(cvId: cvId),
            title: AppLocalizations.of(context)!.references,
            section: 'references',
          ),
          Tile(
            tileIcon: Icons.auto_stories_rounded,
            goto: Educations(cvId: cvId),
            title: AppLocalizations.of(context)!.education,
            section: 'education',
          ),
          Tile(
            tileIcon: Icons.abc_rounded,
            goto: Languages(cvId: cvId),
            title: AppLocalizations.of(context)!.languages,
            section: 'languages',
          ),
          Tile(
            tileIcon: Icons.apartment_rounded,
            goto: Experiences(cvId: cvId),
            title: AppLocalizations.of(context)!.experiences,
            section: 'experiences',
          ),
          Tile(
            tileIcon: Icons.account_tree_rounded,
            goto: Skills(cvId: cvId),
            title: AppLocalizations.of(context)!.skills,
            section: 'skills',
          ),
          Tile(
            tileIcon: Icons.attractions_rounded,
            goto: Interests(cvId: cvId),
            title: AppLocalizations.of(context)!.interests,
            section: 'interests',
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final Widget goto;
  final String title;
  final IconData tileIcon;
  final String? section;
  const Tile(
      {required this.tileIcon,
      required this.goto,
      required this.title,
      this.section,
      super.key});

  @override
  Widget build(BuildContext context) {
    Color tileColor = colors.secondary;
    if (section != null) {
      if (section == memory.currentSection) tileColor = colors.highlight;
    }
    return Container(
        margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
        child: ListTile(
          leading: Icon(tileIcon),
          iconColor: colors.primary,
          title: Text(
            title,
            style: TextStyle(fontSize: 20, color: colors.primary),
          ),
          tileColor: tileColor,
          onTap: () {
            if (!hasUnsavedChanges(memory.currentSection)) {
              Navigator.pop(context);
              Navigate(context, goto);
            } else {
              drawerUnsavedChangesDialog(context, () {
                Navigator.pop(context);
                Navigate(context, goto);
              });
            }
          },
        ));
  }
}
