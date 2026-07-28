import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import '../Textinput.dart';
import '../../Utility/Enums.dart';
import 'package:cv_maker/l10n/app_localizations.dart';

// ignore: must_be_immutable
class ExperienceForm extends StatelessWidget {
  final int id;
  final int cvId;
  ExperiencesT? experience;
  TextEditingController companyController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  ExperienceForm(
      {required this.id, required this.cvId, this.experience, super.key});

  companyListener(String value) {
    tmp.experiences[id].companyName = value;
  }

  jobTitleListener(String value) {
    tmp.experiences[id].jobTitle = value;
  }

  startDateListener(String value) {
    tmp.experiences[id].startDate = value;
  }

  endDateListener(String value) {
    tmp.experiences[id].endDate = value;
  }

  commentListener(String value) {
    tmp.experiences[id].comment = value;
  }

  @override
  Widget build(BuildContext context) {
    companyController.text = experience?.companyName ?? "";
    jobTitleController.text = experience?.jobTitle ?? "";
    startDateController.text = experience?.startDate ?? "";
    endDateController.text = experience?.endDate ?? "";
    commentController.text = experience?.comment ?? "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '#${id + 1}',
          style: TextStyle(fontSize: 28),
        ),
        Textinput(
          type: InputType.nocomment,
          title: '${AppLocalizations.of(context)!.company}*',
          onchange: companyListener,
          inputController: companyController,
          tmpValue: st.CVs[cvId].experiences[id].companyName,
          section: 'experiences',
        ),
        Textinput(
          type: InputType.nocomment,
          title: '${AppLocalizations.of(context)!.jobTitle}*',
          onchange: jobTitleListener,
          inputController: jobTitleController,
          tmpValue: st.CVs[cvId].experiences[id].jobTitle,
          section: 'experiences',
        ),
        Textinput(
          type: InputType.nocomment,
          title: AppLocalizations.of(context)!.startDate,
          onchange: startDateListener,
          hint: 'dd/mm/yyyy, yyyy',
          inputController: startDateController,
          tmpValue: st.CVs[cvId].experiences[id].startDate,
          section: 'experiences',
        ),
        Textinput(
          type: InputType.nocomment,
          title: AppLocalizations.of(context)!.endDate,
          onchange: endDateListener,
          hint: 'dd/mm/yyyy, yyyy',
          inputController: endDateController,
          tmpValue: st.CVs[cvId].experiences[id].endDate,
          section: 'experiences',
        ),
        Textinput(
          type: InputType.comment,
          title: AppLocalizations.of(context)!.comment,
          onchange: commentListener,
          inputController: commentController,
          tmpValue: st.CVs[cvId].experiences[id].comment,
          section: 'experiences',
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
