// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.success,
    this.message,
    this.result,
  });

  bool success;
  String message;
  Result result;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    message: json["message"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.user,
    this.validated,
  });

  User user;
  bool validated;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    user: User.fromJson(json["user"]),
    validated: json["validated"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "validated": validated,
  };
}

class User {
  User({
    this.password,
    this.confirmationcode,
    this.level,
    this.firstname,
    this.emailvalidated,
    this.email,
    this.lastname,
    this.username,
  });

  String password;
  String confirmationcode;
  String level;
  String firstname;
  bool emailvalidated;
  String email;
  String lastname;
  String username;

  factory User.fromJson(Map<String, dynamic> json) => User(
    password: json["password"],
    confirmationcode: json["confirmationcode"],
    level: json["level"],
    firstname: json["firstname"],
    emailvalidated: json["emailvalidated"],
    email: json["email"],
    lastname: json["lastname"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "password": password,
    "confirmationcode": confirmationcode,
    "level": level,
    "firstname": firstname,
    "emailvalidated": emailvalidated,
    "email": email,
    "lastname": lastname,
    "username": username,
  };
}
