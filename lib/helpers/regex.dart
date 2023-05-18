class CustomRegEx {
  static bool validateOnlyLetters(String input) {
    String pattern = r"^[\p{L} ,.'-]*$";
    RegExp regex = RegExp(pattern, caseSensitive: false, unicode: true, dotAll: true);
    return regex.hasMatch(input);
  }

  static bool validatePassword(String input) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(input);
  }
}

