// To parse this JSON data, do
//
//     final createBoardRequestModel = createBoardRequestModelFromJson(jsonString);

import 'dart:convert';

CreateBoardRequestModel createBoardRequestModelFromJson(String str) => CreateBoardRequestModel.fromJson(json.decode(str));

String createBoardRequestModelToJson(CreateBoardRequestModel data) => json.encode(data.toJson());

class CreateBoardRequestModel {
  DateTime startDate;
  DateTime endDate;
  int membersCount;
  int vacantSeats;

  CreateBoardRequestModel({
    required this.startDate,
    required this.endDate,
    required this.membersCount,
    required this.vacantSeats,
  });

  factory CreateBoardRequestModel.fromJson(Map<String, dynamic> json) => CreateBoardRequestModel(
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    membersCount: json["membersCount"],
    vacantSeats: json["vacantSeats"],
  );

  Map<String, dynamic> toJson() => {
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "membersCount": membersCount,
    "vacantSeats": vacantSeats,
  };
}
