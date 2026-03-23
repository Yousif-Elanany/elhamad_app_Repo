// To parse this JSON data, do
//
//     final contactUsResponseModel = contactUsResponseModelFromJson(jsonString);

import 'dart:convert';

ContactUsResponseModel contactUsResponseModelFromJson(String str) => ContactUsResponseModel.fromJson(json.decode(str));

String contactUsResponseModelToJson(ContactUsResponseModel data) => json.encode(data.toJson());

class ContactUsResponseModel {
  List<Item> items;
  int pageNumber;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;

  ContactUsResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory ContactUsResponseModel.fromJson(Map<String, dynamic> json) => ContactUsResponseModel(
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
  String id;
  String complaintNumber;
  String complaintText;
  String createdByName;
  String type;
  DateTime createdAt;
  String status;
  int messageCount;

  Item({
    required this.id,
    required this.complaintNumber,
    required this.complaintText,
    required this.createdByName,
    required this.type,
    required this.createdAt,
    required this.status,
    required this.messageCount,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    complaintNumber: json["complaintNumber"],
    complaintText: json["complaintText"],
    createdByName: json["createdByName"],
    type: json["type"],
    createdAt: DateTime.parse(json["createdAt"]),
    status: json["status"],
    messageCount: json["messageCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "complaintNumber": complaintNumber,
    "complaintText": complaintText,
    "createdByName": createdByName,
    "type": type,
    "createdAt": createdAt.toIso8601String(),
    "status": status,
    "messageCount": messageCount,
  };
}
