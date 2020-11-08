// To parse this JSON data, do
//
//     final bvnValidationResponse = bvnValidationResponseFromJson(jsonString);

import 'dart:convert';

BvnValidationResponse bvnValidationResponseFromJson(String str) => BvnValidationResponse.fromJson(json.decode(str));

String bvnValidationResponseToJson(BvnValidationResponse data) => json.encode(data.toJson());

class BvnValidationResponse {
  BvnValidationResponse({
    this.valid,
    this.dob,
    this.phoneNumber,
  });

  bool valid;
  String dob;
  String phoneNumber;

  factory BvnValidationResponse.fromJson(Map<String, dynamic> json) => BvnValidationResponse(
    valid: json["valid"],
    dob: json["dob"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "valid": valid,
    "dob": dob,
    "phoneNumber": phoneNumber,
  };
}
