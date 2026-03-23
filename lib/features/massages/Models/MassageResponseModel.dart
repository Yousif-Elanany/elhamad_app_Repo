// To parse this JSON data, do
//
//     final massageResponseModel = massageResponseModelFromJson(jsonString);

import 'dart:convert';

MassageResponseModel massageResponseModelFromJson(String str) => MassageResponseModel.fromJson(json.decode(str));

String massageResponseModelToJson(MassageResponseModel data) => json.encode(data.toJson());

class MassageResponseModel {
  List<Item> items;
  int pageNumber;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;

  MassageResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory MassageResponseModel.fromJson(Map<String, dynamic> json) => MassageResponseModel(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    totalCount: json["totalCount"],
    totalPages: json["totalPages"],
    hasPreviousPage: json["hasPreviousPage"],
    hasNextPage: json["hasNextPage"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "totalCount": totalCount,
    "totalPages": totalPages,
    "hasPreviousPage": hasPreviousPage,
    "hasNextPage": hasNextPage,
  };
}

class Item {
  int id;
  String title;
  String status;
  DateTime sentAt;
  int totalRecipients;
  List<String> channels;

  Item({
    required this.id,
    required this.title,
    required this.status,
    required this.sentAt,
    required this.totalRecipients,
    required this.channels,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    title: json["title"],
    status: json["status"],
    sentAt: DateTime.parse(json["sentAt"]),
    totalRecipients: json["totalRecipients"],
    channels: List<String>.from(json["channels"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "status": status,
    "sentAt": sentAt.toIso8601String(),
    "totalRecipients": totalRecipients,
    "channels": List<dynamic>.from(channels.map((x) => x)),
  };
}
