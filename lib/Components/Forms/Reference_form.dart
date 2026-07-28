import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:flutter/material.dart';
import '../Textinput.dart';
import '../../Utility/Enums.dart';
import 'package:cv_maker/l10n/app_localizations.dart';

// ignore: must_be_immutable
class ReferenceForm extends StatelessWidget {
  final int id;
  final int cvId;
  ReferencesT? reference;
  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  ReferenceForm(
      {required this.id, required this.cvId, this.reference, super.key});

  nameListener(String value) {
    tmp.references[id].fullName = value;
  }

  positionListener(String value) {
    tmp.references[id].position = value;
  }

  companyListener(String value) {
    tmp.references[id].companyName = value;
  }

  contactListener(String value) {
    tmp.references[id].contact = value;
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = reference?.fullName ?? "";
    positionController.text = reference?.position ?? "";
    companyController.text = reference?.companyName ?? "";
    contactController.text = reference?.contact ?? "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '#${id + 1}',
          style: TextStyle(fontSize: 28),
        ),
        Textinput(
          type: InputType.nocomment,
          title: '${AppLocalizations.of(context)!.fullName}*',
          onchange: nameListener,
          inputController: nameController,
          tmpValue: st.CVs[cvId].references[id].fullName,
          section: 'references',
        ),
        Textinput(
          type: InputType.nocomment,
          title: '${AppLocalizations.of(context)!.position}*',
          onchange: positionListener,
          inputController: positionController,
          tmpValue: st.CVs[cvId].references[id].position,
          section: 'references',
        ),
        Textinput(
          type: InputType.nocomment,
          title: AppLocalizations.of(context)!.company,
          onchange: companyListener,
          inputController: companyController,
          tmpValue: st.CVs[cvId].references[id].companyName,
          section: 'references',
        ),
        Textinput(
          type: InputType.nocomment,
          title: '${AppLocalizations.of(context)!.contact}*',
          onchange: contactListener,
          inputController: contactController,
          tmpValue: st.CVs[cvId].references[id].contact,
          section: 'references',
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
