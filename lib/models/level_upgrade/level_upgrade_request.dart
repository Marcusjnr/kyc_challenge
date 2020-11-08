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
    this.imageUrl
  });

  String email;
  String level;
  String imageUrl;

  factory LevelUpgradeRequest.fromJson(Map<String, dynamic> json) => LevelUpgradeRequest(
    email: json["email"],
    level: json["level"],
    imageUrl: json["imageurl"]
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "level": level,
    "imageurl": imageUrl
  };
}
