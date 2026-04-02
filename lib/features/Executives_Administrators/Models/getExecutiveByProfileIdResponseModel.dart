// To parse this JSON data, do
//
//     final getExecutiveByProfileIdResponseModel = getExecutiveByProfileIdResponseModelFromJson(jsonString);

import 'dart:convert';

GetExecutiveByProfileIdResponseModel
getExecutiveByProfileIdResponseModelFromJson(String str) =>
    GetExecutiveByProfileIdResponseModel.fromJson(json.decode(str));

String getExecutiveByProfileIdResponseModelToJson(
  GetExecutiveByProfileIdResponseModel data,
) => json.encode(data.toJson());

class GetExecutiveByProfileIdResponseModel {
  int profileId;
  String companyId;
  String companyName;
  PersonalInfo personalInfo;
  String jobTitle;
  bool isActive;

  GetExecutiveByProfileIdResponseModel({
    required this.profileId,
    required this.companyId,
    required this.companyName,
    required this.personalInfo,
    required this.jobTitle,
    required this.isActive,
  });

  factory GetExecutiveByProfileIdResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => GetExecutiveByProfileIdResponseModel(
    profileId: json["profileId"],
    companyId: json["companyId"],
    companyName: json["companyName"],
    personalInfo: PersonalInfo.fromJson(json["personalInfo"]),
    jobTitle: json["jobTitle"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "profileId": profileId,
    "companyId": companyId,
    "companyName": companyName,
    "personalInfo": personalInfo.toJson(),
    "jobTitle": jobTitle,
    "isActive": isActive,
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
  String nationality;
  String address;
  ProfilePicture profilePicture;

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
    profilePicture: ProfilePicture.fromJson(json["profilePicture"]),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "nameAr": nameAr,
    "phoneNumber": phoneNumber,
    "nationalId": nationalId,
    "email": email,
    "dateOfBirth":
        "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "nationality": nationality,
    "address": address,
    "profilePicture": profilePicture.toJson(),
  };
}

class ProfilePicture {
  int id;
  String fileName;
  bool isPublic;
  String url;

  ProfilePicture({
    required this.id,
    required this.fileName,
    required this.isPublic,
    required this.url,
  });

  factory ProfilePicture.fromJson(Map<String, dynamic> json) => ProfilePicture(
    id: json["id"],
    fileName: json["fileName"],
    isPublic: json["isPublic"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fileName": fileName,
    "isPublic": isPublic,
    "url": url,
  };
}
