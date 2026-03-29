import 'package:alhamd/features/managments/Models/BoardDetailModel.dart';
import 'package:alhamd/features/managments/views/widgets/addBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/network/cache_helper.dart';

import '../../viewModel/management_cubit.dart';
import 'BoardDetailWidget.dart';
import 'MembersScreen.dart';
import 'managmentWidget.dart';

class BoardTabContent extends StatefulWidget {
  final ManagementCubit cubit;
  const BoardTabContent({super.key, required this.cubit});
  @override
  _BoardTabContentState createState() => _BoardTabContentState();
}

class _BoardTabContentState extends State<BoardTabContent> {
  String selectedStatus = 'الكل';
  @override
  void initState() {
    super.initState();
    widget.cubit.getDirectors(CacheHelper.getData("companyId"));
  }

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
                builder: (context) => AddBoardDialog(),
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

          SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<ManagementCubit, ManagementState>(
              builder: (context, state) {
                if (state is DirectorsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is DirectorsFailure) {
                  return Center(
                    child: Text(
                      "حدث خطأ: ${state.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is DirectorsSuccess) {
                  final directors = state.data.items; // غيّر حسب موديلك

                  if (directors.isEmpty) {
                    return const Center(
                      child: Text(
                        "لا يوجد مجالس إدارة",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: directors.length,
                    itemBuilder: (context, index) {
                      final board = directors[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ManagementWidget(
                          caseName:
                              board.id.toString() ?? '', // غيّر حسب موديلك
                          startDate: DateFormat(
                            'yyyy/MM/dd',
                          ).format(board.startDate),
                          endDate: DateFormat(
                            'yyyy/MM/dd',
                          ).format(board.endDate),
                          boardMembers: board.membersCount.toString() ?? '',
                          activeMembers:
                              board.activeMembersCount?.toString() ?? '0',
                          availableSeats:
                              board.openPositionCount?.toString() ?? '0',
                          status: board.isActive ? "نشط" : "غير نشط",
                          onViewTap: () {
                            showBoardDetailsDialog(
                              board,
                              context,


                            );
                          },
                          onGroupTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: widget.cubit,
                                  child: BoardMembersPage(
                                    boardId: board.id.toString(),
                                    cubit: widget.cubit,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
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

class AddMemberDialog extends StatefulWidget {
  const AddMemberDialog({super.key});

  @override
  State<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "إضافة عضو جديد",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                _buildField("الاسم"),
                _buildField("رقم الهوية"),
                _buildField("نوع العضوية"),
                _buildField("المسمى الوظيفي"),
                _buildField("رقم الجوال"),
                _buildField("البريد الإلكتروني"),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context); // يقفل Dialog العضو
                    }
                  },
                  child: const Text("حفظ"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
}
