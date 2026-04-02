// To parse this JSON data, do
//
//     final editExecutiveModel = editExecutiveModelFromJson(jsonString);

import 'dart:convert';

EditExecutiveModel editExecutiveModelFromJson(String str) =>
    EditExecutiveModel.fromJson(json.decode(str));

String editExecutiveModelToJson(EditExecutiveModel data) =>
    json.encode(data.toJson());

class EditExecutiveModel {
  String jobTitle;
  bool isActive;

  EditExecutiveModel({required this.jobTitle, required this.isActive});

  factory EditExecutiveModel.fromJson(Map<String, dynamic> json) =>
      EditExecutiveModel(
        jobTitle: json["jobTitle"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {"jobTitle": jobTitle, "isActive": isActive};
}
