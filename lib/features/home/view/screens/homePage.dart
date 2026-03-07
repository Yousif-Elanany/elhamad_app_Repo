import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../localization_service.dart';
import '../../../drawer/appdrawer.dart';

class CompanyHomePage extends StatefulWidget {
  const CompanyHomePage({super.key});

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  List<RatioItem> ratios = [
    RatioItem(
      title: 'توثيق العقود',
      total: 44,
      used: 0,
      barColor: AppColors.primaryOlive,
    ),
    RatioItem(
      title: 'إرسال رسالة بريد إلكتروني',
      total: 33,
      used: 0,
      barColor: AppColors.primaryOlive,
    ),
    RatioItem(
      title: 'اجتماع لجنة',
      total: 12,
      used: 0,
      barColor: AppColors.primaryOlive,
    ),
    RatioItem(
      title: 'إرسال رسالة بريد إلكتروني',
      total: 22,
      used: 0,
      barColor: AppColors.primaryOlive,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final isArabic = LocalizationService.getLang() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textDark),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

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
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
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
              crossAxisAlignment: isArabic
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Text(
                //   "overview".tr(),
                //   style: const TextStyle(fontWeight: FontWeight.bold),
                // ),
                const SizedBox(height: 12),
                // Row(
                //   children: [
                //     _buildStatCard(
                //       "upcoming_meetings".tr(),
                //       "3",
                //       Icons.calendar_month_outlined,
                //       Colors.green,
                //       isArabic,
                //     ),
                //     const SizedBox(width: 8),
                //     _buildStatCard(
                //       "pending_decisions".tr(),
                //       "5",
                //       Icons.verified_outlined,
                //       Colors.orange,
                //       isArabic,
                //     ),
                //     const SizedBox(width: 8),
                //     _buildStatCard(
                //       "contracts".tr(),
                //       "12",
                //       Icons.insert_drive_file_outlined,
                //       Colors.blue,
                //       isArabic,
                //     ),
                //   ],
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(
                      0.1,
                    ), // غيّر اللون حسب الحاجة
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'ملخص الاستخدام والاستحقاق',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryOlive,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                ...ratios.map(
                  (r) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _RatioCard(item: r),
                  ),
                ),
                const SizedBox(height: 8),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(
                      0.1,
                    ), // غيّر اللون حسب الحاجة
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'معلومات الشركة:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryOlive,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _CompanyInfoGrid(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "upcoming_meetings".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryOlive.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero, // علشان ما يكبرش الكونتينر
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/meeting'),
                        child: Text(
                          "view_all".tr(),
                          style: TextStyle(
                            color: AppColors.primaryOlive,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),

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

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color iconColor,
    bool isArabic,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: isArabic
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Align(
              alignment: isArabic ? Alignment.topRight : Alignment.topLeft,
              child: Icon(icon, color: iconColor.withOpacity(0.5), size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeetingCard(
      String title,
      String date,
      String time,
      String status, {
        bool isComplete = false,
        required bool isArabic,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Container( // الكونتينر اللي ضفته
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color:
                    isComplete ? Colors.green[50] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color:
                      isComplete ? Colors.green : Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  time,
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 12),
                ),
                const Icon(Icons.access_time,
                    size: 14, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  date,
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 12),
                ),
                const Icon(Icons.calendar_today,
                    size: 14, color: Colors.grey),
              ],
            ),
            const Divider(height: 24),
            const Text(
              "https://us04web.zoom.us/...",
              style: TextStyle(
                  color: Colors.blue, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
  }
class RatioItem {
  final String title;
  final int total;
  final int used;
  final Color barColor;

  const RatioItem({
    required this.title,
    required this.total,
    required this.used,
    required this.barColor,
  });

  double get percent => total == 0 ? 0 : used / total;
}

// ─── Ratio Card ─────────────────────────────────────────────────
class _RatioCard extends StatelessWidget {
  final RatioItem item;
  const _RatioCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${item.total} / ${item.used}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: item.percent,
              minHeight: 7,
              backgroundColor: AppColors.primary.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(item.barColor),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${(item.percent * 100).toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 11, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _CompanyInfoGrid extends StatelessWidget {
  const _CompanyInfoGrid();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _CompanyCard(
            label: 'رأس المال',
            value: '50,000,000',
            sub: 'الريال السعودي',
            showCurrency: true,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: _CompanyCard(
            label: 'عدد الأسهم',
            value: '500,000',
            sub: 'سهم مُصدَر',
            showCurrency: false,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: _CompanyCard(
            label: 'القيمة الرسمية للسهم',
            value: '100',
            sub: 'لكل سهم',
            showCurrency: true,
          ),
        ),
      ],
    );
  }
}
// class _Sidebar extends StatelessWidget {
//   final List<RatioItem> ratios;
//   const _Sidebar({required this.ratios});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300,
//       height: double.infinity,
//       decoration: const BoxDecoration(
//         color: AppColors.white,
//         border: Border(
//           left: BorderSide(color: AppColors.border),
//         ),
//       ),
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//         child: Column(
//           children: [
//             // Avatar
//
//
//             // Ratios Label
//
//             const SizedBox(height: 14),
//
//             // Ratio Items
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }

class _CompanyCard extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final bool showCurrency;

  const _CompanyCard({
    required this.label,
    required this.value,
    required this.sub,
    required this.showCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      // padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryOlive,
            ),
          ),
          const SizedBox(height: 10),

          FittedBox(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                overflow: TextOverflow.ellipsis,
                letterSpacing: -0.5,
              ),
            ),
          ),

          const SizedBox(height: 4),
          if (showCurrency) ...[
            const SizedBox(width: 10),
            Text(
              '﷼',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryOlive,
              ),
            ),
          ],
          // Text(
          //   sub,
          //   style:  TextStyle(fontSize: 12, color: AppColors.primaryOlive,),
          // ),
        ],
      ),
    );
  }
}
