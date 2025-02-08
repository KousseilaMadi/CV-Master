import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _storageFile async {
  final path = await _localPath;
  return File('$path/storage.json');
}

Future<File> get _customDataFile async {
  final path = await _localPath;
  return File('$path/customData.json');
}

Future<bool> fileExists(File file) async {
  return await file.exists();
}

void writeToStorage() async {
  String data = json.encode(st.toJson());
  File file;
  file = await _storageFile;
  await file.writeAsString(data);
}

Future readFromStorage() async {
  final file = await _storageFile;
  if (await fileExists(file) == false) {
    await file.create();
    writeToStorage();
  }
  String content = await file.readAsString();
  print('content$content');
  if (content != '') st = Storage.fromJson(json.decode(content));
}

void writeToCustomData() async {
  String data = json.encode(cd.toJson());
  File file;
  file = await _customDataFile;
  await file.writeAsString(data);
}

Future readFromCustomData() async {
  final file = await _customDataFile;
  if (await fileExists(file) == false) {
    await file.create();
    writeToCustomData();
  }
  String content = await file.readAsString();
  print('content$content');
  if (content != '') cd = CustomData.fromJson(json.decode(content));
}

Storage st = Storage(AppLanguage: 'en', CVs: []);
CustomData cd = CustomData(customs: []);
CV tmp = CV(
    temp: 1,
    CVlanguage: 'en',
    personalInformation: PersonalInformationT(),
    educations: [EducationsT()],
    experiences: [ExperiencesT()],
    summary: '',
    languages: [LanguagesT()],
    interests: [''],
    references: [ReferencesT()],
    skills: [SkillsT()]);

class PersonalInformationT {
  PersonalInformationT({
    this.defaultPicture = true,
    this.picture = 'assets/images/default_picture.jpg',
    this.fullName = '',
    this.address = '',
    this.phoneNumber = '',
    this.email = '',
    this.linkedin = '',
    this.website = '',
  });
  bool defaultPicture;
  String picture;
  String fullName;
  String address;
  String phoneNumber;
  String email;
  String linkedin;
  String website;

  factory PersonalInformationT.fromJson(Map<String, dynamic> data) {
    bool defaultPicture = data['defaultPicture'] as bool;
    String picture = data['picture'] as String;
    String fullName = data['fullName'] as String;
    String address = data['address'] as String;
    String phoneNumber = data['phoneNumber'] as String;
    String email = data['email'] as String;
    String linkedin = data['linkedin'] as String;
    String website = data['website'] as String;
    return PersonalInformationT(
        defaultPicture: defaultPicture,
        picture: picture,
        fullName: fullName,
        address: address,
        phoneNumber: phoneNumber,
        email: email,
        linkedin: linkedin,
        website: website);
  }
  Map<String, dynamic> toJson() {
    return {
      "defaultPicture": defaultPicture,
      "picture": picture,
      "fullName": fullName,
      "address": address,
      "phoneNumber": phoneNumber,
      "email": email,
      "linkedin": linkedin,
      "website": website,
    };
  }
}

class EducationsT {
  EducationsT({
    this.university = '',
    this.degree = '',
    this.grade = '',
    this.comment = '',
    this.startDate = '',
    this.endDate = '',
  });
  String university;
  String degree;
  String grade;
  String comment;
  String startDate;
  String endDate;

  factory EducationsT.fromJson(Map<String, dynamic> data) {
    String university = data['university'] as String;
    String degree = data['degree'] as String;
    String grade = data['grade'] as String;
    String comment = data['comment'] as String;
    String startDate = data['startDate'] as String;
    String endDate = data['endDate'] as String;
    return EducationsT(
        university: university,
        degree: degree,
        grade: grade,
        comment: comment,
        startDate: startDate,
        endDate: endDate);
  }
  Map<String, dynamic> toJson() {
    return {
      "university": university,
      "degree": degree,
      "grade": grade,
      "comment": comment,
      "startDate": startDate,
      "endDate": endDate
    };
  }
}

