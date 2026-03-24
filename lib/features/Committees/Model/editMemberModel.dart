// To parse this JSON data, do
//
//     final editMemberModel = editMemberModelFromJson(jsonString);

import 'dart:convert';

EditMemberModel editMemberModelFromJson(String str) => EditMemberModel.fromJson(json.decode(str));

String editMemberModelToJson(EditMemberModel data) => json.encode(data.toJson());

class EditMemberModel {
  String jobTitle;
  DateTime startDate;

  EditMemberModel({
    required this.jobTitle,
    required this.startDate,
  });

  factory EditMemberModel.fromJson(Map<String, dynamic> json) => EditMemberModel(
    jobTitle: json["jobTitle"],
    startDate: DateTime.parse(json["startDate"]),
  );

  Map<String, dynamic> toJson() => {
    "jobTitle": jobTitle,
    "startDate": startDate.toIso8601String(),
  };
}
