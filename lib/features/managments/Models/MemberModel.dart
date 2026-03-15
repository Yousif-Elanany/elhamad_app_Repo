// To parse this JSON data, do
//
//     final memberResponseModel = memberResponseModelFromJson(jsonString);

import 'dart:convert';

MemberResponseModel memberResponseModelFromJson(String str) => MemberResponseModel.fromJson(json.decode(str));

String memberResponseModelToJson(MemberResponseModel data) => json.encode(data.toJson());

class MemberResponseModel {
  List<Item> items;
  int pageNumber;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;

  MemberResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory MemberResponseModel.fromJson(Map<String, dynamic> json) => MemberResponseModel(
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
  String nationalId;
  String name;
  String email;
  String phone;
  String jobTitle;
  String membershipType;
  DateTime startDate;
  dynamic endDate;
  dynamic endReason;
  bool isActive;
  dynamic signatureStatus;

  Item({
    required this.profileId,
    required this.userId,
    required this.nationalId,
    required this.name,
    required this.email,
    required this.phone,
    required this.jobTitle,
    required this.membershipType,
    required this.startDate,
    required this.endDate,
    required this.endReason,
    required this.isActive,
    required this.signatureStatus,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    profileId: json["profileId"],
    userId: json["userId"],
    nationalId: json["nationalId"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    jobTitle: json["jobTitle"],
    membershipType: json["membershipType"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: json["endDate"],
    endReason: json["endReason"],
    isActive: json["isActive"],
    signatureStatus: json["signatureStatus"],
  );

  Map<String, dynamic> toJson() => {
    "profileId": profileId,
    "userId": userId,
    "nationalId": nationalId,
    "name": name,
    "email": email,
    "phone": phone,
    "jobTitle": jobTitle,
    "membershipType": membershipType,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "endDate": endDate,
    "endReason": endReason,
    "isActive": isActive,
    "signatureStatus": signatureStatus,
  };
}
