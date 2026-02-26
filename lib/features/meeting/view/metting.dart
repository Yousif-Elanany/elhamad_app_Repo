import 'package:flutter/material.dart';

import '../../../localization_service.dart';
// import 'path_to_your_service/localization_service.dart';

class MeetingsPage extends StatelessWidget {
  const MeetingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isAr = LocalizationService.getLang() == 'ar';

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            // التعديل هنا: في العربي السهم يشير لليمين، في الإنجليزي يشير لليسار
            isAr ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "meetings".tr(),
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMeetingCard(
            context: context,
            title: "board_meeting".tr(),
            status: "pending_approval".tr(),
            statusColor: Colors.grey.shade200,
            statusTextColor: Colors.grey.shade700,
            date: isAr ? "27 ${"thursday".tr()}" : "${"thursday".tr()} 27",
            time: "09:00 - 09:30",
            link: "https://us04web.z...",
          ),
          _buildMeetingCard(
            context: context,
            title: "board_meeting".tr(),
            status: "completed".tr(),
            statusColor: const Color(0xFFE8F5E9),
            statusTextColor: const Color(0xFF4CAF50),
            date: isAr ? "31 ${"thursday".tr()}" : "${"thursday".tr()} 31",
            time: "09:00 - 09:30",
            link: "https://us04web.z...",
          ),
          _buildMeetingCard(
            context: context,
            title: "product_workshop".tr(),
            status: "completed".tr(),
            statusColor: const Color(0xFFE8F5E9),
            statusTextColor: const Color(0xFF4CAF50),
            date: isAr ? "29 ${"saturday".tr()}" : "${"saturday".tr()} 29",
            time: "11:00 - 12:30",
            link: "https://us04web.z...",
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingCard({
    required String title,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    required String date,
    required String time,
    required String link,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detailed');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.withOpacity(0.1), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // جعل المحتوى يبدأ من بداية اللغة
          children: [
            // السطر الأول: العنوان والحالة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: statusTextColor, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // السطر الثاني: التاريخ والوقت
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(date, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(width: 15),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(time, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),

            const SizedBox(height: 12),

            // رابط الاجتماع
            Row(
              children: [
                const Icon(Icons.link, size: 18, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    link,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                        decoration: TextDecoration.underline
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.copy_outlined, size: 18, color: Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}