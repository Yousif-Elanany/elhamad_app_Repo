import 'dart:convert';

List<GetCommitMembersResponse> getCommitMembersResponseFromJson(String str) =>
    List<GetCommitMembersResponse>.from(
      json.decode(str).map((x) => GetCommitMembersResponse.fromJson(x)),
    );

String getCommitMembersResponseToJson(List<GetCommitMembersResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCommitMembersResponse {
  int profileId;
  String userId;
  String name;
  String phoneNumber;
  String nationalId;
  String email;
  String jobTitle;
  DateTime? startDate;
  DateTime? endDate;
  String? endReason;
  bool isActive;
  String signatureStatus;

  GetCommitMembersResponse({
    required this.profileId,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.nationalId,
    required this.email,
    required this.jobTitle,
    this.startDate,
    this.endDate,
    this.endReason,
    required this.isActive,
    required this.signatureStatus,
  });

  factory GetCommitMembersResponse.fromJson(Map<String, dynamic> json) =>
      GetCommitMembersResponse(
        profileId: json["profileId"] ?? 0,
        userId: json["userId"] ?? "",
        name: json["name"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        nationalId: json["nationalId"] ?? "",
        email: json["email"] ?? "",
        jobTitle: json["jobTitle"] ?? "",

        /// ✅ Safe Date Parsing
        startDate: _parseDate(json["startDate"]),
        endDate: _parseDate(json["endDate"]),

        endReason: json["endReason"],
        isActive: json["isActive"] ?? false,
        signatureStatus: json["signatureStatus"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "profileId": profileId,
    "userId": userId,
    "name": name,
    "phoneNumber": phoneNumber,
    "nationalId": nationalId,
    "email": email,
    "jobTitle": jobTitle,

    /// ✅ Safe convert
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),

    "endReason": endReason,
    "isActive": isActive,
    "signatureStatus": signatureStatus,
  };

  /// 🔥 Helper Method
  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }
}
