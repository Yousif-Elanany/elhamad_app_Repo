import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/ActionIconButton.dart';
import '../../../../core/widgets/chatDialog.dart';
import '../../../../core/widgets/deleteDialog.dart';
import 'AddMemberDialog.dart';

class BoardMembersPage extends StatefulWidget {
  const BoardMembersPage({super.key});

  @override
  State<BoardMembersPage> createState() => _BoardMembersPageState();
}

class _BoardMembersPageState extends State<BoardMembersPage> {
  bool showAddMemberForm = false;

  final _formKey = GlobalKey<FormState>();

  // Controllers للفورم
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _membershipTypeController =
      TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // مثال: قائمة الأعضاء
  final List<Map<String, String>> members = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "أعضاء مجلس الإدارة",
          style: TextStyle(color: AppColors.primaryOlive),
        ),
        centerTitle: true,
        leading: SizedBox(),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const AddMemberDialog(),
                );
                setState(() {
                  showAddMemberForm = !showAddMemberForm;
                });
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "اضافة عضو",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B8B6B),
                minimumSize: const Size(double.infinity, 45),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                //    if (showAddMemberForm) _buildAddMemberForm(),

                    const SizedBox(height: 15),

                    _buildMembersTable(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberCard(Map<String, String> member) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow("الاسم", member["name"] ?? ""),
          _buildRow("رقم الهوية", member["id"] ?? ""),
          _buildRow("نوع العضوية", member["membershipType"] ?? ""),
          _buildRow("المسمى الوظيفي", member["jobTitle"] ?? ""),
          _buildRow("رقم الجوال", member["phone"] ?? ""),
          _buildRow("البريد الإلكتروني", member["email"] ?? ""),

          const SizedBox(height: 10),

          _buildStatusRow(),

          const SizedBox(height: 10),

          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
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

  Widget _buildStatusRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        "نشط",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () {},
        ),

        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {},
        ),
      ],
    );
  }

  // الفورم لإضافة عضو
  Widget _buildAddMemberForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 6),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildField("الاسم", _nameController),
            _buildField("رقم الهوية", _idController),
            _buildField("نوع العضوية", _membershipTypeController),
            _buildField("المسمى الوظيفي", _jobTitleController),
            _buildField("رقم الجوال", _phoneController),
            _buildField("البريد الإلكتروني", _emailController),

            const SizedBox(height: 15),

            Row(
              children: [
                /// ✅ زرار الحفظ
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          members.add({
                            "name": _nameController.text,
                            "id": _idController.text,
                            "membershipType": _membershipTypeController.text,
                            "jobTitle": _jobTitleController.text,
                            "phone": _phoneController.text,
                            "email": _emailController.text,
                          });

                          // تنظيف الحقول
                          _nameController.clear();
                          _idController.clear();
                          _membershipTypeController.clear();
                          _jobTitleController.clear();
                          _phoneController.clear();
                          _emailController.clear();

                          // ✅ يقفل الفورم بعد الحفظ
                          showAddMemberForm = false;
                        });
                      }
                    },
                    child: const Text("حفظ"),
                  ),
                ),

                const SizedBox(width: 10),

                /// ❌ زرار الإلغاء
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        // ✅ يقفل الفورم بدون حفظ
                        showAddMemberForm = false;
                      });
                    },
                    child: const Text("إلغاء"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // دالة لبناء الحقول
  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
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

  // جدول الأعضاء
  Widget _buildMembersTable() {
    if (members.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text("لا يوجد أعضاء بعد"),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("#")),
          DataColumn(label: Text("الاسم")),
          DataColumn(label: Text("رقم الهوية")),
          DataColumn(label: Text("نوع العضوية")),
          DataColumn(label: Text("المسمى الوظيفي")),
          DataColumn(label: Text("رقم الجوال")),
          DataColumn(label: Text("البريد الإلكتروني")),
          DataColumn(label: Text("الإجراءات")),
        ],
        rows: List.generate(members.length, (index) {
          final member = members[index];
          return DataRow(
            cells: [
              DataCell(Text((index + 1).toString())),
              DataCell(Text(member["name"] ?? "")),
              DataCell(Text(member["id"] ?? "")),
              DataCell(Text(member["membershipType"] ?? "")),
              DataCell(Text(member["jobTitle"] ?? "")),
              DataCell(Text(member["phone"] ?? "")),
              DataCell(Text(member["email"] ?? "")),
              DataCell(
                Row(
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
                    SizedBox(width: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ActionIconButton(
                        onTap: () => ComplaintDetailsDialog.show(context),
                        icon: Icons.edit,
                        iconColor: Colors.lightBlue,
                        backgroundColor: AppColors.white,
                        borderColor: Colors.lightBlue,
                      ),
                    ),
                    SizedBox(width: 12),
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
                    SizedBox(width: 12),

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
                        icon: Icons.close_sharp,
                        iconColor: Colors.red,
                        backgroundColor: Colors.white,
                        borderColor: Colors.red,
                      ),
                    ),

                    SizedBox(width: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ActionIconButton(
                        onTap: () => ComplaintDetailsDialog.show(context),
                        icon: Icons.send_and_archive,
                        iconColor: Colors.deepOrange,
                        backgroundColor: AppColors.primaryOlive.withOpacity(.1),
                        borderColor: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
