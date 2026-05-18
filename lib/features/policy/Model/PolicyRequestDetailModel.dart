// To parse this JSON data, do
//
//     final getPolicyRequestDetailModel = getPolicyRequestDetailModelFromJson(jsonString);

import 'dart:convert';

GetPolicyRequestDetailModel getPolicyRequestDetailModelFromJson(String str) =>
    GetPolicyRequestDetailModel.fromJson(json.decode(str));

String getPolicyRequestDetailModelToJson(GetPolicyRequestDetailModel data) =>
    json.encode(data.toJson());

class GetPolicyRequestDetailModel {
  int id;
  String title;
  String notes;
  String requestedById;
  String requestedByName;
  String companyId;
  String companyName;
  String status;
  DateTime statusUpdatedAt;
  DateTime createdAt;
  dynamic rejectionReason;
  dynamic rejectedAt;

  GetPolicyRequestDetailModel({
    required this.id,
    required this.title,
    required this.notes,
    required this.requestedById,
    required this.requestedByName,
    required this.companyId,
    required this.companyName,
    required this.status,
    required this.statusUpdatedAt,
    required this.createdAt,
    required this.rejectionReason,
    required this.rejectedAt,
  });

  factory GetPolicyRequestDetailModel.fromJson(Map<String, dynamic> json) =>
      GetPolicyRequestDetailModel(
        id: json["id"],
        title: json["title"],
        notes: json["notes"],
        requestedById: json["requestedById"],
        requestedByName: json["requestedByName"],
        companyId: json["companyId"],
        companyName: json["companyName"],
        status: json["status"],
        statusUpdatedAt: DateTime.parse(json["statusUpdatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        rejectionReason: json["rejectionReason"] ?? "",
        rejectedAt: json["rejectedAt"] ?? "",
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "title": title,
        "notes": notes,
        "requestedById": requestedById,
        "requestedByName": requestedByName,
        "companyId": companyId,
        "companyName": companyName,
        "status": status,
        "statusUpdatedAt": statusUpdatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "rejectionReason": rejectionReason,
        "rejectedAt": rejectedAt,
      };
}
