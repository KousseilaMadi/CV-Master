class CvLanguage {
  CvLanguage({
    required this.lang,
    required this.summary,
    required this.contacts,
    required this.references,
    required this.skills,
    required this.interests,
    required this.experiences,
    required this.education,
    required this.languages,
  });
  String lang;
  String summary;
  String contacts;
  String references;
  String skills;
  String interests;
  String experiences;
  String education;
  String languages;

  Map<String, String> toJson() {
    return {
      'lang': lang,
      'summary': summary,
      'contacts': contacts,
      'references': references,
      'skills': skills,
      'interests': interests,
      'experiences': experiences,
      'education': education,
      'languages': languages
    };
  }
}
