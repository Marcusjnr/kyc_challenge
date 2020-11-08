// To parse this JSON data, do
//
//     final emailValidationResponse = emailValidationResponseFromJson(jsonString);

import 'dart:convert';

EmailValidationResponse emailValidationResponseFromJson(String str) => EmailValidationResponse.fromJson(json.decode(str));

String emailValidationResponseToJson(EmailValidationResponse data) => json.encode(data.toJson());

class EmailValidationResponse {
  EmailValidationResponse({
    this.success,
    this.message,
    this.result,
  });

  bool success;
  String message;
  Result result;

  factory EmailValidationResponse.fromJson(Map<String, dynamic> json) => EmailValidationResponse(
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
    this.emailvalidated,
  });

  bool emailvalidated;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    emailvalidated: json["emailvalidated"],
  );

  Map<String, dynamic> toJson() => {
    "emailvalidated": emailvalidated,
  };
}
