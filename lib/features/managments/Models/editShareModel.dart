// To parse this JSON data, do
//
//     final editShareHolderRequestModel = editShareHolderRequestModelFromJson(jsonString);

import 'dart:convert';

EditShareHolderRequestModel editShareHolderRequestModelFromJson(String str) =>
    EditShareHolderRequestModel.fromJson(json.decode(str));

String editShareHolderRequestModelToJson(EditShareHolderRequestModel data) =>
    json.encode(data.toJson());

class EditShareHolderRequestModel {
  int sharesOwned;
  DateTime shareAcquisitionDate;
  String guardianUserId;

  EditShareHolderRequestModel({
    required this.sharesOwned,
    required this.shareAcquisitionDate,
    required this.guardianUserId,
  });

  factory EditShareHolderRequestModel.fromJson(Map<String, dynamic> json) =>
      EditShareHolderRequestModel(
        sharesOwned: json["sharesOwned"],
        shareAcquisitionDate: DateTime.parse(json["shareAcquisitionDate"]),
        guardianUserId: json["guardianUserId"],
      );

  Map<String, dynamic> toJson() => {
    "sharesOwned": sharesOwned,
    "shareAcquisitionDate": shareAcquisitionDate.toIso8601String(),
    "guardianUserId": guardianUserId,
  };
}
