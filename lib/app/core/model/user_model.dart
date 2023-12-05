// generated https://app.quicktype.io/
// To parse this JSON data, do
//
//     final User = UserFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String name;
  String email;
  int dateBirth;
  String fone;
  String street;
  String num;
  String district;
  String complement;
  String? userCreated;
  int createdAt;
  List<String> demands;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.dateBirth,
    required this.fone,
    required this.street,
    required this.num,
    required this.district,
    required this.complement,
    required this.userCreated,
    required this.createdAt,
    required this.demands,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        dateBirth: json["date_birth"],
        fone: json["fone"],
        street: json["street"],
        num: json["num"],
        district: json["district"],
        complement: json["complement"],
        userCreated: json["user_created"] ?? '',
        createdAt: json["created_at"],
        demands: json["demands"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "date_birth": dateBirth,
        "fone": fone,
        "street": street,
        "num": num,
        "district": district,
        "complement": complement,
        "user_created": userCreated,
        "created_at": createdAt,
      };
}
