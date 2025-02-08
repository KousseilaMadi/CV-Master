import 'package:cv_maker/Utility/StorageHandler.dart';

bool hasEmptyFields(int cvId) {
  if (personalInformationHasEmptyFields(cvId) ||
      summaryHasEmptyFields(cvId) ||
      educationHasEmptyFields(cvId) ||
      experiencesHasEmptyFields(cvId) ||
      referencesHasEmptyFields(cvId) ||
      interestsHasEmptyFields(cvId) ||
      skillsHasEmptyFields(cvId) ||
      languagesHasEmptyFields(cvId)) {
    return true;
  }
  return false;
}

bool personalInformationHasEmptyFields(int cvId) {
  if (st.CVs[cvId].personalInformation.fullName == '' ||
      st.CVs[cvId].personalInformation.address == '' ||
      st.CVs[cvId].personalInformation.email == '' ||
      st.CVs[cvId].personalInformation.phoneNumber == '' ||
      st.CVs[cvId].personalInformation.picture == '') {
    print(st.CVs[cvId].personalInformation.toJson());
    return true;
  }
  return false;
}

bool summaryHasEmptyFields(int cvId) {
  if (st.CVs[cvId].summary == '') {
    print('summary');
    return true;
  }
  return false;
}

bool educationHasEmptyFields(int cvId) {
  for (var el in st.CVs[cvId].educations) {
    if (el.university == '' || el.degree == '') {
      print(el);
      return true;
    }
  }
  return false;
}

bool experiencesHasEmptyFields(int cvId) {
  for (var el in st.CVs[cvId].experiences) {
    if (el.companyName == '' || el.jobTitle == '') {
      print(el);
      return true;
    }
  }
  return false;
}

bool referencesHasEmptyFields(int cvId) {
  for (var el in st.CVs[cvId].references) {
    if (el.position == '' || el.fullName == '' || el.contact == '') {
      print(el);
      return true;
    }
  }
  return false;
}

bool interestsHasEmptyFields(int cvId) {
  for (var el in st.CVs[cvId].interests) {
    if (el == '') {
      print(el);
      return true;
    }
  }
  return false;
}

bool skillsHasEmptyFields(int cvId) {
  for (var el in st.CVs[cvId].skills) {
    if (el.skill == '') {
      print(el);
      return true;
    }
  }
  return false;
}

bool languagesHasEmptyFields(int cvId) {
  for (var el in st.CVs[cvId].languages) {
    if (el.language == '') {
      print(el);
      return true;
    }
  }
  return false;
}
