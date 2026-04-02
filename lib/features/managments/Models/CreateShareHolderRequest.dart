// To parse this JSON data, do
//
//     final createShareHolderRequestModel = createShareHolderRequestModelFromJson(jsonString);

import 'dart:convert';

CreateShareHolderRequestModel createShareHolderRequestModelFromJson(
  String str,
) => CreateShareHolderRequestModel.fromJson(json.decode(str));

String createShareHolderRequestModelToJson(
  CreateShareHolderRequestModel data,
) => json.encode(data.toJson());

class CreateShareHolderRequestModel {
  String name;
  String nameAr;
  String phoneNumber;
  String email;
  String nationalId;
  String nationality;
  String address;
  DateTime dateOfBirth;
  String guardianUserId;
  int sharesOwned;
  DateTime shareAcquisitionDate;
  String shareholderType;
  String unifiedNationalNumber;

  CreateShareHolderRequestModel({
    required this.name,
    required this.nameAr,
    required this.phoneNumber,
    required this.email,
    required this.nationalId,
    required this.nationality,
    required this.address,
    required this.dateOfBirth,
    required this.guardianUserId,
    required this.sharesOwned,
    required this.shareAcquisitionDate,
    required this.shareholderType,
    required this.unifiedNationalNumber,
  });

  factory CreateShareHolderRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateShareHolderRequestModel(
        name: json["name"],
        nameAr: json["nameAr"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        nationalId: json["nationalId"],
        nationality: json["nationality"],
        address: json["address"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        guardianUserId: json["guardianUserId"],
        sharesOwned: json["sharesOwned"],
        shareAcquisitionDate: DateTime.parse(json["shareAcquisitionDate"]),
        shareholderType: json["shareholderType"],
        unifiedNationalNumber: json["unifiedNationalNumber"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "nameAr": nameAr,
    "phoneNumber": phoneNumber,
    "email": email,
    "nationalId": nationalId,
    "nationality": nationality,
    "address": address,
    "dateOfBirth":
        "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "guardianUserId": guardianUserId,
    "sharesOwned": sharesOwned,
    "shareAcquisitionDate": shareAcquisitionDate.toIso8601String(),
    "shareholderType": shareholderType,
    "unifiedNationalNumber": unifiedNationalNumber,
  };
}
