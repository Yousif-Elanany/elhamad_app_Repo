// To parse this JSON data, do
//
//     final documentationResponseModel = documentationResponseModelFromJson(jsonString);

import 'dart:convert';

DocumentationResponseModel documentationResponseModelFromJson(String str) => DocumentationResponseModel.fromJson(json.decode(str));

String documentationResponseModelToJson(DocumentationResponseModel data) => json.encode(data.toJson());

class DocumentationResponseModel {
  List<Item> items;
  int pageNumber;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;

  DocumentationResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory DocumentationResponseModel.fromJson(Map<String, dynamic> json) => DocumentationResponseModel(
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
  String title;
  String type;
  String description;
  String creatorName;
  String companyName;
  String status;
  DateTime createdAt;

  Item({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.creatorName,
    required this.companyName,
    required this.status,
    required this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    title: json["title"],
    type: json["type"],
    description: json["description"],
    creatorName: json["creatorName"],
    companyName: json["companyName"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": type,
    "description": description,
    "creatorName": creatorName,
    "companyName": companyName,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
  };
}
