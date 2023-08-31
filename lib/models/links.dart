

import 'dart:convert';

List<Links> linkFromJson(String str) => List<Links>.from(json.decode(str).map((x) => Links.fromJson(x)));

String linkToJson(List<Links> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Links {
  int? id;
  String? title;
  String? link;
  String? username;
  String? isActive;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Links({
    this.id,
    this.title,
    this.link,
    this.username,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    id: json["id"],
    title: json["title"],
    link: json["link"],
    username: json["username"],
    isActive: json["isActive"],
    userId: json["user_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "link": link,
    "username": username,
    "isActive": isActive,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
