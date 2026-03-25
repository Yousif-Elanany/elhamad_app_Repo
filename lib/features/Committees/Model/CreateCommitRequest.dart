// To parse this JSON data, do
//
//     final createCommitRequest = createCommitRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

CreateCommitRequest createCommitRequestFromJson(String str) => CreateCommitRequest.fromJson(json.decode(str));

String createCommitRequestToJson(CreateCommitRequest data) => json.encode(data.toJson());

class CreateCommitRequest {
  String type;
  String startDate;
  String endDate;
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
    startDate: json["startDate"],
    endDate: json["endDate"],
    membersCount: json["membersCount"],
    yearlyMeetingsCount: json["yearlyMeetingsCount"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "startDate": startDate,
    "endDate": endDate,
    "membersCount": membersCount,
    "yearlyMeetingsCount": yearlyMeetingsCount,
  };
}
