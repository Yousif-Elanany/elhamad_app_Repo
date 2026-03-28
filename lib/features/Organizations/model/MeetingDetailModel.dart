class MeetingDetailModel {
  MeetingDetailModel({
    required this.id,
    required this.startTime,
    required this.meetingType,
    required this.procedureType,
    required this.city,
    required this.status,
    required this.link,
    required this.meetingVenue,
    required this.firstQuorumPercentage,
    required this.secondQuorumPercentage,
    required this.secondAttemptStartTime,
    required this.quorumAchievedAt,
    required this.notes,
    required this.createdAt,
    required this.agendaItems,
    required this.invitees,
    required this.shareholders,
    required this.attachments,
    required this.meetingDocuments,
  });

  final int? id;
  final DateTime? startTime;
  final String? meetingType;
  final String? procedureType;
  final String? city;
  final String? status;
  final String? link;
  final String? meetingVenue;
  final int? firstQuorumPercentage;
  final int? secondQuorumPercentage;
  final DateTime? secondAttemptStartTime;
  final DateTime? quorumAchievedAt;
  final String? notes;
  final DateTime? createdAt;
  final List<AgendaItem> agendaItems;
  final List<Invitee> invitees;
  final List<Shareholder> shareholders;
  final List<Attachment> attachments;
  final List<MeetingDocument> meetingDocuments;

  MeetingDetailModel copyWith({
    int? id,
    DateTime? startTime,
    String? meetingType,
    String? procedureType,
    String? city,
    String? status,
    String? link,
    String? meetingVenue,
    int? firstQuorumPercentage,
    int? secondQuorumPercentage,
    DateTime? secondAttemptStartTime,
    DateTime? quorumAchievedAt,
    String? notes,
    DateTime? createdAt,
    List<AgendaItem>? agendaItems,
    List<Invitee>? invitees,
    List<Shareholder>? shareholders,
    List<Attachment>? attachments,
    List<MeetingDocument>? meetingDocuments,
  }) {
    return MeetingDetailModel(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      meetingType: meetingType ?? this.meetingType,
      procedureType: procedureType ?? this.procedureType,
      city: city ?? this.city,
      status: status ?? this.status,
      link: link ?? this.link,
      meetingVenue: meetingVenue ?? this.meetingVenue,
      firstQuorumPercentage: firstQuorumPercentage ?? this.firstQuorumPercentage,
      secondQuorumPercentage: secondQuorumPercentage ?? this.secondQuorumPercentage,
      secondAttemptStartTime: secondAttemptStartTime ?? this.secondAttemptStartTime,
      quorumAchievedAt: quorumAchievedAt ?? this.quorumAchievedAt,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      agendaItems: agendaItems ?? this.agendaItems,
      invitees: invitees ?? this.invitees,
      shareholders: shareholders ?? this.shareholders,
      attachments: attachments ?? this.attachments,
      meetingDocuments: meetingDocuments ?? this.meetingDocuments,
    );
  }

  factory MeetingDetailModel.fromJson(Map<String, dynamic> json){
    return MeetingDetailModel(
      id: json["id"],
      startTime: DateTime.tryParse(json["startTime"] ?? ""),
      meetingType: json["meetingType"],
      procedureType: json["procedureType"],
      city: json["city"],
      status: json["status"],
      link: json["link"],
      meetingVenue: json["meetingVenue"],
      firstQuorumPercentage: json["firstQuorumPercentage"],
      secondQuorumPercentage: json["secondQuorumPercentage"],
      secondAttemptStartTime: DateTime.tryParse(json["secondAttemptStartTime"] ?? ""),
      quorumAchievedAt: DateTime.tryParse(json["quorumAchievedAt"] ?? ""),
      notes: json["notes"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      agendaItems: json["agendaItems"] == null ? [] : List<AgendaItem>.from(json["agendaItems"]!.map((x) => AgendaItem.fromJson(x))),
      invitees: json["invitees"] == null ? [] : List<Invitee>.from(json["invitees"]!.map((x) => Invitee.fromJson(x))),
      shareholders: json["shareholders"] == null ? [] : List<Shareholder>.from(json["shareholders"]!.map((x) => Shareholder.fromJson(x))),
      attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
      meetingDocuments: json["meetingDocuments"] == null ? [] : List<MeetingDocument>.from(json["meetingDocuments"]!.map((x) => MeetingDocument.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "startTime": startTime?.toIso8601String(),
    "meetingType": meetingType,
    "procedureType": procedureType,
    "city": city,
    "status": status,
    "link": link,
    "meetingVenue": meetingVenue,
    "firstQuorumPercentage": firstQuorumPercentage,
    "secondQuorumPercentage": secondQuorumPercentage,
    "secondAttemptStartTime": secondAttemptStartTime?.toIso8601String(),
    "quorumAchievedAt": quorumAchievedAt?.toIso8601String(),
    "notes": notes,
    "createdAt": createdAt?.toIso8601String(),
    "agendaItems": agendaItems.map((x) => x?.toJson()).toList(),
    "invitees": invitees.map((x) => x?.toJson()).toList(),
    "shareholders": shareholders.map((x) => x?.toJson()).toList(),
    "attachments": attachments.map((x) => x?.toJson()).toList(),
    "meetingDocuments": meetingDocuments.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$id, $startTime, $meetingType, $procedureType, $city, $status, $link, $meetingVenue, $firstQuorumPercentage, $secondQuorumPercentage, $secondAttemptStartTime, $quorumAchievedAt, $notes, $createdAt, $agendaItems, $invitees, $shareholders, $attachments, $meetingDocuments, ";
  }
}

class AgendaItem {
  AgendaItem({
    required this.id,
    required this.number,
    required this.text,
    required this.notes,
    required this.votingType,
  });

  final int? id;
  final int? number;
  final String? text;
  final String? notes;
  final String? votingType;

  AgendaItem copyWith({
    int? id,
    int? number,
    String? text,
    String? notes,
    String? votingType,
  }) {
    return AgendaItem(
      id: id ?? this.id,
      number: number ?? this.number,
      text: text ?? this.text,
      notes: notes ?? this.notes,
      votingType: votingType ?? this.votingType,
    );
  }

  factory AgendaItem.fromJson(Map<String, dynamic> json){
    return AgendaItem(
      id: json["id"],
      number: json["number"],
      text: json["text"],
      notes: json["notes"],
      votingType: json["votingType"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "text": text,
    "notes": notes,
    "votingType": votingType,
  };

  @override
  String toString(){
    return "$id, $number, $text, $notes, $votingType, ";
  }
}

class Attachment {
  Attachment({
    required this.id,
    required this.fileName,
    required this.isPublic,
    required this.url,
  });

  final int? id;
  final String? fileName;
  final bool? isPublic;
  final String? url;

  Attachment copyWith({
    int? id,
    String? fileName,
    bool? isPublic,
    String? url,
  }) {
    return Attachment(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      isPublic: isPublic ?? this.isPublic,
      url: url ?? this.url,
    );
  }

  factory Attachment.fromJson(Map<String, dynamic> json){
    return Attachment(
      id: json["id"],
      fileName: json["fileName"],
      isPublic: json["isPublic"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "fileName": fileName,
    "isPublic": isPublic,
    "url": url,
  };

  @override
  String toString(){
    return "$id, $fileName, $isPublic, $url, ";
  }
}

class Invitee {
  Invitee({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.isExternal,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? status;
  final bool? isExternal;

  Invitee copyWith({
    int? id,
    String? name,
    String? email,
    String? status,
    bool? isExternal,
  }) {
    return Invitee(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      status: status ?? this.status,
      isExternal: isExternal ?? this.isExternal,
    );
  }

  factory Invitee.fromJson(Map<String, dynamic> json){
    return Invitee(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      status: json["status"],
      isExternal: json["isExternal"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "status": status,
    "isExternal": isExternal,
  };

  @override
  String toString(){
    return "$id, $name, $email, $status, $isExternal, ";
  }
}

class MeetingDocument {
  MeetingDocument({
    required this.id,
    required this.documentId,
    required this.fileName,
    required this.documentType,
    required this.status,
    required this.failureReason,
  });

  final int? id;
  final int? documentId;
  final String? fileName;
  final String? documentType;
  final String? status;
  final String? failureReason;

  MeetingDocument copyWith({
    int? id,
    int? documentId,
    String? fileName,
    String? documentType,
    String? status,
    String? failureReason,
  }) {
    return MeetingDocument(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      fileName: fileName ?? this.fileName,
      documentType: documentType ?? this.documentType,
      status: status ?? this.status,
      failureReason: failureReason ?? this.failureReason,
    );
  }

  factory MeetingDocument.fromJson(Map<String, dynamic> json){
    return MeetingDocument(
      id: json["id"],
      documentId: json["documentId"],
      fileName: json["fileName"],
      documentType: json["documentType"],
      status: json["status"],
      failureReason: json["failureReason"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "documentId": documentId,
    "fileName": fileName,
    "documentType": documentType,
    "status": status,
    "failureReason": failureReason,
  };

  @override
  String toString(){
    return "$id, $documentId, $fileName, $documentType, $status, $failureReason, ";
  }
}

class Shareholder {
  Shareholder({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.shareCount,
    required this.sharePercentage,
    required this.hasVoted,
  });

  final int? id;
  final String? userId;
  final String? name;
  final String? email;
  final int? shareCount;
  final int? sharePercentage;
  final bool? hasVoted;

  Shareholder copyWith({
    int? id,
    String? userId,
    String? name,
    String? email,
    int? shareCount,
    int? sharePercentage,
    bool? hasVoted,
  }) {
    return Shareholder(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      shareCount: shareCount ?? this.shareCount,
      sharePercentage: sharePercentage ?? this.sharePercentage,
      hasVoted: hasVoted ?? this.hasVoted,
    );
  }

  factory Shareholder.fromJson(Map<String, dynamic> json){
    return Shareholder(
      id: json["id"],
      userId: json["userId"],
      name: json["name"],
      email: json["email"],
      shareCount: json["shareCount"],
      sharePercentage: json["sharePercentage"],
      hasVoted: json["hasVoted"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "name": name,
    "email": email,
    "shareCount": shareCount,
    "sharePercentage": sharePercentage,
    "hasVoted": hasVoted,
  };

  @override
  String toString(){
    return "$id, $userId, $name, $email, $shareCount, $sharePercentage, $hasVoted, ";
  }
}
