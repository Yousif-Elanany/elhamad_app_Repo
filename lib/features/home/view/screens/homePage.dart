import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../localization_service.dart';
import '../widgets/appdrawer.dart';

class CompanyHomePage extends StatelessWidget {
  const CompanyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = LocalizationService.getLang() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textDark),
          title: Center(
            child: Column(
              crossAxisAlignment: isArabic
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  "company_name".tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "company_type".tr(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () => Navigator.pushNamed(context, '/notification'),
              ),
            ),
          ],
        ),
        drawer: const Appdrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  "overview".tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStatCard(
                      "upcoming_meetings".tr(),
                      "3",
                      Icons.calendar_month_outlined,
                      Colors.green,
                      isArabic,
                    ),
                    const SizedBox(width: 8),
                    _buildStatCard(
                      "pending_decisions".tr(),
                      "5",
                      Icons.verified_outlined,
                      Colors.orange,
                      isArabic,
                    ),
                    const SizedBox(width: 8),
                    _buildStatCard(
                      "contracts".tr(),
                      "12",
                      Icons.insert_drive_file_outlined,
                      Colors.blue,
                      isArabic,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/meeting'),
                      child: Text(
                        "view_all".tr(),
                        style: const TextStyle(color: Colors.orange, fontSize: 12),
                      ),
                    ),
                    Text(
                      "upcoming_meetings".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                _buildMeetingCard(
                  "board_meeting".tr(),
                  "27 Thu",
                  "09:00 - 09:30",
                  "pending".tr(),
                  isComplete: false,
                  isArabic: isArabic,
                ),
                _buildMeetingCard(
                  "tech_team_meeting".tr(),
                  "28 Fri",
                  "10:30 - 11:00",
                  "pending".tr(),
                  isComplete: false,
                  isArabic: isArabic,
                ),
                _buildMeetingCard(
                  "product_workshop".tr(),
                  "29 Sat",
                  "11:00 - 12:30",
                  "completed".tr(),
                  isComplete: true,
                  isArabic: isArabic,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color iconColor,
      bool isArabic) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Align(
              alignment: isArabic ? Alignment.topRight : Alignment.topLeft,
              child: Icon(
                icon,
                color: iconColor.withOpacity(0.5),
                size: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeetingCard(String title, String date, String time, String status,
      {bool isComplete = false, required bool isArabic}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment:
        isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isComplete ? Colors.green[50] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isComplete ? Colors.green : Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const Icon(Icons.access_time, size: 14, color: Colors.grey),
              const SizedBox(width: 16),
              Text(
                date,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
            ],
          ),
          const Divider(height: 24),
          const Text(
            "https://us04web.zoom.us/...",
            style: TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
