import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../localization_service.dart';
// تأكد من عمل استيراد للخدمة الخاصة بك
// import 'path_to_your_service/localization_service.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // 0 تعني غير مقروء، 1 تعني مؤرشف
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    // تحديد اتجاه الأيقونات بناءً على اللغة
    final bool isAr = LocalizationService.getLang() == 'ar';

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          // أيقونة الرجوع تنعكس حسب اللغة
          icon: Icon(
            isAr ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "notifications".tr(),
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  // ترتيب التابات منطقياً (الأول دائماً هو الافتراضي)
                  _buildTabItem("unread".tr(), _selectedTabIndex == 0, 0),
                  _buildTabItem("archived".tr(), _selectedTabIndex == 1, 1),
                ],
              ),
            ),
          ),

          Expanded(
            child: IndexedStack(
              index: _selectedTabIndex,
              children: [
                _buildUnreadSection(),
                _buildArchivedSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, bool isActive, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isActive
                ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]
                : [],
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  // --- محتوى صفحة "غير مقروء" ---
  Widget _buildUnreadSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle("today".tr()),
        _buildNotificationCard(
          title: "meeting_reminder_title".tr(),
          desc: "meeting_reminder_desc".tr(),
          time: "time_5m".tr(),
          icon: Icons.notifications_none_outlined,
          isUnread: true,
        ),
        _buildNotificationCard(
          title: "new_attachment_title".tr(),
          desc: "new_attachment_desc".tr(),
          time: "time_2h".tr(),
          icon: Icons.description_outlined,
          isUnread: true,
        ),
        const SizedBox(height: 10),
        _buildSectionTitle("this_week".tr()),
        _buildNotificationCard(
          title: "new_attachment_title".tr(),
          desc: "new_attachment_desc".tr(),
          time: "time_2h".tr(),
          icon: Icons.description_outlined,
          isUnread: true,
        ),_buildNotificationCard(
          title: "new_attachment_title".tr(),
          desc: "new_attachment_desc".tr(),
          time: "time_2h".tr(),
          icon: Icons.description_outlined,
          isUnread: true,
        ),_buildNotificationCard(
          title: "new_attachment_title".tr(),
          desc: "new_attachment_desc".tr(),
          time: "time_2h".tr(),
          icon: Icons.description_outlined,
          isUnread: true,
        ),_buildNotificationCard(
          title: "new_attachment_title".tr(),
          desc: "new_attachment_desc".tr(),
          time: "time_2h".tr(),
          icon: Icons.description_outlined,
          isUnread: true,
        ),
      ],
    );
  }

  // --- محتوى صفحة "مؤرشف" ---
  Widget _buildArchivedSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle("last_week".tr()),
        _buildNotificationCard(
          title: "login_issue_title".tr(),
          desc: "login_issue_desc".tr(),
          time: "time_3w".tr(),
          icon: Icons.check_circle_outline,
          isUnread: false,
        ),
        _buildSectionTitle("last_week".tr()),

        _buildNotificationCard(
          title: "login_issue_title".tr(),
          desc: "login_issue_desc".tr(),
          time: "time_3w".tr(),
          icon: Icons.check_circle_outline,
          isUnread: false,
        ), _buildNotificationCard(
          title: "login_issue_title".tr(),
          desc: "login_issue_desc".tr(),
          time: "time_3w".tr(),
          icon: Icons.check_circle_outline,
          isUnread: false,
        ), _buildNotificationCard(
          title: "login_issue_title".tr(),
          desc: "login_issue_desc".tr(),
          time: "time_3w".tr(),
          icon: Icons.check_circle_outline,
          isUnread: false,
        ), _buildNotificationCard(
          title: "login_issue_title".tr(),
          desc: "login_issue_desc".tr(),
          time: "time_3w".tr(),
          icon: Icons.check_circle_outline,
          isUnread: false,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Text(
        title,
        style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
        // تم تغيير textAlign ليعمل تلقائياً مع اتجاه اللغة
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String desc,
    required String time,
    required IconData icon,
    bool isUnread = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xFFFFFDE7) : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: isUnread
            ? Border.all(color: AppColors.primary.withOpacity(0.2))
            : Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        // تم التغيير لـ start ليدعم العربي والإنجليزي
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isUnread ? AppColors.primary : AppColors.textGrey,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              if (isUnread)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            // textAlign يتبع لغة التطبيق
            textAlign: TextAlign.start,
            style: TextStyle(
              color: isUnread ? AppColors.textDark : AppColors.textGrey,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            time,
            style: const TextStyle(color: AppColors.textGrey, fontSize: 10),
          ),
        ],
      ),
    );
  }
}