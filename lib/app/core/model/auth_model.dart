import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  String id;
  String email;
  String password;

  AuthModel({required this.id, required this.email, required this.password});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
      };
}
