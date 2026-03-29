// To parse this JSON data, do
//
//     final boardDetailModel = boardDetailModelFromJson(jsonString);

import 'dart:convert';

BoardDetailModel boardDetailModelFromJson(String str) => BoardDetailModel.fromJson(json.decode(str));

String boardDetailModelToJson(BoardDetailModel data) => json.encode(data.toJson());

class BoardDetailModel {
  int id;
  String companyId;
  String startDate;
  String endDate;
  int membersCount;
  int activeMembersCount;
  int openPositionCount;
  bool isActive;
  DateTime createdAt;

  BoardDetailModel({
    required this.id,
    required this.companyId,
    required this.startDate,
    required this.endDate,
    required this.membersCount,
    required this.activeMembersCount,
    required this.openPositionCount,
    required this.isActive,
    required this.createdAt,
  });

  factory BoardDetailModel.fromJson(Map<String, dynamic> json) => BoardDetailModel(
    id: json["id"],
    companyId: json["companyId"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    membersCount: json["membersCount"],
    activeMembersCount: json["activeMembersCount"],
    openPositionCount: json["openPositionCount"],
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyId": companyId,
    "startDate":  startDate,
    "endDate": endDate,
    "membersCount": membersCount,
    "activeMembersCount": activeMembersCount,
    "openPositionCount": openPositionCount,
    "isActive": isActive,
    "createdAt": createdAt.toIso8601String(),
  };
}
