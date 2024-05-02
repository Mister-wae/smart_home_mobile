// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  final String? message;
  final List<Datum>? data;

  Welcome({
    this.message,
    this.data,
  });

  Welcome copyWith({
    String? message,
    List<Datum>? data,
  }) =>
      Welcome(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String? id;
  final String? name;
  final String? type;
  final String? location;
  final String? user;
  final String? path;
  final String? manufacturer;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Datum({
    this.id,
    this.name,
    this.type,
    this.location,
    this.user,
    this.path,
    this.manufacturer,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Datum copyWith({
    String? id,
    String? name,
    String? type,
    String? location,
    String? user,
    String? path,
    String? manufacturer,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        location: location ?? this.location,
        user: user ?? this.user,
        path: path ?? this.path,
        manufacturer: manufacturer ?? this.manufacturer,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        location: json["location"],
        user: json["user"],
        path: json["path"],
        manufacturer: json["manufacturer"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "type": type,
        "location": location,
        "user": user,
        "path": path,
        "manufacturer": manufacturer,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class User {
  String email;
  String firstName;
  String lastName;
  String token;

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "token": token,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        token: json["token"],
      );
}
