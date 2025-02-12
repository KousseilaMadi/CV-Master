class Isvalidinput {
  static bool phoneNumber(String value) {
    String pattern = r'^\+{0,1}\d{6,12}$';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  static bool email(String value) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  static bool date(String value) {
    String pattern =
        r'([0-3][0-9](\-|/|\.|\s)[0-1][0-9](\-|/|\.|\s)[1-2][0-9][0-9][0-9]|\d{2,4})$';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }
}
