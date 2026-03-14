// To parse this JSON data, do
//
//     final companyDetailReasponseModel = companyDetailReasponseModelFromJson(jsonString);

import 'dart:convert';

CompanyDetailReasponseModel companyDetailReasponseModelFromJson(String str) => CompanyDetailReasponseModel.fromJson(json.decode(str));

String companyDetailReasponseModelToJson(CompanyDetailReasponseModel data) => json.encode(data.toJson());

class CompanyDetailReasponseModel {
  String id;
  String name;
  String nameAr;
  String nationalUnifiedNumber;
  int shareCount;
  int nominalShareValue;
  int capitalAmount;
  int paidUpCapitalAmount;
  String companyType;
  String companyStatus;
  String investorRelationsPhone;
  String investorRelationsEmail;
  String corporateHeadquarters;
  CompanyLogo companyLogo;
  dynamic companySeal;
  String adminEmail;
  String adminNationalId;
  String adminPhone;
  String adminName;
  String adminNameAr;
  DateTime createdAt;

  CompanyDetailReasponseModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.nationalUnifiedNumber,
    required this.shareCount,
    required this.nominalShareValue,
    required this.capitalAmount,
    required this.paidUpCapitalAmount,
    required this.companyType,
    required this.companyStatus,
    required this.investorRelationsPhone,
    required this.investorRelationsEmail,
    required this.corporateHeadquarters,
    required this.companyLogo,
    required this.companySeal,
    required this.adminEmail,
    required this.adminNationalId,
    required this.adminPhone,
    required this.adminName,
    required this.adminNameAr,
    required this.createdAt,
  });

  factory CompanyDetailReasponseModel.fromJson(Map<String, dynamic> json) => CompanyDetailReasponseModel(
    id: json["id"],
    name: json["name"],
    nameAr: json["nameAr"],
    nationalUnifiedNumber: json["nationalUnifiedNumber"],
    shareCount: json["shareCount"],
    nominalShareValue: json["nominalShareValue"],
    capitalAmount: json["capitalAmount"],
    paidUpCapitalAmount: json["paidUpCapitalAmount"],
    companyType: json["companyType"],
    companyStatus: json["companyStatus"],
    investorRelationsPhone: json["investorRelationsPhone"],
    investorRelationsEmail: json["investorRelationsEmail"],
    corporateHeadquarters: json["corporateHeadquarters"],
    companyLogo: CompanyLogo.fromJson(json["companyLogo"]),
    companySeal: json["companySeal"],
    adminEmail: json["adminEmail"],
    adminNationalId: json["adminNationalId"],
    adminPhone: json["adminPhone"],
    adminName: json["adminName"],
    adminNameAr: json["adminNameAr"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "nameAr": nameAr,
    "nationalUnifiedNumber": nationalUnifiedNumber,
    "shareCount": shareCount,
    "nominalShareValue": nominalShareValue,
    "capitalAmount": capitalAmount,
    "paidUpCapitalAmount": paidUpCapitalAmount,
    "companyType": companyType,
    "companyStatus": companyStatus,
    "investorRelationsPhone": investorRelationsPhone,
    "investorRelationsEmail": investorRelationsEmail,
    "corporateHeadquarters": corporateHeadquarters,
    "companyLogo": companyLogo.toJson(),
    "companySeal": companySeal,
    "adminEmail": adminEmail,
    "adminNationalId": adminNationalId,
    "adminPhone": adminPhone,
    "adminName": adminName,
    "adminNameAr": adminNameAr,
    "createdAt": createdAt.toIso8601String(),
  };
}

class CompanyLogo {
  int id;
  String fileName;
  bool isPublic;
  String url;

  CompanyLogo({
    required this.id,
    required this.fileName,
    required this.isPublic,
    required this.url,
  });

  factory CompanyLogo.fromJson(Map<String, dynamic> json) => CompanyLogo(
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
