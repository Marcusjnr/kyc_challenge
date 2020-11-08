// To parse this JSON data, do
//
//     final levelUpgradeResponse = levelUpgradeResponseFromJson(jsonString);

import 'dart:convert';

LevelUpgradeResponse levelUpgradeResponseFromJson(String str) => LevelUpgradeResponse.fromJson(json.decode(str));

String levelUpgradeResponseToJson(LevelUpgradeResponse data) => json.encode(data.toJson());

class LevelUpgradeResponse {
  LevelUpgradeResponse({
    this.success,
    this.message,
    this.result,
  });

  bool success;
  String message;
  Result result;

  factory LevelUpgradeResponse.fromJson(Map<String, dynamic> json) => LevelUpgradeResponse(
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
    this.userlevel,
  });

  String userlevel;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userlevel: json["userlevel"],
  );

  Map<String, dynamic> toJson() => {
    "userlevel": userlevel,
  };
}
