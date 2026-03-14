// To parse this JSON data, do
//
//     final aboutUserResponseModel = aboutUserResponseModelFromJson(jsonString);

import 'dart:convert';

AboutUserResponseModel aboutUserResponseModelFromJson(String str) => AboutUserResponseModel.fromJson(json.decode(str));

String aboutUserResponseModelToJson(AboutUserResponseModel data) => json.encode(data.toJson());

class AboutUserResponseModel {
  String userScope;
  String userRoleType;
  String userId;
  String username;
  String email;
  List<String> roles;
  List<dynamic> permissions;
  String companyId;
  String companyType;
  List<String> enabledFeatures;

  AboutUserResponseModel({
    required this.userScope,
    required this.userRoleType,
    required this.userId,
    required this.username,
    required this.email,
    required this.roles,
    required this.permissions,
    required this.companyId,
    required this.companyType,
    required this.enabledFeatures,
  });

  factory AboutUserResponseModel.fromJson(Map<String, dynamic> json) => AboutUserResponseModel(
    userScope: json["userScope"],
    userRoleType: json["userRoleType"],
    userId: json["userId"],
    username: json["username"],
    email: json["email"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
    companyId: json["companyId"],
    companyType: json["companyType"],
    enabledFeatures: List<String>.from(json["enabledFeatures"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "userScope": userScope,
    "userRoleType": userRoleType,
    "userId": userId,
    "username": username,
    "email": email,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
    "companyId": companyId,
    "companyType": companyType,
    "enabledFeatures": List<dynamic>.from(enabledFeatures.map((x) => x)),
  };
}