class ExperiencesT {
  ExperiencesT({
    this.companyName = '',
    this.jobTitle = '',
    this.startDate = '',
    this.endDate = '',
    this.comment = '',
  });
  String companyName;
  String jobTitle;
  String startDate;
  String endDate;
  String comment;

  factory ExperiencesT.fromJson(Map<String, dynamic> data) {
    String companyName = data['companyName'] as String;
    String jobTitle = data['jobTitle'] as String;
    String startDate = data['startDate'] as String;
    String endDate = data['endDate'] as String;
    String comment = data['comment'] as String;
    return ExperiencesT(
      companyName: companyName,
      jobTitle: jobTitle,
      startDate: startDate,
      endDate: endDate,
      comment: comment,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "companyName": companyName,
      "jobTitle": jobTitle,
      "startDate": startDate,
      "endDate": endDate,
      "comment": comment,
    };
  }
}

class LanguagesT {
  LanguagesT({
    this.language = '',
    this.level = .2,
  });
  String language;
  double level;

  factory LanguagesT.fromJson(Map<String, dynamic> data) {
    String language = data['language'] as String;
    double level = data['level'] as double;
    return LanguagesT(
      language: language,
      level: level,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "language": language,
      "level": level,
    };
  }
}

class SkillsT {
  SkillsT({
    this.skill = '',
    this.level = .2,
  });
  String skill;
  double level;

  factory SkillsT.fromJson(Map<String, dynamic> data) {
    String skill = data['skill'] as String;
    double level = data['level'] as double;
    return SkillsT(
      skill: skill,
      level: level,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "skill": skill,
      "level": level,
    };
  }
}

class ReferencesT {
  ReferencesT({
    this.fullName = '',
    this.position = '',
    this.companyName = '',
    this.contact = '',
  });
  String fullName;
  String position;
  String companyName;
  String contact;

  factory ReferencesT.fromJson(Map<String, dynamic> data) {
    String fullName = data['fullName'] as String;
    String position = data['position'] as String;
    String companyName = data['companyName'] as String;
    String contact = data['contact'] as String;
    return ReferencesT(
      fullName: fullName,
      position: position,
      companyName: companyName,
      contact: contact,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "position": position,
      "companyName": companyName,
      "contact": contact,
    };
  }
}

class CV {
  CV({
    required this.temp,
    required this.CVlanguage,
    required this.personalInformation,
    required this.educations,
    required this.experiences,
    required this.summary,
    required this.languages,
    required this.skills,
    required this.interests,
    required this.references,
  });
  int temp;
  String CVlanguage;
  PersonalInformationT personalInformation;
  List<EducationsT> educations;
  List<ExperiencesT> experiences;
  String summary;
  List<LanguagesT> languages;
  List<SkillsT> skills;
  List<dynamic> interests;
  List<ReferencesT> references;

