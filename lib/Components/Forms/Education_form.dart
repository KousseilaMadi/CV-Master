import 'package:cv_maker/Utility/Enums.dart';
import 'package:flutter/material.dart';
import '../../Utility/StorageHandler.dart';
import '../Textinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class EducationForm extends StatelessWidget {
  final int id;
  final int cvId;
  EducationsT? education;
  TextEditingController universityController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  EducationForm(
      {required this.id, required this.cvId, this.education, super.key});

  universityListener(String value) {
    tmp.educations[id].university = value;
  }

  degreeListener(String value) {
    tmp.educations[id].degree = value;
  }

  gradeListener(String value) {
    tmp.educations[id].grade = value;
  }

  commentListener(String value) {
    tmp.educations[id].comment = value;
  }

  startDateListener(String value) {
    tmp.educations[id].startDate = value;
  }

  endDateListener(String value) {
    tmp.educations[id].endDate = value;
  }

  @override
  Widget build(BuildContext context) {
    universityController.text = education?.university ?? "";
    degreeController.text = education?.degree ?? "";
    gradeController.text = education?.grade ?? "";
    commentController.text = education?.comment ?? "";
    startDateController.text = education?.startDate ?? "";
    endDateController.text = education?.endDate ?? "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '#${id + 1}',
          style: TextStyle(fontSize: 28),
        ),
        Textinput(
          type: InputType.nocomment,
          title: '${AppLocalizations.of(context)!.university}*',
          onchange: universityListener,
          inputController: universityController,
          tmpValue: st.CVs[cvId].educations[id].university,
          section: 'education',
        ),
        Textinput(
          type: InputType.nocomment,
          title: '${AppLocalizations.of(context)!.degree}*',
          onchange: degreeListener,
          inputController: degreeController,
          tmpValue: st.CVs[cvId].educations[id].degree,
          section: 'education',
        ),
        Textinput(
          type: InputType.nocomment,
          title: AppLocalizations.of(context)!.grade,
          onchange: gradeListener,
          inputController: gradeController,
          tmpValue: st.CVs[cvId].educations[id].grade,
          section: 'education',
        ),
        Textinput(
          type: InputType.comment,
          title: AppLocalizations.of(context)!.comment,
          onchange: commentListener,
          inputController: commentController,
          tmpValue: st.CVs[cvId].educations[id].comment,
          section: 'education',
        ),
        Textinput(
          type: InputType.nocomment,
          title: AppLocalizations.of(context)!.startDate,
          onchange: startDateListener,
          inputController: startDateController,
          tmpValue: st.CVs[cvId].educations[id].startDate,
          section: 'education',
        ),
        Textinput(
          type: InputType.nocomment,
          title: AppLocalizations.of(context)!.endDate,
          onchange: endDateListener,
          inputController: endDateController,
          tmpValue: st.CVs[cvId].educations[id].endDate,
          section: 'education',
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
