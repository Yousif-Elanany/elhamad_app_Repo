// To parse this JSON data, do
//
//     final memberForCommitteesResponseModel = memberForCommitteesResponseModelFromJson(jsonString);

import 'dart:convert';

List<MemberForCommitteesResponseModel> memberForCommitteesResponseModelFromJson(String str) => List<MemberForCommitteesResponseModel>.from(json.decode(str).map((x) => MemberForCommitteesResponseModel.fromJson(x)));

String memberForCommitteesResponseModelToJson(List<MemberForCommitteesResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberForCommitteesResponseModel {
  int profileId;
  String userId;
  String name;
  String phoneNumber;
  String nationalId;
  String email;
  String jobTitle;
  DateTime startDate;
  dynamic endDate;
  dynamic endReason;
  bool isActive;
  dynamic signatureStatus;

  MemberForCommitteesResponseModel({
    required this.profileId,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.nationalId,
    required this.email,
    required this.jobTitle,
    required this.startDate,
    required this.endDate,
    required this.endReason,
    required this.isActive,
    required this.signatureStatus,
  });

  factory MemberForCommitteesResponseModel.fromJson(Map<String, dynamic> json) => MemberForCommitteesResponseModel(
    profileId: json["profileId"],
    userId: json["userId"],
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    nationalId: json["nationalId"],
    email: json["email"],
    jobTitle: json["jobTitle"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: json["endDate"],
    endReason: json["endReason"],
    isActive: json["isActive"],
    signatureStatus: json["signatureStatus"],
  );

  Map<String, dynamic> toJson() => {
    "profileId": profileId,
    "userId": userId,
    "name": name,
    "phoneNumber": phoneNumber,
    "nationalId": nationalId,
    "email": email,
    "jobTitle": jobTitle,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate,
    "endReason": endReason,
    "isActive": isActive,
    "signatureStatus": signatureStatus,
  };
}
