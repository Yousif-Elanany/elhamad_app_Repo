// To parse this JSON data, do
//
//     final endMemberMemberShipModel = endMemberMemberShipModelFromJson(jsonString);

import 'dart:convert';

EndMemberMemberShipModel endMemberMemberShipModelFromJson(String str) => EndMemberMemberShipModel.fromJson(json.decode(str));

String endMemberMemberShipModelToJson(EndMemberMemberShipModel data) => json.encode(data.toJson());

class EndMemberMemberShipModel {
  DateTime endDate;
  String endReason;

  EndMemberMemberShipModel({
    required this.endDate,
    required this.endReason,
  });

  factory EndMemberMemberShipModel.fromJson(Map<String, dynamic> json) => EndMemberMemberShipModel(
    endDate: DateTime.parse(json["endDate"]),
    endReason: json["endReason"],
  );

  Map<String, dynamic> toJson() => {
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "endReason": endReason,
  };
}
