// To parse this JSON data, do
//
//     final bvnValidationRequest = bvnValidationRequestFromJson(jsonString);

import 'dart:convert';

BvnValidationRequest bvnValidationRequestFromJson(String str) => BvnValidationRequest.fromJson(json.decode(str));

String bvnValidationRequestToJson(BvnValidationRequest data) => json.encode(data.toJson());

class BvnValidationRequest {
  BvnValidationRequest({
    this.dob
  });

  String dob;

  factory BvnValidationRequest.fromJson(Map<String, dynamic> json) => BvnValidationRequest(
    dob: json["dob"],
  );

  Map<String, dynamic> toJson() => {
    "dob": dob,
  };
}
