// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  SignUpResponse({
    this.success,
    this.message,
    this.result,
  });

  bool success;
  String message;
  Result result;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
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
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.emailVerification,
    this.level,
  });

  String firstname;
  String lastname;
  String username;
  String email;
  bool emailVerification;
  String level;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    firstname: json["firstname"],
    lastname: json["lastname"],
    username: json["username"],
    email: json["email"],
    emailVerification: json["email_verification"],
    level: json["level"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "username": username,
    "email": email,
    "email_verification": emailVerification,
    "level": level,
  };
}
