// To parse this JSON data, do
//
//     final editMemberOfBoardModel = editMemberOfBoardModelFromJson(jsonString);

import 'dart:convert';

EditMemberOfBoardModel editMemberOfBoardModelFromJson(String str) => EditMemberOfBoardModel.fromJson(json.decode(str));

String editMemberOfBoardModelToJson(EditMemberOfBoardModel data) => json.encode(data.toJson());

class EditMemberOfBoardModel {
  String jobTitle;
  String membershipType;

  EditMemberOfBoardModel({
    required this.jobTitle,
    required this.membershipType,
  });

  factory EditMemberOfBoardModel.fromJson(Map<String, dynamic> json) => EditMemberOfBoardModel(
    jobTitle: json["jobTitle"],
    membershipType: json["membershipType"],
  );

  Map<String, dynamic> toJson() => {
    "jobTitle": jobTitle,
    "membershipType": membershipType,
  };
}
