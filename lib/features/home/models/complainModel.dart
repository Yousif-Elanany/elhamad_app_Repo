class ComplaintModel {
  final int id;
  final String complainant;
  final String content;
  final String date;
  final String type;
  final String status;

  ComplaintModel({
    required this.id,
    required this.complainant,
    required this.content,
    required this.date,
    required this.type,
    required this.status,
  });
}