// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  SignUpResponse({
    this.success,
    this.result,
  });

  bool success;
  Result result;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
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
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.emailVerification,
  });

  String firstname;
  String lastname;
  String username;
  String email;
  bool emailVerification;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    firstname: json["firstname"],
    lastname: json["lastname"],
    username: json["username"],
    email: json["email"],
    emailVerification: json["email_verification"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "username": username,
    "email": email,
    "email_verification": emailVerification,
  };
}
