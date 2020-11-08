const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

mixin FormValidators {
  bool validateEmail(String email) {
    final RegExp emailExp = new RegExp(_kEmailRule);
    if (email != null) email = email.trim();
    if (!emailExp.hasMatch(email) || email.isEmpty) {
      return false;
    } else {
      return true;
    }
  }


  bool validateSingleInput(String username) {
    if (username.isEmpty || username.length < 1) {
      return false;
    } else {
      return true;
    }
  }

  bool validateBVN(String number) {
    if (number.isEmpty || number.length < 11) {
      return false;
    } else {
      return true;
    }
  }
}

