class EditMeetingRequestModel {
  EditMeetingRequestModel({
    required this.startTime,
  });

  final DateTime? startTime;

  EditMeetingRequestModel copyWith({
    DateTime? startTime,
  }) {
    return EditMeetingRequestModel(
      startTime: startTime ?? this.startTime,
    );
  }

  factory EditMeetingRequestModel.fromJson(Map<String, dynamic> json){
    return EditMeetingRequestModel(
      startTime: DateTime.tryParse(json["startTime"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "startTime": startTime?.toIso8601String(),
  };

  @override
  String toString(){
    return "$startTime, ";
  }
}
