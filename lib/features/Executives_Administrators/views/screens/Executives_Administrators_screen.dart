import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/network/cache_helper.dart';
import '../../../../localization_service.dart';
import '../../../home/models/complainModel.dart';
import '../../../drawer/appdrawer.dart';
import '../../Services/Executives_Remote_Data_Source.dart';
import '../../repos/Executives_Repo.dart';
import '../../viewModel/executives_cubit.dart';
import '../../viewModel/executives_state.dart';
import '../widgets/AdminstraationDialog.dart';
import '../widgets/adminCard.dart';


class ExecutivesAdministratorsScreenWrapper extends StatelessWidget {
  const ExecutivesAdministratorsScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    print("🔥 CompanyHomeWrapper built");
    return BlocProvider(
      create: (_) =>
          ExecutivesCubit(ExecutivesRepository(ExecutivesRemoteDataSource())),
      child: const ExecutivesAdministrators(),
    );
  }
}

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

  initState() {
    super.initState();
    print("🔥 ExecutivesAdministrators initState called");
    context.read<ExecutivesCubit>().getExecutives(
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
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        // تجنب استخدام Center widget داخل العنوان واستخدم الخاصية الجاهزة
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
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
              child: BlocBuilder<ExecutivesCubit, ExecutivesState>(
                builder: (context, state) {

                  // ⏳ Loading
                  if (state is ExecutivesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // ✅ Success
                  else if (state is ExecutivesSuccess) {
                    final complaints = state.data.items; // حسب الموديل عندك

                    if (complaints.isEmpty) {
                      return const Center(
                        child: Text("لا يوجد بيانات"),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        final item = complaints[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: adminCard(
                            index: item.profileId,
                            email: item.phone,
                            name: item.name,
                            NationalID : item.nationalId,
                            jobTitle: item.jobTitle,
                            status: item.isActive.toString(), phone: item.phone,
                          ),
                        );
                      },
                    );
                  }

                  // ❌ Error
                  else if (state is ExecutivesError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  // 🟡 Initial
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