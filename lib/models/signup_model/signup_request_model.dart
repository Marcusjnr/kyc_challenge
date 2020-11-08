// To parse this JSON data, do
//
//     final signUpRequest = signUpRequestFromJson(jsonString);

import 'dart:convert';

SignUpRequest signUpRequestFromJson(String str) => SignUpRequest.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  SignUpRequest({
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.password,
  });

  String firstName;
  String lastName;
  String username;
  String email;
  String password;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "email": email,
    "password": password,
  };
}
