import 'dart:convert';

DemandsModel demandsModelFromJson(String str) =>
    DemandsModel.fromJson(json.decode(str));

String demandsModelToJson(DemandsModel data) => json.encode(data.toJson());

class DemandsModel {
  String id;
  String title;
  String? description;
  DateTime solicitationDate;
  DateTime? doneDate;
  bool isDone;
  String userId;

  DemandsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.solicitationDate,
    required this.doneDate,
    required this.isDone,
    required this.userId,
  });

  factory DemandsModel.fromJson(Map<String, dynamic> json) => DemandsModel(
        id: json["id"],
        title: json['title'],
        description: json['description'],
        solicitationDate: json['solicitation_date'],
        doneDate: json['done_date'],
        isDone: json['done'],
        userId: json['user_id'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "solicitation_date": solicitationDate,
        "done_date": doneDate,
        "done": isDone,
        "user_id": userId,
      };
}
