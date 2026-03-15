

import 'dart:convert';

List<SubscriptionsResponseModel> subscriptionsResponseModelFromJson(String str) => List<SubscriptionsResponseModel>.from(json.decode(str).map((x) => SubscriptionsResponseModel.fromJson(x)));

String subscriptionsResponseModelToJson(List<SubscriptionsResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscriptionsResponseModel {
  String featureCode;
  String featureName;
  int availableCount;
  int usageCount;
  String? lastUsedAt;

  SubscriptionsResponseModel({
    required this.featureCode,
    required this.featureName,
    required this.availableCount,
    required this.usageCount,
     this.lastUsedAt,
  });

  factory SubscriptionsResponseModel.fromJson(Map<String, dynamic> json) => SubscriptionsResponseModel(
    featureCode: json["featureCode"],
    featureName: json["featureName"],
    availableCount: json["availableCount"],
    usageCount: json["usageCount"],
    lastUsedAt: json["lastUsedAt"]??"",
  );

  Map<String, dynamic> toJson() => {
    "featureCode": featureCode,
    "featureName": featureName,
    "availableCount": availableCount,
    "usageCount": usageCount,
    "lastUsedAt": lastUsedAt,
  };
}
