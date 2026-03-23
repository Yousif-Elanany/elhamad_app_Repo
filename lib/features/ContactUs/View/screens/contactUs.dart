import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/network/cache_helper.dart';
import '../../../../localization_service.dart';
import '../../../Organizations/view/widgets/ComplainDetail.dart';
import '../../../compaines/views/widgets/addComplain.dart';
import '../../../home/models/complainModel.dart';
import '../../../drawer/appdrawer.dart';
import '../../Repos/contactUs.dart';
import '../../Services/Contact_Remote_Data_Source.dart';
import '../../viewModel/contact_us_cubit.dart';
// تأكد من استيراد الـ extension الخاص بك
// import 'path_to_localization/localization_service.dart';
class ContactusWrapper extends StatelessWidget {
  const ContactusWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactUsCubit(ContactRepository(ContactRemoteDataSource())),
      child: const Contactus(),
    );
  }
}
class Contactus extends StatefulWidget {
  const Contactus({super.key});

  @override
  State<Contactus> createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
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
  void initState() {
    super.initState();
  final cubit =  context.read<ContactUsCubit>();
    cubit.getComplaints(CacheHelper.getData("companyId"));
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
        title: Text(
          "contact_us".tr(),
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
                      addComplainDialog.show(context);

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
                      "Send New Massage".tr(),
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
              child: BlocBuilder<ContactUsCubit, ContactUsState>(
                builder: (context, state) {

                  if (state is ContactUsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ContactUsFailure) {
                    return Center(
                      child: Text(
                        "حدث خطأ: ${state.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (state is ContactUsSuccess) {

                    final complaints = state.data.items;

                    if (complaints.isEmpty) {
                      return const Center(
                        child: Text(
                          "لا توجد شكاوى",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {

                        final item = complaints[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ComplaintCard(
                            index: item.complaintNumber,
                            complainant: item.createdByName ?? '',
                            content: item.complaintText?? '',
                            date: item.createdAt.toString() ?? '',
                            type: item.type ?? '',
                            status: item.status ?? '',
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
            // Icon(
            //   Icons.contact_support_outlined,
            //   size: 80,
            //   color: Colors.grey.withOpacity(0.5),
            // ),
            // const SizedBox(height: 16),
            // Text(
            //   "no_contacts_available".tr(),
            //   style: TextStyle(
            //     color: Colors.grey.shade600,
            //     fontSize: 16,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }


}