import 'package:flutter/material.dart';

import '../../../../core/widgets/ActionIconButton.dart';

// لو عندك ActionIconButton معرف عندك
// import 'package:your_project/widgets/action_icon_button.dart';

class ManagementWidget extends StatelessWidget {
  final String caseName;
  final String startDate;
  final String endDate;
  final String boardMembers;
  final String activeMembers;
  final String availableSeats;
  final String status; // 1 = نشط, 2 = غير نشط
  final VoidCallback onViewTap;
  final VoidCallback onGroupTap;

  const ManagementWidget({
    Key? key,
    required this.caseName,
    required this.startDate,
    required this.endDate,
    required this.boardMembers,
    required this.activeMembers,
    required this.availableSeats,
    required this.status,
    required this.onViewTap,
    required this.onGroupTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _buildRow("اسم الحالة", Text(caseName)),
          const SizedBox(height: 8),

          _buildRow("تاريخ البداية", Text(startDate)),
          const SizedBox(height: 8),

          _buildRow("تاريخ النهاية", Text(endDate)),
          const SizedBox(height: 8),

          _buildRow("عدد اعضاء مجلس الادارة", Text(boardMembers)),
          const SizedBox(height: 8),

          _buildRow("عدد الأعضاء النشطين", Text(activeMembers)),
          const SizedBox(height: 8),

          _buildRow("الأماكن المتاحة", Text(availableSeats)),
          const SizedBox(height: 8),

          // الحالة كـ Badge
          _buildRow("الحالة", statusWidget(status)),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ActionIconButton(
                  onTap: onViewTap,
                  icon: Icons.remove_red_eye_rounded,
                  iconColor: Colors.green,
                  backgroundColor: Colors.green.withOpacity(.1),
                  borderColor: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: ActionIconButton(
                  onTap: onGroupTap,
                  icon: Icons.group,
                  iconColor: Colors.deepPurple,
                  backgroundColor: Colors.white,
                  borderColor: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, Widget value) {
    return Row(
      children: [
        Text(
          "$title : ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 6),
        value,
      ],
    );
  }

  Widget statusWidget(String status) {
    bool isActive = status == "1";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isActive ? "نشط" : "غير نشط",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}