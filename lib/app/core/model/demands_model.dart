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
  DateTime? createdAt;
  String userCreated;

  DemandsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.solicitationDate,
    required this.doneDate,
    required this.isDone,
    required this.userId,
    required this.userCreated,
    this.createdAt,
  });

  factory DemandsModel.fromJson(Map<String, dynamic> json) => DemandsModel(
        id: json["id"],
        title: json['title'],
        description: json['description'],
        solicitationDate: DateTime.parse(json['solicitation_date']),
        doneDate: json['done_date'] != null
            ? DateTime.parse(json['done_date'])
            : null,
        isDone: json['done'],
        userId: json['user_id'],
        userCreated: json['user_created'],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "solicitation_date": solicitationDate,
        "done_date": doneDate,
        "done": isDone,
        "user_id": userId,
        "user_created": userCreated,
        "created_at": createdAt
      };

  static List<DemandsModel> fromJsonList(List? list) {
    return list!
        .map<DemandsModel>((item) => DemandsModel.fromJson(item))
        .toList();
  }
}
