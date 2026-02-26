import 'package:flutter/material.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // شريط البحث وزر الإضافة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  //_showAddCompanyDialog(context),
                  icon: const Icon(Icons.add),
                  label: const Text("إضافة شركة"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C8C6B),
                    foregroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: "بحث عن طريق الاسم",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // الجدول
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("#")),
                  DataColumn(label: Text("اسم الشركة")),
                  DataColumn(label: Text("النشاط")),
                  DataColumn(label: Text("إجراء")),
                ],
                rows: List.generate(
                  5,
                  (index) => DataRow(
                    cells: [
                      DataCell(Text("${index + 1}")),
                      const DataCell(Text("شركة المساهمة المحدودة")),
                      DataCell(
                        Switch(
                          value: true,
                          onChanged: (v) {},
                          activeColor: Colors.green,
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                //showDeleteConfirmDialog(context),
                              },
                            ),
                            const Icon(Icons.edit_note, color: Colors.blue),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.visibility_outlined,
                              color: Color(0xFF8C8C6B),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _showAddCompanyDialog(BuildContext context) {
  //   showDialog(context: context, builder: (c) =>  AddCompanyDialog());
  // }
  //
  // void _showDeleteConfirmDialog(BuildContext context) {
  //   showDialog(context: context, builder: (c) =>  DeleteConfirmDialog());
  // }
}
