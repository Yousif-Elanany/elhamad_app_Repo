// To parse this JSON data, do
//
//     final committeesResponseModel = committeesResponseModelFromJson(jsonString);

import 'dart:convert';

CommitteesResponseModel committeesResponseModelFromJson(String str) => CommitteesResponseModel.fromJson(json.decode(str));

String committeesResponseModelToJson(CommitteesResponseModel data) => json.encode(data.toJson());

class CommitteesResponseModel {
  List<Item> items;
  int pageNumber;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;

  CommitteesResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory CommitteesResponseModel.fromJson(Map<String, dynamic> json) => CommitteesResponseModel(
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
  String type;
  DateTime startDate;
  DateTime endDate;
  int membersCount;
  int activeMembersCount;
  int openPositionCount;
  int yearlyMeetingsCount;
  bool isActive;
  DateTime createdAt;

  Item({
    required this.id,
    required this.companyId,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.membersCount,
    required this.activeMembersCount,
    required this.openPositionCount,
    required this.yearlyMeetingsCount,
    required this.isActive,
    required this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    companyId: json["companyId"],
    type: json["type"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    membersCount: json["membersCount"],
    activeMembersCount: json["activeMembersCount"],
    openPositionCount: json["openPositionCount"],
    yearlyMeetingsCount: json["yearlyMeetingsCount"],
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyId": companyId,
    "type": type,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "membersCount": membersCount,
    "activeMembersCount": activeMembersCount,
    "openPositionCount": openPositionCount,
    "yearlyMeetingsCount": yearlyMeetingsCount,
    "isActive": isActive,
    "createdAt": createdAt.toIso8601String(),
  };
}
