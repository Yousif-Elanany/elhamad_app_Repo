// To parse this JSON data, do
//
//     final taskResponseModel = taskResponseModelFromJson(jsonString);

import 'dart:convert';

TaskResponseModel taskResponseModelFromJson(String str) => TaskResponseModel.fromJson(json.decode(str));

String taskResponseModelToJson(TaskResponseModel data) => json.encode(data.toJson());

class TaskResponseModel {
  List<Item> items;
  int pageNumber;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;

  TaskResponseModel({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) => TaskResponseModel(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    totalCount: json["totalCount"],
    totalPages: json["totalPages"],
    hasPreviousPage: json["hasPreviousPage"],
    hasNextPage: json["hasNextPage"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "totalCount": totalCount,
    "totalPages": totalPages,
    "hasPreviousPage": hasPreviousPage,
    "hasNextPage": hasNextPage,
  };
}

class Item {
  int id;
  String title;
  DateTime createdAt;
  DateTime dueDate;
  List<String> assignedUserNames;
  String status;
  String priority;

  Item({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.dueDate,
    required this.assignedUserNames,
    required this.status,
    required this.priority,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    title: json["title"],
    createdAt: DateTime.parse(json["createdAt"]),
    dueDate: DateTime.parse(json["dueDate"]),
    assignedUserNames: List<String>.from(json["assignedUserNames"].map((x) => x)),
    status: json["status"],
    priority: json["priority"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "createdAt": createdAt.toIso8601String(),
    "dueDate": dueDate.toIso8601String(),
    "assignedUserNames": List<dynamic>.from(assignedUserNames.map((x) => x)),
    "status": status,
    "priority": priority,
  };
}
