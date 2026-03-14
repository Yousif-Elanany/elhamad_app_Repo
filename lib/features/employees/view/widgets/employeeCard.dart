import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/ActionIconButton.dart';
import '../../../../core/widgets/deleteDialog.dart';
import '../../../../localization_service.dart';
import '../../../home/models/complainModel.dart';
import '../../../policy/views/widgets/makePolicyRequestDialog.dart';

// لو عندك ActionIconButton معرف عندك
// import 'package:your_project/widgets/action_icon_button.dart';

class EmployeeWidget extends StatefulWidget {
  final String caseName;
  final String startDate;
  final String endDate;
  final String boardMembers;
  final String activeMembers;
  final String availableSeats;
  final String status; // 1 = نشط, 2 = غير نشط
  final VoidCallback onViewTap;
  final ComplaintModel model;

  const EmployeeWidget({
    Key? key,
    required this.caseName,
    required this.startDate,
    required this.endDate,
    required this.boardMembers,
    required this.activeMembers,
    required this.availableSeats,
    required this.status,
    required this.model,
    required this.onViewTap,
  }) : super(key: key);

  @override
  State<EmployeeWidget> createState() => _EmployeeWidgetState();
}

class _EmployeeWidgetState extends State<EmployeeWidget> {
   bool isActive = false; // حطه في الـ State

  Color _statusColor() {
  switch (widget.status) {
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "# : ${widget.model.id}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              // Container(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 10,
              //     vertical: 4,
              //   ),
              //   decoration: BoxDecoration(
              //     color: _statusColor().withOpacity(.15),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Text(
              //     widget.status,
              //     style: TextStyle(
              //       color: _statusColor(),
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),

          const SizedBox(height: 10),
          _buildRow("اسم الدور الوظيفي", Text(widget.caseName)),


          const SizedBox(height: 8),

          // الحالة كـ Badge
          _buildSwitchRow(
            "Active".tr(),
            isActive,
                (val) {
              setState(() {
                isActive = val;
              });
            },
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Align(
                alignment: Alignment.centerLeft,
                child: ActionIconButton(
                  onTap: () =>
                      makePolicyRequestDialog.show(context,model: widget.model),
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
    );
  }
   Widget _buildSwitchRow(String title, bool value, Function(bool) onChanged) {
     return Padding(
       padding: const EdgeInsets.only(bottom: 6),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text(
             "$title:",
             style: const TextStyle(
               fontWeight: FontWeight.bold,
               color: Colors.black,
             ),
           ),
           Switch(
             value: value,
             activeColor: AppColors.primaryOlive,
             onChanged: onChanged,
           ),
         ],
       ),
     );
   }
  Widget _buildRow(String title, Widget value) {
    return Row(
      children: [
        Text(
          "$title : ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 6),
        value,
      ],
    );
  }

  Widget statusWidget(String status) {
    bool isActive = status == "1";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isActive ? "نشط" : "غير نشط",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}