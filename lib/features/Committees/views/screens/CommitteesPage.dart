import 'package:alhamd/features/Committees/Services/Committees_Remote_Data_Source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart%20';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/network/cache_helper.dart';
import '../../../Organizations/ViewModel/organization_cubit.dart';
import '../../../home/models/complainModel.dart';
import '../../../policy/views/widgets/policyCard.dart';
import '../../CommitteesCard.dart';
import '../../Repos/Commites_Repo.dart';
import '../../viewModel/committees_cubit.dart';

class CommitteesScreenWrapper extends StatelessWidget {
  const CommitteesScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    print("🔥 CompanyHomeWrapper built");
    return BlocProvider(
      create: (_) =>
          CommitteesCubit(CommitteesRepository(CommitteesRemoteDataSource())),
      child: const CommitteesPage(),
    );
  }
}

class CommitteesPage extends StatefulWidget {
  const CommitteesPage({super.key});

  @override
  State<CommitteesPage> createState() => _CommitteesPageState();
}

class _CommitteesPageState extends State<CommitteesPage> {
  final Color primaryGreen = const Color(0xFF8B8B6B);

  String selectedStatus = 'الكل';
  String selectedTypeFilter = 'اختر نوع اللجنة';

  String dialogSelectedType = 'مراجعة';
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CommitteesCubit>().getCommittees(
      CacheHelper.getData("companyId"),
    );
  }

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
      id: 3,
      complainant: "مسال مول",
      content: "ssssssssssss",
      date: "21 فبراير 2026, 02:55 م",
      type: "شكوى",
      status: "جديد",
    ),
    ComplaintModel(
      id: 4,
      complainant: "مسال مول",
      content: "ssssssssssss",
      date: "21 فبراير 2026, 02:55 م",
      type: "شكوى",
      status: "جديد",
    ),
    ComplaintModel(
      id: 5,
      complainant: "مسال مول",
      content: "ssssssssssss",
      date: "21 فبراير 2026, 02:55 م",
      type: "شكوى",
      status: "جديد",
    ),
    ComplaintModel(
      id: 6,
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
  void _showAddCommitteeDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "اضافة لجنة",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: 600,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildDialogDropdownField(
                            label: "نوع اللجنة *",
                            value: dialogSelectedType,
                            onChanged: (val) {
                              setDialogState(() => dialogSelectedType = val!);
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildDialogField("عدد الاعضاء *", hint: "1"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDialogField(
                            "تاريخ البداية*",
                            isDatePicker: true,
                            controller: startDateController,
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setDialogState(() {
                                  startDateController.text =
                                      "${picked.year}-${picked.month}-${picked.day}";
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildDialogField(
                            "تاريخ النهاية*",
                            isDatePicker: true,
                            controller: endDateController,
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setDialogState(() {
                                  endDateController.text =
                                      "${picked.year}-${picked.month}-${picked.day}";
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildDialogField("عدد الاجتماعات في السنه *", hint: "1"),
                  ],
                ),
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(100, 45),
                ),
                child: const Text(
                  "إلغاء",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB4B496),
                  minimumSize: const Size(100, 45),
                ),
                child: const Text("حفظ", style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: SizedBox(),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
        title: const Text(
          "اللجان",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showAddCommitteeDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOlive,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 18),
                  label: Text(
                    "اضافة لجنة",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMainDropdown(
                  value: selectedStatus,
                  items: ['الكل', 'نشط', 'غير نشط'],
                  onChanged: (val) => setState(() => selectedStatus = val!),
                  // width: 140,
                ),
                _buildMainDropdown(
                  value: selectedTypeFilter,
                  items: [
                    'اختر نوع اللجنة',
                    'مراجعة',
                    'ترشيحات',
                    'مكافآت',
                    'الترشيحات والمكافآت',
                    'المخاطر',
                  ],
                  onChanged: (val) => setState(() => selectedTypeFilter = val!),
                  // width: 180,
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<CommitteesCubit, CommitteesState>(
                builder: (context, state) {
                  /// 🔄 Loading
                  if (state is GetCommitteesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  /// ❌ Error
                  if (state is GetCommitteesError) {
                    return Center(
                      child: Text(
                        "حدث خطأ: ${state.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  /// ✅ Success
                  if (state is GetCommitteesSuccess) {
                    final complaints = state.data.items ?? [];

                    /// 🟡 Empty
                    if (complaints.isEmpty) {
                      return const Center(
                        child: Text(
                          "لا يوجد لجان",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    /// 📋 List
                    return ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        final item = complaints[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CommitteesCard(
                            index: item.id,
                            activeMemberCount:
                                item.activeMembersCount.toString() ?? '0',
                            availableSeats:
                                item.openPositionCount.toString() ?? '0',
                            startDate: DateFormat(
                              'yyyy/MM/dd',
                            ).format(item.startDate),
                            endDate: DateFormat(
                              'yyyy/MM/dd',
                            ).format(item.endDate),
                            meetingsPerYear:
                                item.yearlyMeetingsCount.toString() ?? '0',
                            membersCount: item.membersCount.toString() ?? '0',

                            type: item.type ?? '',
                            status: item.isActive ? "نشط" : "غير نشط",
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
            //  _buildTableHeader(),
            //_buildEmptyState(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    double width = 150,
  }) {
    return Container(
      //   width: width,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 13)),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDialogDropdownField({
    required String label,
    required String value,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              items:
                  [
                        'مراجعة',
                        'ترشيحات',
                        'مكافآت',
                        'الترشيحات والمكافآت',
                        'المخاطر',
                      ]
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e, style: const TextStyle(fontSize: 13)),
                        ),
                      )
                      .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDialogField(
    String label, {
    String? hint,
    bool isDatePicker = false,
    TextEditingController? controller,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: isDatePicker ? onTap : null,
          child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                if (isDatePicker) ...[
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 18,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: isDatePicker
                      ? Text(
                          controller!.text.isEmpty
                              ? (hint ?? "اختر التاريخ")
                              : controller.text,
                          style: TextStyle(
                            color: controller.text.isEmpty
                                ? Colors.grey
                                : Colors.black,
                            fontSize: 13,
                          ),
                        )
                      : TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: hint,
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: const Color(0xFFF8F9FA),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: const Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "#",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "نوع اللجنة",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "عدد الاعضاء",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "عدد الأماكن المتاحة",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "تاريخ البداية",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "الإجراءات",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          const Icon(Icons.inbox_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 15),
          const Text(
            "لا توجد بيانات متاحة",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
