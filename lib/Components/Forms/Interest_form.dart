import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import '../Textinput.dart';
import '../../Utility/Enums.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class InterestForm extends StatelessWidget {
  final int id;
  final int cvId;
  String? interest;
  TextEditingController interestController = TextEditingController();

  InterestForm(
      {required this.id, required this.cvId, this.interest, super.key});

  interestListener(String value) {
    tmp.interests[id] = value;
  }

  @override
  Widget build(BuildContext context) {
    interestController.text = interest ?? "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '#${id + 1}',
          style: TextStyle(fontSize: 28),
        ),
        Textinput(
          type: InputType.nocomment,
          title: '${AppLocalizations.of(context)!.interest}*',
          onchange: interestListener,
          inputController: interestController,
          tmpValue: st.CVs[cvId].interests[id],
          section: 'interests',
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
