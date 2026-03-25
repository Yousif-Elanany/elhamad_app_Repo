import 'package:flutter/material.dart';

import '../Model/CreateCommitRequest.dart';

void showCommitteeDetailsDialog(CreateCommitRequest committee    ,BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 520,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Text("تفاصيل اللجنة",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text("نشط",
                        style: TextStyle(fontSize: 12, color: Colors.green.shade700)),
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text("بيانات اللجنة",
                        style: TextStyle(fontSize: 13, color: Colors.grey)),
                  ),
                  const SizedBox(height: 8),

                  // Data table
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _detailRow("نوع اللجنة", committee.type),
                        _detailRow("تاريخ البداية", committee.startDate),
                        _detailRow("تاريخ النهاية", committee.endDate),
                        _detailRow("عدد الأعضاء", "${committee.membersCount}"),
                        _detailRow("عدد الاجتماعات في السنة",
                            "${committee.yearlyMeetingsCount}", isLast: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _detailRow(String label, String value, {bool isLast = false}) {
  return Container(
    decoration: BoxDecoration(
      border: isLast ? null : Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),

      ],
    ),
  );
}