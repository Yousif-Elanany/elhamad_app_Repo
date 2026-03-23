import 'package:alhamd/core/network/cache_helper.dart';
import 'package:alhamd/features/massages/view/screens/widgets/AddMassageDialog.dart';
import 'package:alhamd/features/massages/view/screens/widgets/MassageCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart%20';
import '../../../../core/constants/app_colors.dart';
import '../../../../localization_service.dart';
import '../../../Committees/Repos/Commites_Repo.dart';
import '../../../Committees/Services/Committees_Remote_Data_Source.dart';
import '../../../Committees/viewModel/committees_cubit.dart';
import '../../../Executives_Administrators/views/widgets/adminCard.dart';
import '../../../compaines/views/widgets/addComplain.dart';
import '../../../home/models/complainModel.dart';
import '../../../drawer/appdrawer.dart';
import '../../../policy/views/widgets/policyCard.dart';
import '../../Repos/Massage_Repo.dart';
import '../../Services/Massage_Remote_Data_Source.dart';
import '../../viewModels/Massage_cubit.dart';

// تأكد من استيراد الـ extension الخاص بك
// import 'path_to_localization/localization_service.dart';
class MassageScreenWrapper extends StatelessWidget {
  const MassageScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    print("🔥 CompanyHomeWrapper built");
    return BlocProvider(
      create: (_) =>
          MassageCubit(MassageRepository(MassageRemoteDataSource())),
      child: const MassageScreen(),
    );
  }
}
class MassageScreen extends StatefulWidget {
  const MassageScreen({super.key});

  @override
  State<MassageScreen> createState() => _MassageScreenState();
}

class _MassageScreenState extends State<MassageScreen> {


  @override
  void initState() {
    super.initState();
    print("🔥 MassageScreen initState called");
    context.read<MassageCubit>().getMessages(
        CacheHelper.getData("companyId"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // الـ Drawer هيظهر تلقائياً جهة اليمين في العربي واليسار في الإنجليزي
      drawer: const Appdrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          // أيقونة التنبيهات
          IconButton(
            onPressed: () {

              Navigator.pop(context);
    },        icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        ],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        // تجنب استخدام Center widget داخل العنوان واستخدم الخاصية الجاهزة
        centerTitle: true,
        title: Text(
          "Massages".tr(),
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
                        builder: (_) => const SendMessageDialog(),
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
                      "Send Message".tr(),
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
              child: BlocBuilder<MassageCubit, MassageState>(
                builder: (context, state) {

                  // ⏳ Loading
                  if (state is MassageLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // ✅ Success
                  else if (state is MassageSuccess) {
                    final complaints = state.messages.items; // 👈 المهم هنا

                    if (complaints == null || complaints.isEmpty) {
                      return const Center(
                        child: Text("لا يوجد رسائل"),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        final item = complaints[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: massageCard(
                            id: item.id.toString(), // 👈 String
                            title: item.title,
                            status: item.status,
                            sentAt: DateFormat('yyyy-MM-dd – hh:mm a').format(item.sentAt),                            totalRecipients: item.totalRecipients.toString(),
                            channels:item.channels, // 👈 List<String> to String

                          )
                        );
                      },
                    );
                  }

                  // ❌ Error
                  else if (state is MassageError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }


}