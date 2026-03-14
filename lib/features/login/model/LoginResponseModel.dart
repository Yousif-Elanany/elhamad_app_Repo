// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  String userId;
  String username;
  String email;
  List<String> roles;
  List<dynamic> permissions;
  String accessToken;
  String refreshToken;

  LoginResponseModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.roles,
    required this.permissions,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    userId: json["userId"],
    username: json["username"],
    email: json["email"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
    "email": email,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
