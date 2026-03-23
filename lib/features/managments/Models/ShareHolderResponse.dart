// To parse this JSON data, do
//
//     final shareHoldersResponseModel = shareHoldersResponseModelFromJson(jsonString);

import 'dart:convert';

ShareHoldersResponseModel shareHoldersResponseModelFromJson(String str) => ShareHoldersResponseModel.fromJson(json.decode(str));

String shareHoldersResponseModelToJson(ShareHoldersResponseModel data) => json.encode(data.toJson());

class ShareHoldersResponseModel {
  List<dynamic> items;
  int pageNumber;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;

  ShareHoldersResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory ShareHoldersResponseModel.fromJson(Map<String, dynamic> json) => ShareHoldersResponseModel(
    items: List<dynamic>.from(json["items"].map((x) => x)),
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    totalCount: json["totalCount"],
    totalPages: json["totalPages"],
    hasPreviousPage: json["hasPreviousPage"],
    hasNextPage: json["hasNextPage"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x)),
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "totalCount": totalCount,
    "totalPages": totalPages,
    "hasPreviousPage": hasPreviousPage,
    "hasNextPage": hasNextPage,
  };
}
