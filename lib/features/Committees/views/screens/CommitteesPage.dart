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
import '../../Model/CreateCommitRequest.dart';
import '../../Repos/Commites_Repo.dart';
import '../../viewModel/committees_cubit.dart';
import '../Dialogs/AddDialog.dart';
import '../widgets/DialogDropdownField.dart';
import '../widgets/DialogInputField.dart';

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
  final TextEditingController numOfMemberController = TextEditingController();
  final TextEditingController numOfMeetingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CommitteesCubit>().getCommittees(
      CacheHelper.getData("companyId"),
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
                    final committeesCubit = context.read<CommitteesCubit>();

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => BlocProvider.value(
                        value: committeesCubit,
                        child: const AddCommitteeDialog(),
                      ),
                    );
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
}
