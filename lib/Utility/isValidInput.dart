class Isvalidinput {
  static bool phoneNumber(String value) {
    String pattern = r'^\d+(?:\.\d+)?$';
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(value)) {
      print('gg');
    } else {
      print('not gg');
    }
    return true;
  }
}
