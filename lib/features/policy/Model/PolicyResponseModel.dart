// To parse this JSON data, do
//
//     final policiesResponseModel = policiesResponseModelFromJson(jsonString);

import 'dart:convert';

PoliciesResponseModel policiesResponseModelFromJson(String str) => PoliciesResponseModel.fromJson(json.decode(str));

String policiesResponseModelToJson(PoliciesResponseModel data) => json.encode(data.toJson());

class PoliciesResponseModel {
  List<Item> items;
  int pageNumber;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;

  PoliciesResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory PoliciesResponseModel.fromJson(Map<String, dynamic> json) => PoliciesResponseModel(
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
  String companyId;
  String companyName;
  String creatorEmail;
  String creatorName;
  DateTime createdAt;
  bool createdByHamad;

  Item({
    required this.id,
    required this.title,
    required this.status,
    required this.companyId,
    required this.companyName,
    required this.creatorEmail,
    required this.creatorName,
    required this.createdAt,
    required this.createdByHamad,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    title: json["title"],
    status: json["status"],
    companyId: json["companyId"],
    companyName: json["companyName"],
    creatorEmail: json["creatorEmail"],
    creatorName: json["creatorName"],
    createdAt: DateTime.parse(json["createdAt"]),
    createdByHamad: json["createdByHamad"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "status": status,
    "companyId": companyId,
    "companyName": companyName,
    "creatorEmail": creatorEmail,
    "creatorName": creatorName,
    "createdAt": createdAt.toIso8601String(),
    "createdByHamad": createdByHamad,
  };
}
