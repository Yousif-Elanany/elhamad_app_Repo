// To parse this JSON data, do
//
//     final organizationsResponseModel = organizationsResponseModelFromJson(jsonString);

import 'dart:convert';

OrganizationsResponseModel organizationsResponseModelFromJson(String str) => OrganizationsResponseModel.fromJson(json.decode(str));

String organizationsResponseModelToJson(OrganizationsResponseModel data) => json.encode(data.toJson());

class OrganizationsResponseModel {
  List<Item> items;
  int pageNumber;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;

  OrganizationsResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory OrganizationsResponseModel.fromJson(Map<String, dynamic> json) => OrganizationsResponseModel(
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
  String status;
  String link;
  String meetingVenue;
  DateTime createdAt;
  QuorumInfo quorumInfo;

  Item({
    required this.id,
    required this.startTime,
    required this.status,
    required this.link,
    required this.meetingVenue,
    required this.createdAt,
    required this.quorumInfo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    startTime: DateTime.parse(json["startTime"]),
    status: json["status"],
    link: json["link"],
    meetingVenue: json["meetingVenue"],
    createdAt: DateTime.parse(json["createdAt"]),
    quorumInfo: QuorumInfo.fromJson(json["quorumInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "startTime": startTime.toIso8601String(),
    "status": status,
    "link": link,
    "meetingVenue": meetingVenue,
    "createdAt": createdAt.toIso8601String(),
    "quorumInfo": quorumInfo.toJson(),
  };
}

class QuorumInfo {
  int currentAttempt;
  int maxAttempts;
  int requiredPercentage;
  int currentPercentage;
  DateTime quorumAchievedAt;
  bool hasFailed;
  DateTime nextAttemptStartTime;
  DateTime effectiveStartTime;

  QuorumInfo({
    required this.currentAttempt,
    required this.maxAttempts,
    required this.requiredPercentage,
    required this.currentPercentage,
    required this.quorumAchievedAt,
    required this.hasFailed,
    required this.nextAttemptStartTime,
    required this.effectiveStartTime,
  });

  factory QuorumInfo.fromJson(Map<String, dynamic> json) => QuorumInfo(
    currentAttempt: json["currentAttempt"],
    maxAttempts: json["maxAttempts"],
    requiredPercentage: json["requiredPercentage"],
    currentPercentage: json["currentPercentage"],
    quorumAchievedAt: DateTime.parse(json["quorumAchievedAt"]),
    hasFailed: json["hasFailed"],
    nextAttemptStartTime: DateTime.parse(json["nextAttemptStartTime"]),
    effectiveStartTime: DateTime.parse(json["effectiveStartTime"]),
  );

  Map<String, dynamic> toJson() => {
    "currentAttempt": currentAttempt,
    "maxAttempts": maxAttempts,
    "requiredPercentage": requiredPercentage,
    "currentPercentage": currentPercentage,
    "quorumAchievedAt": quorumAchievedAt.toIso8601String(),
    "hasFailed": hasFailed,
    "nextAttemptStartTime": nextAttemptStartTime.toIso8601String(),
    "effectiveStartTime": effectiveStartTime.toIso8601String(),
  };
}
