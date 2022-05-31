class Validation {
  static String? username(String? uname) {
    if (uname == null || uname.isEmpty) {
      return 'Name can\'t be empty';
    }
    return null;
  }

  // checks if the email provided has email features and if its empty
  static String? useremail(String? uemail) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (uemail == null || uemail.isEmpty) {
      return 'Email can\'t be left empty';
    } else if (!emailRegExp.hasMatch(uemail)) {
      return 'Please enter a correct email';
    }
    return null;
  }

  static String? userpassword(String? upassword) {
    if (upassword == null || upassword.isEmpty) {
      return 'Password can\'t be empty';
    }
    return null;
  }
}
