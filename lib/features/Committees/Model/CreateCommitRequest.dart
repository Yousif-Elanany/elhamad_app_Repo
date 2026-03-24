// To parse this JSON data, do
//
//     final createCommitRequest = createCommitRequestFromJson(jsonString);

import 'dart:convert';

CreateCommitRequest createCommitRequestFromJson(String str) => CreateCommitRequest.fromJson(json.decode(str));

String createCommitRequestToJson(CreateCommitRequest data) => json.encode(data.toJson());

class CreateCommitRequest {
  String type;
  DateTime startDate;
  DateTime endDate;
  int membersCount;
  int yearlyMeetingsCount;

  CreateCommitRequest({
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.membersCount,
    required this.yearlyMeetingsCount,
  });

  factory CreateCommitRequest.fromJson(Map<String, dynamic> json) => CreateCommitRequest(
    type: json["type"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    membersCount: json["membersCount"],
    yearlyMeetingsCount: json["yearlyMeetingsCount"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "membersCount": membersCount,
    "yearlyMeetingsCount": yearlyMeetingsCount,
  };
}
