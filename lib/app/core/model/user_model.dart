// generated https://app.quicktype.io/
// To parse this JSON data, do
//
//     final User = UserFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String cpf;
  @HiveField(3)
  String email;
  @HiveField(4)
  DateTime dateBirth;
  @HiveField(5)
  String fone;
  @HiveField(6)
  String street;
  @HiveField(7)
  String num;
  @HiveField(8)
  String district;
  @HiveField(9)
  String? complement;
  @HiveField(10)
  String? userCreated;
  @HiveField(11)
  DateTime? createdAt;
  @HiveField(12)
  List? demands;

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
    this.createdAt,
    required this.demands,
    required this.cpf,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        dateBirth: DateTime.parse(json["date_birth"]),
        fone: json["fone"],
        street: json["street"],
        num: json["num"],
        district: json["district"],
        complement: json["complement"],
        userCreated: json["user_created"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        demands: json["demands"],
        cpf: json["cpf"],
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
        "demands": demands,
        "cpf": cpf,
      };

  static List<UserModel> fromJsonList(List? list) {
    return list!.map<UserModel>((item) => UserModel.fromJson(item)).toList();
  }
}
