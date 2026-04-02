import 'package:alhamd/localization_service.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/network/cache_helper.dart';
import '../../../../core/widgets/ActionIconButton.dart';
import '../../../../core/widgets/chatDialog.dart';
import '../../../../core/widgets/deleteDialog.dart';
import '../../../Committees/Model/UsersSigntureRequestModel.dart';
import '../../../home/models/complainModel.dart';
import '../../../policy/views/widgets/makePolicyRequestDialog.dart';
import '../../Models/EditExecutiveModel.dart';
import '../../viewModel/executives_cubit.dart';

class adminCard extends StatefulWidget {
  final int index;
  final String name;
  final String NationalID;
  final String phone;
  final String email;
  final String status;
  final String signatureRequestId;
  final ExecutivesCubit cubit;
  final String jobTitle;
  final bool isActive;

  const adminCard({
    super.key,
    required this.index,
    required this.name,
    required this.NationalID,
    required this.jobTitle,
    required this.isActive,
    required this.signatureRequestId,
    required this.cubit,

    required this.phone,
    required this.email,
    required this.status,
  });

  @override
  State<adminCard> createState() => _adminCardState();
}

class _adminCardState extends State<adminCard> {
  bool isActive = false; // حطه في الـ State

  Color _statusColor() {
    switch (widget.status) {
      case "جديد":
        return Colors.blue;
      case "قديم":
        return Colors.green;
      case "مرفوض":
        return Colors.red;
      case "قيد الانتظار":
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Widget _buildSwitchRow(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Switch(
            value: widget.isActive,
            activeColor: AppColors.primaryOlive,
            onChanged: (val) {
              // print(val); // هل بيطبع؟
              // setState(() {
              //   isActive = val;
              // });
            },
          ),
        ],
      ),
    );
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
                  "# : ${widget.index}",
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
                    widget.status == "" ? "مجهول" : widget.status,
                    style: TextStyle(
                      color: _statusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            _buildRow("name".tr(), widget.name),
            _buildRow("ID number".tr(), widget.NationalID),
            _buildRow("phone_Num".tr(), widget.phone),
            _buildRow("email".tr(), widget.email),
            _buildRow("email".tr(), widget.email),
            _buildRow("JobTitle".tr(), widget.jobTitle),

            _buildSwitchRow("Activity".tr(), widget.isActive, (val) {
              // setState(() {
              //  // isActive = val;
              // });
            }),
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
                    onTap: () {},
                    //   makePolicyRequestDialog.show(context,model: widget.model),
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
                          widget.cubit.deleteExecutive(
                            CacheHelper.getData(
                              "companyId",
                            ), // استبدل بالقيمة الحقيقية
                            widget.index, // استبدل بالقيمة الحقيقية
                          );

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

                Align(
                  alignment: Alignment.centerLeft,
                  child: ActionIconButton(
                    onTap: () {
                      final model = UsersSigntureRequestModel(
                          userIds: [
                            widget.signatureRequestId,
                            // استبدل بالقيمة الحقيقية
                          ]
                      );
                      widget.cubit.sendSignatureRequest(
                        CacheHelper.getData(
                          "companyId",
                        ), // استبدل بالقيمة الحقيقية
                        model, // استبدل بالقيمة الحقيقية
                      );
                    },
                    icon: Icons.request_quote_outlined,
                    iconColor: Colors.deepOrange,
                    backgroundColor: Colors.white,
                    borderColor: Colors.deepOrange,
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
