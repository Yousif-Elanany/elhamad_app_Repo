import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../localization_service.dart';
import '../../../Organizations/widgets/ComplainDetail.dart';
import '../../../compaines/views/widgets/addComplain.dart';
import '../../../home/models/complainModel.dart';
import '../../../drawer/appdrawer.dart';
import '../widgets/AddPolicyDialog.dart';
import '../widgets/add_policyCard.dart';
import '../widgets/makePolicyRequestDialog.dart';
import '../widgets/policyCard.dart';

// تأكد من استيراد الـ extension الخاص بك
// import 'path_to_localization/localization_service.dart';
class RulesAndRegulations extends StatefulWidget {
  const RulesAndRegulations({super.key});

  @override
  State<RulesAndRegulations> createState() => _RulesAndRegulationsState();
}

class _RulesAndRegulationsState extends State<RulesAndRegulations>
    with SingleTickerProviderStateMixin {

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const Appdrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          centerTitle: true,
          title: Text(
            "policies_regulations".tr(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          bottom: TabBar(
            labelColor: AppColors.primaryOlive,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primaryOlive,
            tabs: [
              Tab(text: "Policy_Requests".tr()),
              Tab(text: "Policies".tr()),
            ],
          ),
        ),
        body: TabBarView(
          children: [

            /// 🔹 التاب الأول (طلبات السياسات)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      makePolicyRequestDialog.show(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOlive,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.add,
                        color: Colors.white, size: 18),
                    label: Text(
                      "Policy_Request".tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: complaints.length,
                    itemBuilder: (context, index) {
                      final item = complaints[index];

                      return Padding(
                        padding:
                        const EdgeInsets.only(bottom: 12),
                        child: PolicyCard(
                          model: item,
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

            /// 🔹 التاب الثاني (السياسات)
            Center(
              child:        Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        AddPolicyRequestDialog.show(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOlive,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.add,
                          color: Colors.white, size: 18),
                      label: Text(
                        "add_policy".tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        final item = complaints[index];

                        return Padding(
                          padding:
                          const EdgeInsets.only(bottom: 12),
                          child: AddPolicyCard(
                            model: item,
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
          ],
        ),
      ),
    );
  }
}