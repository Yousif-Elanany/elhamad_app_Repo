import 'package:alhamd/features/Committees/Model/CreateCommitRequest.dart';
import 'package:alhamd/features/Committees/viewModel/committees_cubit.dart';
import 'package:alhamd/features/Committees/views/CommetDetail.dart';
import 'package:alhamd/features/Committees/views/Dialogs/editDialog.dart';
import 'package:alhamd/features/Committees/views/screens/MemberScreen.dart';
import 'package:alhamd/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/ActionIconButton.dart';
import '../../../../core/widgets/chatDialog.dart';
import '../../../../core/widgets/deleteDialog.dart';
import '../../core/network/cache_helper.dart';
import '../home/models/complainModel.dart';
import '../policy/views/widgets/makePolicyRequestDialog.dart';

class CommitteesCard extends StatelessWidget {
  final int index;
  final String type;
  final String membersCount;
  final String activeMemberCount;
  final String availableSeats;
  final String meetingsPerYear;
  final String startDate;
  final String endDate;

  final String status;

  const CommitteesCard({
    super.key,
    required this.index,
    required this.membersCount,
    required this.activeMemberCount,
    required this.availableSeats,
    required this.meetingsPerYear,
    required this.startDate,
    required this.endDate,

    required this.type,
    required this.status,
  });

  Color _statusColor() {
    switch (status) {
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
                    status,
                    style: TextStyle(
                      color: _statusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            _buildRow("نوع اللجنة".tr(), type),
            _buildRow("عدد الاعضاء".tr(), membersCount.toString()),
            _buildRow("عدد الأعضاء النشطين", activeMemberCount.toString()),
            _buildRow("عدد الأماكن المتاحة", availableSeats.toString()),
            _buildRow("تاريخ البداية", startDate),
            _buildRow("تاريخ النهاية", endDate),
            _buildRow("عدد الاجتماعات في السنه", meetingsPerYear.toString()),

            const SizedBox(height: 12),

            /// الإجراءات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ActionIconButton(
                    onTap: () => showCommitteeDetailsDialog(
                      CreateCommitRequest(
                        type: type,
                        startDate: startDate,
                        endDate: endDate,
                        membersCount: int.parse(membersCount),
                        yearlyMeetingsCount: int.parse(meetingsPerYear),
                      ),
                      context,
                    ),
                    icon: Icons.remove_red_eye_rounded,
                    iconColor: AppColors.primaryOlive,
                    backgroundColor: AppColors.primaryOlive.withOpacity(.1),
                    borderColor: AppColors.primaryOlive,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ActionIconButton(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (dialogContext) => BlocProvider.value(
                          value: context
                              .read<
                                CommitteesCubit
                              >(), // ← مهم تاخده من context الأصلي
                          child: EditCommitteeDialog(
                            committee: CreateCommitRequest(
                              type: type,
                              startDate: startDate,
                              endDate: endDate,
                              membersCount: int.parse(membersCount),
                              yearlyMeetingsCount: int.parse(meetingsPerYear),
                            ),
                            committeeId: index,
                          ),
                        ),
                      );
                    },
                    icon: Icons.edit,
                    iconColor: Colors.blue,
                    backgroundColor: Colors.blue.withOpacity(.1),
                    borderColor: Colors.blue,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ActionIconButton(
                    onTap: () {
                      final cubit = context.read<CommitteesCubit>();

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (dialogContext) => BlocProvider.value(
                          value: cubit,
                          child: BlocConsumer<CommitteesCubit, CommitteesState>(
                            listener: (context, state) {
                              if (state is DeleteCommitteesSuccess) {
                                final scaffoldMessenger = ScaffoldMessenger.of(
                                  context,
                                );
                                final navigator = Navigator.of(context);
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  navigator.pop();
                                  scaffoldMessenger.showSnackBar(
                                    const SnackBar(
                                      content: Text("تم الحذف بنجاح"),
                                    ),
                                  );
                                  cubit.getCommittees(
                                    CacheHelper.getData("companyId"),
                                  );
                                });
                              }
                              if (state is DeleteCommitteesError) {
                                final error = state.error;
                                final scaffoldMessenger = ScaffoldMessenger.of(
                                  context,
                                );
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  scaffoldMessenger.showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                });
                              }
                            },
                            builder: (context, state) => ConfirmDeleteDialog(
                              isLoading: state is DeleteCommitteesLoading,
                              onConfirm: () => cubit.deleteCommitteesById(
                                CacheHelper.getData("companyId"),
                                index, // ← id اللجنة
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
                      final cubit = context.read<CommitteesCubit>();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: cubit,
                            child: MembersPage(
                              cubit: cubit,
                              committeeId: index,
                            ),
                          ),
                        ),
                      );
                    },
                    icon: Icons.group,
                    iconColor: Colors.deepPurple,
                    backgroundColor: Colors.white,
                    borderColor: Colors.deepPurple,
                  ),
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: ActionIconButton(
                //     onTap: () => ComplaintDetailsDialog.show(context),
                //     icon: Icons.newspaper,
                //     iconColor: Colors.deepOrangeAccent,
                //     backgroundColor: Colors.white,
                //     borderColor: Colors.deepOrangeAccent,
                //   ),
                // ),
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
