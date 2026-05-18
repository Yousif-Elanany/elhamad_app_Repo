// To parse this JSON data, do
//
//     final createMassageModel = createMassageModelFromJson(jsonString);

import 'dart:convert';

CreateMassageModel createMassageModelFromJson(String str) =>
    CreateMassageModel.fromJson(json.decode(str));

String createMassageModelToJson(CreateMassageModel data) =>
    json.encode(data.toJson());

class CreateMassageModel {
  String title;
  String body;
  List<String> recipientIds;
  List<String> channels;

  CreateMassageModel({
    required this.title,
    required this.body,
    required this.recipientIds,
    required this.channels,
  });

  factory CreateMassageModel.fromJson(Map<String, dynamic> json) =>
      CreateMassageModel(
        title: json["title"],
        body: json["body"],
        recipientIds: List<String>.from(json["recipientIds"].map((x) => x)),
        channels: List<String>.from(json["channels"].map((x) => x)),
      );

  Map<String, dynamic> toJson() =>
      {
        "title": title,
        "body": body,
        "recipientIds": List<dynamic>.from(recipientIds.map((x) => x)),
        "channels": List<dynamic>.from(channels.map((x) => x)),
      };
}
