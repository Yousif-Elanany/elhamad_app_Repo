import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../localization_service.dart';
import '../../../Organizations/widgets/ComplainDetail.dart';
import '../../../compaines/views/widgets/addComplain.dart';
import '../../../home/models/complainModel.dart';
import '../../../home/view/widgets/appdrawer.dart';
import '../../../policy/views/widgets/policyCard.dart';
import '../widgets/AdminstraationDialog.dart';
import '../widgets/adminCard.dart';
// تأكد من استيراد الـ extension الخاص بك
// import 'path_to_localization/localization_service.dart';

class ExecutivesAdministrators extends StatefulWidget {
  const ExecutivesAdministrators({super.key});

  @override
  State<ExecutivesAdministrators> createState() => _ExecutivesAdministratorsState();
}

class _ExecutivesAdministratorsState extends State<ExecutivesAdministrators> {
  final List<ComplaintModel> complaints = [
    ComplaintModel(
      id: 1,
      complainant: "مسال مول",
      content: "ssssssssssss",
      date: "21 فبراير 2026, 02:55 م",
      type: "شكوى",
      status: "جديد",
    ),
    ComplaintModel(
      id: 2,
      complainant: "أحمد علي",
      content: "تأخير في الخدمة",
      date: "20 فبراير 2026, 11:30 ص",
      type: "بلاغ",
      status: "جديد",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // الـ Drawer هيظهر تلقائياً جهة اليمين في العربي واليسار في الإنجليزي
      drawer: const Appdrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        // تجنب استخدام Center widget داخل العنوان واستخدم الخاصية الجاهزة
        centerTitle: true,
        title: Text(
          "Executives/Administrators".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const AddContributorDialog(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOlive,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: Text(
                      "Executive/Administrative Addition".tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: complaints.length,
                itemBuilder: (context, index) {
                  final item = complaints[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: adminCard(
                      model: ComplaintModel(
                        id: item.id,
                        complainant: item.complainant,
                        content: item.content,
                        date: item.date,
                        type: item.type,
                        status: item.status,
                      ),
                      index: item.id,
                      complainant: item.complainant,
                      content: item.content,
                      date: item.date,
                      type: item.type,
                      status: item.status,
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }


}