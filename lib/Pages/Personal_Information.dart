import 'dart:convert';

import 'package:cv_maker/Pages/Preview.dart';
import 'package:cv_maker/Utility/Dialogs.dart';
import 'package:cv_maker/Utility/Memory.dart';
import 'package:cv_maker/Utility/Navigate.dart';
import 'package:cv_maker/Utility/Percent.dart';
import 'package:cv_maker/Utility/StorageHandler.dart';
import 'package:cv_maker/Utility/hasEmptyFields.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import '../Utility/Colors.dart';
import '../Components/SectionsDrawer.dart';
import '../Components/BottomPanel/BottomPanelTwoButtons.dart';
import '../Utility/Enums.dart';
import '../Components/CustomButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import '../Components/Textinput.dart';

class PersonalInformation extends StatefulWidget {
  final int cvId;
  PersonalInformation({required this.cvId, super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformation();
}

class _PersonalInformation extends State<PersonalInformation> {
  //these controllers are only used to set the text in the fields on the init of the page and NOTHING more
  // ignore: unused_field
  // File? _imageFile;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController xController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initTmp();
  }

  void _initTmp() {
    memory.currentSection = 'personalInformation';
    tmp.personalInformation = PersonalInformationT.fromJson(
        jsonDecode(jsonEncode(st.CVs[widget.cvId].personalInformation)));
    // _imageFile = File(st.CVs[widget.cvId].personalInformation.picture);
  }

  void savePersonalInformation() {
    st.CVs[widget.cvId].personalInformation = PersonalInformationT.fromJson(
        jsonDecode(jsonEncode(tmp.personalInformation)));
    writeToStorage();
    setUnsavedChanges('personalInformation', false);
    setState(() {});
  }

  pictureListener(bool defaultP, String value) {
    st.CVs[widget.cvId].personalInformation.picture = value;
    tmp.personalInformation.picture = value;
  }

  nameListener(String value) {
    tmp.personalInformation.fullName = value;
  }

  addresseListener(String value) {
    tmp.personalInformation.address = value;
  }

  phoneNumberListener(String value) {
    tmp.personalInformation.phoneNumber = value;
  }

  emailListener(String value) {
    tmp.personalInformation.email = value;
  }

  linkedinListener(String value) {
    tmp.personalInformation.linkedin = value;
  }

  websiteListener(String value) {
    tmp.personalInformation.website = value;
  }

  Future<void> _pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    File? croppedImage;
    Directory dir = await getApplicationDocumentsDirectory();
    File croppedImageFile = File(dir.path);
    if (image != null) {
      CroppedFile? croppedFile =
          await ImageCropper().cropImage(sourcePath: image.path, uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: colors.primary,
          toolbarWidgetColor: colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
        ),
      ]);

