// To parse this JSON data, do
//
//     final memberOfBoardResponseModel = memberOfBoardResponseModelFromJson(jsonString);

import 'dart:convert';

MemberOfBoardResponseModel memberOfBoardResponseModelFromJson(String str) => MemberOfBoardResponseModel.fromJson(json.decode(str));

String memberOfBoardResponseModelToJson(MemberOfBoardResponseModel data) => json.encode(data.toJson());

class MemberOfBoardResponseModel {
  int profileId;
  PersonalInfo personalInfo;
  String jobTitle;
  String membershipType;
  DateTime startDate;
  dynamic endDate;
  dynamic endReason;
  bool isActive;
  int boardOfDirectorsId;

  MemberOfBoardResponseModel({
    required this.profileId,
    required this.personalInfo,
    required this.jobTitle,
    required this.membershipType,
    required this.startDate,
    required this.endDate,
    required this.endReason,
    required this.isActive,
    required this.boardOfDirectorsId,
  });

  factory MemberOfBoardResponseModel.fromJson(Map<String, dynamic> json) => MemberOfBoardResponseModel(
    profileId: json["profileId"],
    personalInfo: PersonalInfo.fromJson(json["personalInfo"]),
    jobTitle: json["jobTitle"],
    membershipType: json["membershipType"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: json["endDate"],
    endReason: json["endReason"],
    isActive: json["isActive"],
    boardOfDirectorsId: json["boardOfDirectorsId"],
  );

  Map<String, dynamic> toJson() => {
    "profileId": profileId,
    "personalInfo": personalInfo.toJson(),
    "jobTitle": jobTitle,
    "membershipType": membershipType,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "endDate": endDate,
    "endReason": endReason,
    "isActive": isActive,
    "boardOfDirectorsId": boardOfDirectorsId,
  };
}

class PersonalInfo {
  String userId;
  String name;
  String nameAr;
  String phoneNumber;
  String nationalId;
  String email;
  DateTime dateOfBirth;
  dynamic nationality;
  dynamic address;
  dynamic profilePicture;

  PersonalInfo({
    required this.userId,
    required this.name,
    required this.nameAr,
    required this.phoneNumber,
    required this.nationalId,
    required this.email,
    required this.dateOfBirth,
    required this.nationality,
    required this.address,
    required this.profilePicture,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
    userId: json["userId"],
    name: json["name"],
    nameAr: json["nameAr"],
    phoneNumber: json["phoneNumber"],
    nationalId: json["nationalId"],
    email: json["email"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    nationality: json["nationality"],
    address: json["address"],
    profilePicture: json["profilePicture"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "nameAr": nameAr,
    "phoneNumber": phoneNumber,
    "nationalId": nationalId,
    "email": email,
    "dateOfBirth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "nationality": nationality,
    "address": address,
    "profilePicture": profilePicture,
  };
}
