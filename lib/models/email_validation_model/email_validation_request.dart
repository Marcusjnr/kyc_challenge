// To parse this JSON data, do
//
//     final emailValidationRequest = emailValidationRequestFromJson(jsonString);

import 'dart:convert';

EmailValidationRequest emailValidationRequestFromJson(String str) => EmailValidationRequest.fromJson(json.decode(str));

String emailValidationRequestToJson(EmailValidationRequest data) => json.encode(data.toJson());

class EmailValidationRequest {
  EmailValidationRequest({
    this.email,
    this.token,
  });

  String email;
  String token;

  factory EmailValidationRequest.fromJson(Map<String, dynamic> json) => EmailValidationRequest(
    email: json["email"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "token": token,
  };
}
