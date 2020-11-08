// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.success,
    this.result,
  });

  bool success;
  Result result;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
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
    this.firstname,
    this.emailvalidated,
    this.confirmationcode,
    this.lastname,
    this.password,
    this.username,
    this.email,
  });

  String firstname;
  bool emailvalidated;
  String confirmationcode;
  String lastname;
  String password;
  String username;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstname: json["firstname"],
    emailvalidated: json["emailvalidated"],
    confirmationcode: json["confirmationcode"],
    lastname: json["lastname"],
    password: json["password"],
    username: json["username"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "emailvalidated": emailvalidated,
    "confirmationcode": confirmationcode,
    "lastname": lastname,
    "password": password,
    "username": username,
    "email": email,
  };
}
