// To parse this JSON data, do
//
//     final createBoardMemberRequestlModel = createBoardMemberRequestlModelFromJson(jsonString);

import 'dart:convert';

CreateBoardMemberRequestlModel createBoardMemberRequestlModelFromJson(String str) => CreateBoardMemberRequestlModel.fromJson(json.decode(str));

String createBoardMemberRequestlModelToJson(CreateBoardMemberRequestlModel data) => json.encode(data.toJson());

class CreateBoardMemberRequestlModel {
  PersonalInfo personalInfo;
  String jobTitle;
  String membershipType;
  DateTime startDate;

  CreateBoardMemberRequestlModel({
    required this.personalInfo,
    required this.jobTitle,
    required this.membershipType,
    required this.startDate,
  });

  factory CreateBoardMemberRequestlModel.fromJson(Map<String, dynamic> json) => CreateBoardMemberRequestlModel(
    personalInfo: PersonalInfo.fromJson(json["personalInfo"]),
    jobTitle: json["jobTitle"],
    membershipType: json["membershipType"],
    startDate: DateTime.parse(json["startDate"]),
  );

  Map<String, dynamic> toJson() => {
    "personalInfo": personalInfo.toJson(),
    "jobTitle": jobTitle,
    "membershipType": membershipType,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
  };
}

class PersonalInfo {
  String name;
  String nameAr;
  String phoneNumber;
  String nationalId;
  String email;
  DateTime dateOfBirth;
  String nationality;
  String address;
  int profilePictureDocumentId;

  PersonalInfo({
    required this.name,
    required this.nameAr,
    required this.phoneNumber,
    required this.nationalId,
    required this.email,
    required this.dateOfBirth,
    required this.nationality,
    required this.address,
    required this.profilePictureDocumentId,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
    name: json["name"],
    nameAr: json["nameAr"],
    phoneNumber: json["phoneNumber"],
    nationalId: json["nationalId"],
    email: json["email"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    nationality: json["nationality"],
    address: json["address"],
    profilePictureDocumentId: json["profilePictureDocumentId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "nameAr": nameAr,
    "phoneNumber": phoneNumber,
    "nationalId": nationalId,
    "email": email,
    "dateOfBirth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "nationality": nationality,
    "address": address,
    "profilePictureDocumentId": profilePictureDocumentId,
  };
}
