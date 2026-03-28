class MeetingRequestModel {
  MeetingRequestModel({
    required this.startTime,
    required this.meetingType,
    required this.procedureType,
    required this.notes,
    required this.attachmentDocumentIds,
  });

  final String? startTime;
  final String? meetingType;
  final String? procedureType;
  final String? notes;
  final List<int> attachmentDocumentIds;

  MeetingRequestModel copyWith({
    DateTime? startTime,
    String? meetingType,
    String? procedureType,
    String? notes,
    List<int>? attachmentDocumentIds,
  }) {
    return MeetingRequestModel(
      startTime:  this.startTime,
      meetingType: meetingType ?? this.meetingType,
      procedureType: procedureType ?? this.procedureType,
      notes: notes ?? this.notes,
      attachmentDocumentIds: attachmentDocumentIds ?? this.attachmentDocumentIds,
    );
  }

  factory MeetingRequestModel.fromJson(Map<String, dynamic> json){
    return MeetingRequestModel(
      startTime: json["startTime"],
      meetingType: json["meetingType"],
      procedureType: json["procedureType"],
      notes: json["notes"],
      attachmentDocumentIds: json["attachmentDocumentIds"] == null ? [] : List<int>.from(json["attachmentDocumentIds"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "startTime": startTime,
    "meetingType": meetingType,
    "procedureType": procedureType,
    "notes": notes,
    "attachmentDocumentIds": attachmentDocumentIds.map((x) => x).toList(),
  };

  @override
  String toString(){
    return "$startTime, $meetingType, $procedureType, $notes, $attachmentDocumentIds, ";
  }
}