      if (croppedFile != null) {
        pictureListener(false, croppedFile.path);
        setState(() {});
      }
    } else {
      pictureListener(true, 'assets/images/default_picture.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = tmp.personalInformation.fullName;
    addressController.text = tmp.personalInformation.address;
    phoneNumberController.text = tmp.personalInformation.phoneNumber;
    emailController.text = tmp.personalInformation.email;
    linkedinController.text = tmp.personalInformation.linkedin;
    websiteController.text = tmp.personalInformation.website;
    // ignore: deprecated_member_use
    return WillPopScope(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: colors.white,
            appBar: AppBar(
              foregroundColor: colors.white,
              titleTextStyle: TextStyle(fontSize: 28),
              centerTitle: true,
              toolbarHeight: 56,
              title: Text(AppLocalizations.of(context)!.personalInformation),
              backgroundColor: colors.primary,
            ),
            drawer: SectionsDrawer(
              cvId: widget.cvId,
            ),
            body: Stack(
              children: [
                ListView(
                  children: [
                    Container(
                      height: 160,
                      width: percent(90, 'w', context),
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 55),
                      // color: colors.gold,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: colors.secondary),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Picture(
                                path: st.CVs[widget.cvId].personalInformation
                                    .picture,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(() {
                                _pickImage();
                              }, AppLocalizations.of(context)!.add, 45,
                                  Icons.abc_outlined, ButtonType.text),
                              CustomButton(() {
                                setState(() {
                                  pictureListener(true,
                                      'assets/images/default_picture.jpg');
                                  // _imageFile =
                                  //     File('assets/images/default_picture.jpg');
                                });
                              }, AppLocalizations.of(context)!.remove, 45,
                                  Icons.abc_outlined, ButtonType.text)
                            ],
                          ),
                        ],
                      ),
                    ),
                    Textinput(
                      type: InputType.nocomment,
                      title: '${AppLocalizations.of(context)!.fullName}*',
                      onchange: nameListener,
                      inputController: nameController,
                      tmpValue:
                          st.CVs[widget.cvId].personalInformation.fullName,
                      section: 'personalInformation',
                    ),
                    Textinput(
                      type: InputType.comment,
                      title: '${AppLocalizations.of(context)!.address}*',
                      heightValue: 140,
                      onchange: addresseListener,
                      inputController: addressController,
                      tmpValue: st.CVs[widget.cvId].personalInformation.address,
                      section: 'personalInformation',
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(2, 16, 6, 8),
                      child: Text(
                        '${AppLocalizations.of(context)!.contactInformation} :',
                        style: TextStyle(
                          fontSize: 28,
                          color: colors.primary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Textinput(
                      type: InputType.nocomment,
                      title: '${AppLocalizations.of(context)!.phoneNumber}*',
                      onchange: phoneNumberListener,
                      inputController: phoneNumberController,
                      tmpValue:
                          st.CVs[widget.cvId].personalInformation.phoneNumber,
                      section: 'personalInformation',
                    ),
                    Textinput(
                      type: InputType.nocomment,
                      title: '${AppLocalizations.of(context)!.email}*',
                      onchange: emailListener,
                      inputController: emailController,
                      tmpValue: st.CVs[widget.cvId].personalInformation.email,
                      section: 'personalInformation',
                    ),
                    Textinput(
                      type: InputType.nocomment,
                      title: AppLocalizations.of(context)!.linkedin,
                      onchange: linkedinListener,
                      inputController: linkedinController,
                      tmpValue:
                          st.CVs[widget.cvId].personalInformation.linkedin,
                      section: 'personalInformation',
                    ),
                    Textinput(
                      type: InputType.nocomment,
                      title: AppLocalizations.of(context)!.website,
                      onchange: websiteListener,
                      inputController: websiteController,
                      tmpValue: st.CVs[widget.cvId].personalInformation.website,
                      section: 'personalInformation',
                    ),
                    SizedBox(
                      height: 120,
                    )
                  ],
                ),
                BottomPanelTwoButtons(
                  onpreview: () {
                    if (!hasEmptyFields(widget.cvId)) {
                      if (!hasUnsavedChanges(memory.currentSection)) {
                        Navigate(context, Preview(cvId: widget.cvId));
                      } else {
                        previewUnsavedChangesDialog(context, () {
                          savePersonalInformation();
                          Navigate(context, Preview(cvId: widget.cvId));
                        });
                      }
                    } else {
                      missingFieldsDialog(context);
                    }
                  },
                  title2ndBtn: AppLocalizations.of(context)!.save,
                  on2ndBtnPress: () {
                    savePersonalInformation();
                    Fluttertoast.showToast(msg: 'Saved');
                  },
                )
              ],
            )),
        onWillPop: () async {
          if (memory.unsavedChanges.personalInformation) {
            unsavedChangesDialog(context, savePersonalInformation);
          }
          return true;
        });
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}

// ignore: must_be_immutable
class Picture extends StatelessWidget {
  String path;
  Picture({required this.path, super.key});

  @override
  Widget build(BuildContext context) {
    if (path != 'assets/images/default_picture.jpg') {
      return Image(
        image: FileImage(File(path)),
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage('assets/images/default_picture.jpg'),
        fit: BoxFit.cover,
      );
    }
  }
}
