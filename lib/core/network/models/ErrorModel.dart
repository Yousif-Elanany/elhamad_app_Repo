// To parse this JSON data, do
//
//     final errorResponseModel = errorResponseModelFromJson(jsonString);

import 'dart:convert';

ErrorResponseModel errorResponseModelFromJson(String str) => ErrorResponseModel.fromJson(json.decode(str));

String errorResponseModelToJson(ErrorResponseModel data) => json.encode(data.toJson());

class ErrorResponseModel {
  String type;
  String title;
  int status;
  String detail;
  String instance;
  String traceId;
  String requestId;
  String code;

  ErrorResponseModel({
    required this.type,
    required this.title,
    required this.status,
    required this.detail,
    required this.instance,
    required this.traceId,
    required this.requestId,
    required this.code,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => ErrorResponseModel(
    type: json["type"],
    title: json["title"],
    status: json["status"],
    detail: json["detail"],
    instance: json["instance"],
    traceId: json["traceId"],
    requestId: json["requestId"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "title": title,
    "status": status,
    "detail": detail,
    "instance": instance,
    "traceId": traceId,
    "requestId": requestId,
    "code": code,
  };
}
