// To parse this JSON data, do
//
//     final organizationsRequestsResponseModel = organizationsRequestsResponseModelFromJson(jsonString);

import 'dart:convert';

OrganizationsRequestsResponseModel organizationsRequestsResponseModelFromJson(String str) => OrganizationsRequestsResponseModel.fromJson(json.decode(str));

String organizationsRequestsResponseModelToJson(OrganizationsRequestsResponseModel data) => json.encode(data.toJson());

class OrganizationsRequestsResponseModel {
  List<Item> items;
  int pageNumber;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;

  OrganizationsRequestsResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory OrganizationsRequestsResponseModel.fromJson(Map<String, dynamic> json) => OrganizationsRequestsResponseModel(
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
  DateTime startTime;
  String meetingType;
  String status;

  Item({
    required this.id,
    required this.startTime,
    required this.meetingType,
    required this.status,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    startTime: DateTime.parse(json["startTime"]),
    meetingType: json["meetingType"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "startTime": startTime.toIso8601String(),
    "meetingType": meetingType,
    "status": status,
  };
}
