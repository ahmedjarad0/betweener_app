// To parse this JSON data, do
//
//     final follow = followFromJson(jsonString);

import 'dart:convert';

Follow followFromJson(String str) => Follow.fromJson(json.decode(str));

String followToJson(Follow data) => json.encode(data.toJson());

class Follow {
  int? followingCount;
  int? followersCount;
  List<FollowerElement>? following;
  List<FollowerElement>? followers;

  Follow({
    this.followingCount,
    this.followersCount,
    this.following,
    this.followers,
  });

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
    followingCount: json["following_count"],
    followersCount: json["followers_count"],
    following: json["following"] == null ? [] : List<FollowerElement>.from(json["following"]!.map((x) => FollowerElement.fromJson(x))),
    followers: json["followers"] == null ? [] : List<FollowerElement>.from(json["followers"]!.map((x) => FollowerElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "following_count": followingCount,
    "followers_count": followersCount,
    "following": following == null ? [] : List<dynamic>.from(following!.map((x) => x.toJson())),
    "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x.toJson())),
  };
}

class FollowerElement {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? isActive;
  dynamic country;
  dynamic ip;
  dynamic long;
  dynamic lat;

  FollowerElement({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.country,
    this.ip,
    this.long,
    this.lat,
  });

  factory FollowerElement.fromJson(Map<String, dynamic> json) => FollowerElement(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isActive: json["isActive"],
    country: json["country"],
    ip: json["ip"],
    long: json["long"],
    lat: json["lat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "isActive": isActive,
    "country": country,
    "ip": ip,
    "long": long,
    "lat": lat,
  };
}
