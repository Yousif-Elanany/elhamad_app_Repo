// To parse this JSON data, do
//
//     final massageDetailModel = massageDetailModelFromJson(jsonString);

import 'dart:convert';

MassageDetailModel massageDetailModelFromJson(String str) =>
    MassageDetailModel.fromJson(json.decode(str));

String massageDetailModelToJson(MassageDetailModel data) =>
    json.encode(data.toJson());

class MassageDetailModel {
  int id;
  String companyId;
  String title;
  String body;
  List<String> channels;
  String status;
  String senderName;
  DateTime sentAt;
  int totalRecipients;
  int emailSuccessCount;
  int smsSuccessCount;
  int inAppSuccessCount;
  int failedCount;
  DateTime createdAt;
  List<Recipient> recipients;

  MassageDetailModel({
    required this.id,
    required this.companyId,
    required this.title,
    required this.body,
    required this.channels,
    required this.status,
    required this.senderName,
    required this.sentAt,
    required this.totalRecipients,
    required this.emailSuccessCount,
    required this.smsSuccessCount,
    required this.inAppSuccessCount,
    required this.failedCount,
    required this.createdAt,
    required this.recipients,
  });

  factory MassageDetailModel.fromJson(Map<String, dynamic> json) =>
      MassageDetailModel(
        id: json["id"],
        companyId: json["companyId"],
        title: json["title"],
        body: json["body"],
        channels: List<String>.from(json["channels"].map((x) => x)),
        status: json["status"],
        senderName: json["senderName"],
        sentAt: DateTime.parse(json["sentAt"]),
        totalRecipients: json["totalRecipients"],
        emailSuccessCount: json["emailSuccessCount"],
        smsSuccessCount: json["smsSuccessCount"],
        inAppSuccessCount: json["inAppSuccessCount"],
        failedCount: json["failedCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        recipients: List<Recipient>.from(
            json["recipients"].map((x) => Recipient.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "companyId": companyId,
        "title": title,
        "body": body,
        "channels": List<dynamic>.from(channels.map((x) => x)),
        "status": status,
        "senderName": senderName,
        "sentAt": sentAt.toIso8601String(),
        "totalRecipients": totalRecipients,
        "emailSuccessCount": emailSuccessCount,
        "smsSuccessCount": smsSuccessCount,
        "inAppSuccessCount": inAppSuccessCount,
        "failedCount": failedCount,
        "createdAt": createdAt.toIso8601String(),
        "recipients": List<dynamic>.from(recipients.map((x) => x.toJson())),
      };
}

class Recipient {
  String userId;
  String name;
  List<Channel> channels;

  Recipient({
    required this.userId,
    required this.name,
    required this.channels,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) =>
      Recipient(
        userId: json["userId"],
        name: json["name"],
        channels: List<Channel>.from(
            json["channels"].map((x) => Channel.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "userId": userId,
        "name": name,
        "channels": List<dynamic>.from(channels.map((x) => x.toJson())),
      };
}

class Channel {
  String channel;
  bool sent;

  Channel({
    required this.channel,
    required this.sent,
  });

  factory Channel.fromJson(Map<String, dynamic> json) =>
      Channel(
        channel: json["channel"],
        sent: json["sent"],
      );

  Map<String, dynamic> toJson() =>
      {
        "channel": channel,
        "sent": sent,
      };
}
