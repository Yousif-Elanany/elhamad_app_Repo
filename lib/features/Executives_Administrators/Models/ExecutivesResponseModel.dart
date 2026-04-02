// To parse this JSON data, do
//
//     final executivesResponseModel = executivesResponseModelFromJson(jsonString);

import 'dart:convert';

ExecutivesResponseModel executivesResponseModelFromJson(String str) => ExecutivesResponseModel.fromJson(json.decode(str));

String executivesResponseModelToJson(ExecutivesResponseModel data) => json.encode(data.toJson());

class ExecutivesResponseModel {
  List<Item> items;
  int pageNumber;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;

  ExecutivesResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory ExecutivesResponseModel.fromJson(Map<String, dynamic> json) => ExecutivesResponseModel(
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
  int profileId;
  String userId;
  String name;
  String phone;
  String nationalId;
  String email;
  String jobTitle;
  bool isActive;
  String signatureStatus;

  Item({
    required this.profileId,
    required this.userId,
    required this.name,
    required this.phone,
    required this.nationalId,
    required this.email,
    required this.jobTitle,
    required this.isActive,
    required this.signatureStatus,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    profileId: json["profileId"],
    userId: json["userId"],
    name: json["name"],
    phone: json["phone"],
    nationalId: json["nationalId"],
    email: json["email"],
    jobTitle: json["jobTitle"],
    isActive: json["isActive"],
    signatureStatus: json["signatureStatus"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "profileId": profileId,
    "userId": userId,
    "name": name,
    "phone": phone,
    "nationalId": nationalId,
    "email": email,
    "jobTitle": jobTitle,
    "isActive": isActive,
    "signatureStatus": signatureStatus,
  };
}
