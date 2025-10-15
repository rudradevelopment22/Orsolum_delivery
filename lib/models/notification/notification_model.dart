import 'dart:convert';

class NotificationModel {
  String? createFor;
  DateTime? createdAt;
  String? message;
  String? subMessage;
  String? title;
  String? type;
  DateTime? updatedAt;
  int? v;
  String? id;

  NotificationModel({
    this.createFor,
    this.createdAt,
    this.message,
    this.subMessage,
    this.title,
    this.type,
    this.updatedAt,
    this.v,
    this.id,
  });

  factory NotificationModel.fromRawJson(String str) =>
      NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(
    Map<String, dynamic> json,
  ) => NotificationModel(
    createFor: json["createFor"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    message: json["message"],
    subMessage: json["subMessage"],
    title: json["title"],
    type: json["type"],
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "createFor": createFor,
    "createdAt": createdAt?.toIso8601String(),
    "message": message,
    "subMessage": subMessage,
    "title": title,
    "type": type,
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "_id": id,
  };
}
