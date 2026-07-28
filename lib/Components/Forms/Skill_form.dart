import 'package:cv_maker/Components/SliderInput.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import '../Textinput.dart';
import '../../Utility/Enums.dart';
import 'package:cv_maker/l10n/app_localizations.dart';

// ignore: must_be_immutable
class SkillForm extends StatelessWidget {
  final int id;
  final int cvId;
  SkillsT? skill;
  TextEditingController skillController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  SkillForm({required this.id, required this.cvId, this.skill, super.key});

  skillListener(String value) {
    tmp.skills[id].skill = value;
  }

  levelListener(double value) {
    tmp.skills[id].level = value;
  }

  @override
  Widget build(BuildContext context) {
    skillController.text = skill?.skill ?? "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '#${id + 1}',
          style: TextStyle(fontSize: 28),
        ),
        Textinput(
          type: InputType.nocomment,
          title: '${AppLocalizations.of(context)!.skill}*',
          onchange: skillListener,
          inputController: skillController,
          tmpValue: st.CVs[cvId].skills[id].skill,
          section: 'skills',
        ),
        SliderInput(
          id: id,
          section: 'skills',
          initValue: tmp.skills[id].level,
          tmpValue: st.CVs[cvId].skills[id].level,
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
