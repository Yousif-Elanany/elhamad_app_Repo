import 'package:alhamd/features/managments/views/widgets/addBoard.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/ActionIconButton.dart';
import '../../../../core/widgets/chatDialog.dart';
import '../../../home/models/complainModel.dart';
import '../../../managments/views/widgets/AddMemberDialog.dart';
import '../../../managments/views/widgets/managmentWidget.dart';
import '../widgets/AddEmployee.dart';
import '../widgets/employeeCard.dart';

class EmployeesTabContent extends StatefulWidget {
  @override
  _EmployeesTabContentState createState() => _EmployeesTabContentState();
}

class _EmployeesTabContentState extends State<EmployeesTabContent> {
  String selectedStatus = 'الكل';
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddEmployeeDialog(),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              "اضافة موظف",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B8B6B),
              minimumSize: const Size(
                double.infinity,
                45,
              ), // ياخد عرض العمود كله
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: complaints.length,
              //   padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                final item = complaints[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: EmployeeWidget(
                    caseName: "12123456",
                    startDate: "الثلاثاء، 3 فبراير 2026",
                    endDate: "الثلاثاء، 24 فبراير 2026",
                    boardMembers: "4",
                    activeMembers: "4",
                    availableSeats: "3",
                    status: "1",
                    model: ComplaintModel(
                      id: item.id,
                      complainant: item.complainant,
                      content: item.content,
                      date: item.date,
                      type: item.type,
                      status: item.status,
                    ),
                    onViewTap: () => print("عرض التفاصيل"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FirstDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "قائمة الأعضاء",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AddMemberDialog(),
                );
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "إضافة مجلس إدارة",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B8B6B),
                minimumSize: const Size(
                  double.infinity,
                  45,
                ), // ياخد عرض العمود كله
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// هنا ممكن تحط جدول أو قائمة الأعضاء
            Container(
              height: 200,
              child: const Center(child: Text("هنا هتظهر قائمة الأعضاء")),
            ),
          ],
        ),
      ),
    );
  }
}

  Widget _buildField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "مطلوب";
          }
          return null;
        },
      ),
    );
  }