  factory CV.fromJson(Map<String, dynamic> data) {
    int temp = data['temp'] as int;
    String CVlanguage = data['CVlanguage'] as String;
    Map<String, dynamic> personalInformation =
        data['personalInformation'] ?? PersonalInformationT();
    List<dynamic> educations =
        data['educations'] ?? EducationsT() as List<dynamic>;
    List<dynamic> experiences =
        data['experiences'] ?? ExperiencesT() as List<dynamic>;
    String summary = data['summary'] as String;
    List<dynamic> languages =
        data['languages'] ?? LanguagesT() as List<dynamic>;
    List<dynamic> skills = data['skills'] ?? SkillsT() as List<dynamic>;
    List<dynamic> interests = data['interests'] ?? [""] as List<dynamic>;
    List<dynamic> references =
        data['references'] ?? ReferencesT() as List<dynamic>;

    return CV(
      temp: temp,
      CVlanguage: CVlanguage,
      personalInformation: PersonalInformationT.fromJson(personalInformation),
      educations: educations
          .map((el) => EducationsT.fromJson(el as Map<String, dynamic>))
          .toList(),
      experiences: experiences
          .map((el) => ExperiencesT.fromJson(el as Map<String, dynamic>))
          .toList(),
      summary: summary,
      languages: languages
          .map((el) => LanguagesT.fromJson(el as Map<String, dynamic>))
          .toList(),
      skills: skills
          .map((el) => SkillsT.fromJson(el as Map<String, dynamic>))
          .toList(),
      interests: interests.toList(),
      references: references
          .map((el) => ReferencesT.fromJson(el as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "temp": temp,
      "CVlanguage": CVlanguage,
      "personalInformation": personalInformation,
      "educations": educations,
      "experiences": experiences,
      "summary": summary,
      "languages": languages,
      "skills": skills,
      "interests": interests,
      "references": references
    };
  }
}

class Storage {
  Storage({required this.AppLanguage, required this.CVs});
  final String AppLanguage;
  final List<CV> CVs;

  factory Storage.fromJson(Map<String, dynamic> data) {
    final AppLanguage = data['AppLanguage'] as String;
    final CVs = data['CVs'] as List<dynamic>;
    return Storage(
        AppLanguage: AppLanguage,
        CVs: CVs.map((el) => CV.fromJson(el as Map<String, dynamic>)).toList());
  }

  Map<String, dynamic> toJson() {
    return {'AppLanguage': AppLanguage, 'CVs': CVs};
  }
}

class Data {
  Data({
    required this.nameColor,
    required this.mainColor,
    required this.accentColor,
    required this.levelBackgroundColor,
    required this.levelFillColor,
    required this.textColor,
    required this.headersColor,
    required this.subheadersColor,
    required this.textSize,
    required this.headersSize,
    required this.subheadersSize,
    required this.levelBarHeight,
    required this.levelBarWidth,
  });
  int nameColor;
  int mainColor;
  int accentColor;
  int levelBackgroundColor;
  int levelFillColor;
  int textColor;
  int headersColor;
  int subheadersColor;
  double textSize;
  double headersSize;
  double subheadersSize;
  double levelBarHeight;
  double levelBarWidth;

  factory Data.fromJson(Map<String, dynamic> data) {
    final nameColor = data['nameColor'] as int;
    final mainColor = data['mainColor'] as int;
    final accentColor = data['accentColor'] as int;
    final levelBackgroundColor = data['levelBackgroundColor'] as int;
    final levelFillColor = data['levelFillColor'] as int;
    final textColor = data['textColor'] as int;
    final headersColor = data['headersColor'] as int;
    final subheadersColor = data['subheadersColor'] as int;
    final textSize = data['textSize'] as double;
    final headersSize = data['headersSize'] as double;
    final subheadersSize = data['subheadersSize'] as double;
    final levelBarHeight = data['levelBarHeight'] as double;
    final levelBarWidth = data['levelBarWidth'] as double;

    return Data(
        nameColor: nameColor,
        mainColor: mainColor,
        accentColor: accentColor,
        levelBackgroundColor: levelBackgroundColor,
        levelFillColor: levelFillColor,
        textColor: textColor,
        headersColor: headersColor,
        subheadersColor: subheadersColor,
        textSize: textSize,
        headersSize: headersSize,
        subheadersSize: subheadersSize,
        levelBarHeight: levelBarHeight,
        levelBarWidth: levelBarWidth);
  }

  Map<String, dynamic> toJson() {
    return {
      'nameColor': nameColor,
      'mainColor': mainColor,
      'accentColor': accentColor,
      'levelBackgroundColor': levelBackgroundColor,
      'levelFillColor': levelFillColor,
      'textColor': textColor,
      'headersColor': headersColor,
      'subheadersColor': subheadersColor,
      'textSize': textSize,
      'headersSize': headersSize,
      'subheadersSize': subheadersSize,
      'levelBarHeight': levelBarHeight,
      'levelBarWidth': levelBarWidth
    };
  }
}

class CustomData {
  CustomData({required this.customs});
  List<Data> customs;

  factory CustomData.fromJson(Map<String, dynamic> data) {
    List<dynamic> list = data['customData'] as List<dynamic>;
    return CustomData(
        customs: list
            .map((el) => Data.fromJson(el as Map<String, dynamic>))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {'customData': customs};
  }
}
