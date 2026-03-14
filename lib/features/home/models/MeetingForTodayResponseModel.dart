// To parse this JSON data, do
//
//     final meetingForTodayReasponseModel = meetingForTodayReasponseModelFromJson(jsonString);

import 'dart:convert';

MeetingForTodayReasponseModel meetingForTodayReasponseModelFromJson(String str) => MeetingForTodayReasponseModel.fromJson(json.decode(str));

String meetingForTodayReasponseModelToJson(MeetingForTodayReasponseModel data) => json.encode(data.toJson());

class MeetingForTodayReasponseModel {
  int totalCount;
  List<dynamic> meetings;

  MeetingForTodayReasponseModel({
    required this.totalCount,
    required this.meetings,
  });

  factory MeetingForTodayReasponseModel.fromJson(Map<String, dynamic> json) => MeetingForTodayReasponseModel(
    totalCount: json["totalCount"],
    meetings: List<dynamic>.from(json["meetings"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "meetings": List<dynamic>.from(meetings.map((x) => x)),
  };
}
