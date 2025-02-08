Memory memory = Memory();

class UnsavedChanges {
  bool personalInformation = false;
  bool summary = false;
  bool education = false;
  bool experiences = false;
  bool references = false;
  bool interests = false;
  bool skills = false;
  bool languages = false;
}

class Memory {
  String currentSection = '';
  UnsavedChanges unsavedChanges = UnsavedChanges();
}

bool hasUnsavedChanges(String section) {
  switch (section) {
    case 'personalInformation':
      return memory.unsavedChanges.personalInformation;
    case 'summary':
      return memory.unsavedChanges.summary;
    case 'education':
      return memory.unsavedChanges.education;
    case 'experiences':
      return memory.unsavedChanges.experiences;
    case 'references':
      return memory.unsavedChanges.references;
    case 'interests':
      return memory.unsavedChanges.interests;
    case 'skills':
      return memory.unsavedChanges.skills;
    case 'languages':
      return memory.unsavedChanges.languages;
    default:
      return false;
  }
}

void setUnsavedChanges(String section, bool value) {
  switch (section) {
    case 'personalInformation':
      memory.unsavedChanges.personalInformation = value;
      break;
    case 'summary':
      memory.unsavedChanges.summary = value;
      break;
    case 'education':
      memory.unsavedChanges.education = value;
      break;
    case 'experiences':
      memory.unsavedChanges.experiences = value;
      break;
    case 'references':
      memory.unsavedChanges.references = value;
      break;
    case 'interests':
      memory.unsavedChanges.interests = value;
      break;
    case 'skills':
      memory.unsavedChanges.skills = value;
      break;
    case 'languages':
      memory.unsavedChanges.languages = value;
      break;
  }
}
