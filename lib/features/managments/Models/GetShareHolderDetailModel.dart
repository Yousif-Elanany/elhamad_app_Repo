// To parse this JSON data, do
//
//     final getShareHolderByProfileIdModel = getShareHolderByProfileIdModelFromJson(jsonString);

import 'dart:convert';

ShareHolderByProfileIdResponseModel getShareHolderByProfileIdModelFromJson(
  String str,
) => ShareHolderByProfileIdResponseModel.fromJson(json.decode(str));

String getShareHolderByProfileIdModelToJson(
  ShareHolderByProfileIdResponseModel data,
) => json.encode(data.toJson());

class ShareHolderByProfileIdResponseModel {
  PersonalInfo personalInfo;
  int sharesOwned;
  int sharePercentage;
  String shareholderType;
  DateTime shareAcquisitionDate;
  DateTime createdAt;
  String guardianUserId;
  String guardianName;

  ShareHolderByProfileIdResponseModel({
    required this.personalInfo,
    required this.sharesOwned,
    required this.sharePercentage,
    required this.shareholderType,
    required this.shareAcquisitionDate,
    required this.createdAt,
    required this.guardianUserId,
    required this.guardianName,
  });

  factory ShareHolderByProfileIdResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => ShareHolderByProfileIdResponseModel(
    personalInfo: PersonalInfo.fromJson(json["personalInfo"]),
    sharesOwned: json["sharesOwned"],
    sharePercentage: json["sharePercentage"],
    shareholderType: json["shareholderType"],
    shareAcquisitionDate: DateTime.parse(json["shareAcquisitionDate"]),
    createdAt: DateTime.parse(json["createdAt"]),
    guardianUserId: json["guardianUserId"],
    guardianName: json["guardianName"],
  );

  Map<String, dynamic> toJson() => {
    "personalInfo": personalInfo.toJson(),
    "sharesOwned": sharesOwned,
    "sharePercentage": sharePercentage,
    "shareholderType": shareholderType,
    "shareAcquisitionDate": shareAcquisitionDate.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "guardianUserId": guardianUserId,
    "guardianName": guardianName,
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
