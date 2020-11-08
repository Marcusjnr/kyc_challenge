// To parse this JSON data, do
//
//     final levelUpgradeRequest = levelUpgradeRequestFromJson(jsonString);

import 'dart:convert';

LevelUpgradeRequest levelUpgradeRequestFromJson(String str) => LevelUpgradeRequest.fromJson(json.decode(str));

String levelUpgradeRequestToJson(LevelUpgradeRequest data) => json.encode(data.toJson());

class LevelUpgradeRequest {
  LevelUpgradeRequest({
    this.email,
    this.level,
  });

  String email;
  String level;

  factory LevelUpgradeRequest.fromJson(Map<String, dynamic> json) => LevelUpgradeRequest(
    email: json["email"],
    level: json["level"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "level": level,
  };
}
