import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/chatDialog.dart';

class ComplaintCard extends StatelessWidget {
  final int index;
  final String complainant;
  final String content;
  final String date;
  final String type;
  final String status;

  const ComplaintCard({
    super.key,
    required this.index,
    required this.complainant,
    required this.content,
    required this.date,
    required this.type,
    required this.status,
  });

    Color _statusColor() {
      switch (status) {
        case "جديد":
          return Colors.blue;
        case "قديم":
          return Colors.green;
        case "مرفوض":
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "# : $index",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor().withOpacity(.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: _statusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            _buildRow("مقدم الشكوى", complainant),
            _buildRow("مضمون الشكوى", content),
            _buildRow("تاريخ الشكوى", date),
            _buildRow("النوع", type),

            const SizedBox(height: 12),

            /// الإجراءات
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => ComplaintDetailsDialog.show(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOlive.withOpacity(.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primaryOlive,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children:  [
                      Icon(
                        Icons.remove_red_eye_rounded,
                        size: 18,
                        color: AppColors.primaryOlive,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: "$title : ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  void _showActionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("الإجراءات"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("قبول الشكوى"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("رفض الشكوى"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("تحت المراجعة"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}