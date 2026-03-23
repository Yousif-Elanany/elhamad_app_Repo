import 'package:alhamd/localization_service.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/ActionIconButton.dart';
import '../../../../core/widgets/chatDialog.dart';
import '../../../../core/widgets/deleteDialog.dart';
import '../../../home/models/complainModel.dart';
import 'makePolicyRequestDialog.dart';

class PolicyCard extends StatelessWidget {
  final int index;
  final String companyName;
  final String address;
  final String notes;
  final String Status;

  final String makeRequest;
  final String date;
  final ComplaintModel? model;

  const PolicyCard({
    super.key,
    required this.index,
    required this.companyName,
    required this.address,
    required this.Status,
    required this.notes,
    required this.makeRequest,
    required this.date,

     this.model,
  });

  Color _statusColor() {
    switch (address) {
      case "جديد":
        return Colors.blue;
      case "قديم":
        return Colors.green;
      case "مرفوض":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "# : $index",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor().withOpacity(.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    Status,
                    style: TextStyle(
                      color:Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            _buildRow("address".tr(), address),
            _buildRow("notes".tr(), notes),
            _buildRow("مقدم الطلب",  makeRequest),
            _buildRow("اسم الشركة", companyName),
            _buildRow("تاريخ الإنشاء", date),

            const SizedBox(height: 12),

            /// الإجراءات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ActionIconButton(
                    onTap: () => ComplaintDetailsDialog.show(context),
                    icon: Icons.remove_red_eye_rounded,
                    iconColor: AppColors.primaryOlive,
                    backgroundColor: AppColors.primaryOlive.withOpacity(.1),
                    borderColor: AppColors.primaryOlive,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ActionIconButton(
                    onTap: () =>
                        makePolicyRequestDialog.show(context,model: model),
                    icon: Icons.edit,
                    iconColor: Colors.blue,
                    backgroundColor: Colors.blue.withOpacity(.1),
                    borderColor: Colors.blue,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ActionIconButton(
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => ConfirmDeleteDialog(
                        onConfirm: () {
                          Navigator.pop(context);
                          // منطق الحذف هنا
                        },
                      ),
                    ),
                    icon: Icons.delete,
                    iconColor: Colors.red,
                    backgroundColor: Colors.white,
                    borderColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: "$title : ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  void _showActionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("الإجراءات"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("قبول الشكوى"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("رفض الشكوى"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("تحت المراجعة"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
