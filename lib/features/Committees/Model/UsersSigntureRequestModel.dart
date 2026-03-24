
// To parse this JSON data, do
//
//     final usersSigntureRequestModel = usersSigntureRequestModelFromJson(jsonString);

import 'dart:convert';

UsersSigntureRequestModel usersSigntureRequestModelFromJson(String str) => UsersSigntureRequestModel.fromJson(json.decode(str));

String usersSigntureRequestModelToJson(UsersSigntureRequestModel data) => json.encode(data.toJson());

class UsersSigntureRequestModel {
  List<String> userIds;

  UsersSigntureRequestModel({
    required this.userIds,
  });

  factory UsersSigntureRequestModel.fromJson(Map<String, dynamic> json) => UsersSigntureRequestModel(
    userIds: List<String>.from(json["userIds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "userIds": List<dynamic>.from(userIds.map((x) => x)),
  };
}
