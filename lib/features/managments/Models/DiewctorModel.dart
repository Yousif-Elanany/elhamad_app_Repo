// To parse this JSON data, do
//
//     final directorsResponseModel = directorsResponseModelFromJson(jsonString);

import 'dart:convert';

DirectorsResponseModel directorsResponseModelFromJson(String str) =>
    DirectorsResponseModel.fromJson(json.decode(str));

String directorsResponseModelToJson(DirectorsResponseModel data) =>
    json.encode(data.toJson());

class DirectorsResponseModel {
  List<Item> items;
  int pageNumber;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;

  DirectorsResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory DirectorsResponseModel.fromJson(Map<String, dynamic> json) =>
      DirectorsResponseModel(
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
  String companyId;
  DateTime startDate;
  DateTime endDate;
  int membersCount;
  int activeMembersCount;
  int openPositionCount;
  bool isActive;
  String createdAt;

  Item({
    required this.id,
    required this.companyId,
    required this.startDate,
    required this.endDate,
    required this.membersCount,
    required this.activeMembersCount,
    required this.openPositionCount,
    required this.isActive,
    required this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    companyId: json["companyId"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    membersCount: json["membersCount"],
    activeMembersCount: json["activeMembersCount"],
    openPositionCount: json["openPositionCount"],
    isActive: json["isActive"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyId": companyId,
    "startDate":
        "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "endDate":
        "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "membersCount": membersCount,
    "activeMembersCount": activeMembersCount,
    "openPositionCount": openPositionCount,
    "isActive": isActive,
    "createdAt": createdAt,
  };
}
