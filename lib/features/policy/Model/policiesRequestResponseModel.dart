// To parse this JSON data, do
//
//     final policiesRequestResponseModel = policiesRequestResponseModelFromJson(jsonString);

import 'dart:convert';

PoliciesRequestResponseModel policiesRequestResponseModelFromJson(String str) => PoliciesRequestResponseModel.fromJson(json.decode(str));

String policiesRequestResponseModelToJson(PoliciesRequestResponseModel data) => json.encode(data.toJson());

class PoliciesRequestResponseModel {
  List<Item> items;
  int pageNumber;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;

  PoliciesRequestResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory PoliciesRequestResponseModel.fromJson(Map<String, dynamic> json) => PoliciesRequestResponseModel(
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
  String notes;
  String requestedByName;
  String companyName;
  String status;
  DateTime createdAt;

  Item({
    required this.id,
    required this.title,
    required this.notes,
    required this.requestedByName,
    required this.companyName,
    required this.status,
    required this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    title: json["title"],
    notes: json["notes"],
    requestedByName: json["requestedByName"],
    companyName: json["companyName"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "notes": notes,
    "requestedByName": requestedByName,
    "companyName": companyName,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
  };
}
