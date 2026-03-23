import 'package:alhamd/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/cache_helper.dart';
import '../../../../core/widgets/ActionIconButton.dart';
import '../../../../core/widgets/chatDialog.dart';
import '../../viewModel/management_cubit.dart';
import 'AddShareholderDialog.dart';

class ShareholdersTabContent extends StatefulWidget {
  final ManagementCubit cubit;
  const ShareholdersTabContent({super.key, required this.cubit});

  @override
  State<ShareholdersTabContent> createState() => _ShareholdersTabContentState();
}

class _ShareholdersTabContentState extends State<ShareholdersTabContent> {
  final Color primaryGreen = const Color(0xFF8B8B6B);
  final Color lightGrey = const Color(0xFFF5F5F5);
  @override
  void initState() {
    super.initState();
      widget.cubit.getShareHolders(CacheHelper.getData("companyId"));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // استخدمنا Wrap بدلاً من Row لحل مشكلة الـ Overflow
              // بحيث لو العناصر زادت عن عرض الشاشة تنزل في سطر جديد تلقائياً
              Wrap(
                spacing: 10, // المسافة الأفقية بين العناصر
                runSpacing: 10, // المسافة الرأسية لو نزل سطر جديد
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // زر إضافة مساهم
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(context: context,
                          builder: (context) =>
                              AddShareholderDialog(),);
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text("إضافة مساهم", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      minimumSize: const Size(double.infinity, 45), // ياخد عرض العمود كله

                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),

                  // // شريط البحث - حددنا العرض بشكل مرن أو ثابت مناسب
                  // Container(
                  //   width: MediaQuery.of(context).size.width > 600 ? 300 : 200,
                  //   height: 45,
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       hintText: "بحث...",
                  //       prefixIcon: const Icon(Icons.search),
                  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  //       contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  //     ),
                  //   ),
                  // ),

                  // // أزرار البحث والمسح
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(backgroundColor: primaryGreen),
                  //   child: const Text("بحث", style: TextStyle(color: Colors.white)),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey[50]),
                  //   child: const Text("مسح", style: TextStyle(color: Colors.black)),
                  // ),
                ],
              ),
              const SizedBox(height: 20),

              // الجدول الرئيسي (يبقى كما هو لأنه داخل SingleChildScrollView أفقي)
              Expanded(
                child: BlocBuilder<ManagementCubit, ManagementState>(
                  builder: (context, state) {

                    if (state is ShareHoldersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is ShareHoldersFailure) {
                      return Center(
                        child: Text(
                          "حدث خطأ: ${state.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (state is ShareHoldersSuccess) {

                      final shareholders = state.data.items; // حسب الموديل

                      if (shareholders.isEmpty) {
                        return const Center(
                          child: Text(
                            "لا يوجد مساهمين",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: shareholders.length,
                        itemBuilder: (context, index) {

                          final shareholder = shareholders[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: _buildShareholderCard(
                              shareholder.id.toString(),
                              shareholder.nationalId ?? '',
                              shareholder.name ?? '',
                              shareholder.type ?? '',
                              shareholder.sharesCount.toString(),
                              shareholder.sharesPercentage.toString(),
                              shareholder.operationType ?? '',
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),

              const SizedBox(height: 10),
            //  _buildPagination(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildShareholderCard(
      String id,
      String number,
      String name,
      String type,
      String shares,
      String percent,
      String shareType,
      ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryOlive),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _buildRow("#", id),
          _buildRow("رقم المساهم", number),
          _buildRow("اسم المساهم", name),
          _buildRow("نوع المساهم", type),
          _buildRow("عدد الأسهم", shares),
          _buildRow("نسبة الملكية (%)", percent),
          _buildRow("نوع السهم", shareType),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              Align(
                alignment: Alignment.centerLeft,
                child: ActionIconButton(
                  onTap: () => ComplaintDetailsDialog.show(context),
                  icon: Icons.remove_red_eye_rounded,
                  iconColor: AppColors.primaryOlive,
                  backgroundColor: AppColors.primaryOlive.withOpacity(.1),
                  borderColor: AppColors.primaryOlive,
                ),
              ),              SizedBox(width: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: ActionIconButton(
                  onTap: () => ComplaintDetailsDialog.show(context),
                  icon: Icons.edit,
                  iconColor: Colors.lightBlue,
                  backgroundColor: AppColors.white,
                  borderColor: Colors.lightBlue,
                ),
              ),            ],
          )
        ],
      ),
    );
  }
  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$title : ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
  // الدوال المساعدة تبقى كما هي في الكود السابق...
  DataRow _buildDataRow(String id, String num, String name, String type, String count, String ratio, String stockType) {
    return DataRow(cells: [
      DataCell(Text(id)), DataCell(Text(num)), DataCell(Text(name)),
      DataCell(Text(type)), DataCell(Text(count)), DataCell(Text(ratio)),
      DataCell(Text(stockType)),
      DataCell(Row(
        children: [
          IconButton(icon: const Icon(Icons.edit_note, color: Colors.blue), onPressed: () {}),
          IconButton(icon: const Icon(Icons.visibility_outlined, color: Colors.grey), onPressed: () {}),
        ],
      )),
    ]);
  }

  Widget _buildPagination() {
    return SingleChildScrollView( // أضفنا هذا لحماية الترقيم من الـ Overflow أيضاً
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: lightGrey, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.chevron_right, color: Colors.grey),
            const SizedBox(width: 10),
            const Text("1"),
            const SizedBox(width: 10),
            const Icon(Icons.chevron_left, color: Colors.grey),
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
              child: const Row(children: [Text("10"), Icon(Icons.arrow_drop_down)]),
            )
          ],
        ),
      ),
    );
  }
}