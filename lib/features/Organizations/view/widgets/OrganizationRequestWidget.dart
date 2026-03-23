import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/ActionIconButton.dart';

// لو عندك ActionIconButton معرف عندك
// import 'package:your_project/widgets/action_icon_button.dart';

class OrganizationRequestWidget extends StatelessWidget {
  final String caseName;
  final String startDate;
  final String Time;
  final String boardMembers;
  final String activeMembers;
  final String availableSeats;
  final String status; // 1 = نشط, 2 = غير نشط
  final VoidCallback onViewTap;
  final VoidCallback onGroupTap;

  const OrganizationRequestWidget({
    Key? key,
    required this.caseName,
    required this.startDate,
    required this.Time,
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

          _buildRow("تاريخ", Text(startDate)),
          const SizedBox(height: 8),

          _buildRow("التوقيت", Text(Time)),
          const SizedBox(height: 8),

          _buildRow("الحالة", Text(boardMembers)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ActionIconButton(
                  onTap: onViewTap,
                  icon: Icons.remove_red_eye_rounded,
                  iconColor: AppColors.primaryOlive,
                  backgroundColor: AppColors.primaryOlive.withOpacity(.1),
                  borderColor: AppColors.primaryOlive,
                ),
              ),
              //     const SizedBox(width: 12),

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