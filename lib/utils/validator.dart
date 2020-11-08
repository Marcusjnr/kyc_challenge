import 'package:kyc/mixins/validations/form_validator.dart';

class Validator with FormValidators{
  String emailValidator(String email) {
    return validateEmail(email) ? null : "Please enter a valid email";
  }

  String singleInputValidator(String phone) {
    return validateSingleInput(phone) ? null : "Field must not be empty";
  }
}

Validator formValidator = Validator();