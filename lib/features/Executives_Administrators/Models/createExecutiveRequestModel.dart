// To parse this JSON data, do
//
//     final createExecutiveRequestModel = createExecutiveRequestModelFromJson(jsonString);

import 'dart:convert';

CreateExecutiveRequestModel createExecutiveRequestModelFromJson(String str) =>
    CreateExecutiveRequestModel.fromJson(json.decode(str));

String createExecutiveRequestModelToJson(CreateExecutiveRequestModel data) =>
    json.encode(data.toJson());

class CreateExecutiveRequestModel {
  PersonalInfo personalInfo;
  String jobTitle;
  bool isActive;

  CreateExecutiveRequestModel({
    required this.personalInfo,
    required this.jobTitle,
    required this.isActive,
  });

  factory CreateExecutiveRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateExecutiveRequestModel(
        personalInfo: PersonalInfo.fromJson(json["personalInfo"]),
        jobTitle: json["jobTitle"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
    "personalInfo": personalInfo.toJson(),
    "jobTitle": jobTitle,
    "isActive": isActive,
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
    "dateOfBirth":
        "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "nationality": nationality,
    "address": address,
    "profilePictureDocumentId": profilePictureDocumentId,
  };
}
