// To parse this JSON data, do
//
//     final createModelRequestModel = createModelRequestModelFromJson(jsonString);

import 'dart:convert';

CreateModelRequestModel createModelRequestModelFromJson(String str) =>
    CreateModelRequestModel.fromJson(json.decode(str));

String createModelRequestModelToJson(CreateModelRequestModel data) =>
    json.encode(data.toJson());

class CreateModelRequestModel {
  String title;
  String notes;

  CreateModelRequestModel({
    required this.title,
    required this.notes,
  });

  factory CreateModelRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateModelRequestModel(
        title: json["title"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() =>
      {
        "title": title,
        "notes": notes,
      };
}
