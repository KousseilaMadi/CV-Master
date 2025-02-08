import 'package:cv_maker/Components/SliderInput.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import '../Textinput.dart';
import '../../Utility/Enums.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class LanguageForm extends StatelessWidget {
  final int id;
  final int cvId;
  LanguagesT? language;
  TextEditingController languageController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  LanguageForm(
      {required this.id, required this.cvId, this.language, super.key});

  languageListener(String value) {
    tmp.languages[id].language = value;
  }

  levelListener(double value) {
    tmp.languages[id].level = value;
  }

  @override
  Widget build(BuildContext context) {
    languageController.text = language?.language ?? "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '#${id + 1}',
          style: TextStyle(fontSize: 28),
        ),
        Textinput(
          type: InputType.nocomment,
          title: '${AppLocalizations.of(context)!.language}*',
          onchange: languageListener,
          inputController: languageController,
          tmpValue: st.CVs[cvId].languages[id].language,
          section: 'languages',
        ),
        SliderInput(
          id: id,
          section: 'languages',
          initValue: tmp.languages[id].level,
          tmpValue: st.CVs[cvId].languages[id].level,
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
