import 'package:alhamd/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ViewModel/organization_cubit.dart';
import '../../model/EditMeetingRequestModel.dart';

Future<void> showEditMeetingDialog({
  required BuildContext context,
  required String companyId,
  required int meetingRequestId,
  required DateTime currentStartTime,
  required OrganizationCubit cubit,
}) async {
  DateTime selectedDateTime = currentStartTime;

  await showDialog(
    context: context,
    builder: (dialogContext) {
      return BlocListener<OrganizationCubit, OrganizationState>(
        bloc: cubit,
        listener: (listenerContext, state) {
          if (state is EditMeetingSuccess) {
            Navigator.pop(dialogContext);
            Navigator.pop(dialogContext);

            // ✅ استخدم context الأصلي بتاع الـ sheet مش context الدايلوج
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تم تعديل الموعد بنجاح 🎉"),
                  backgroundColor: Colors.green,
                ),
              );
            });
            cubit.getCompanyMeetingsRequests(companyId);
          }
          if (state is EditMeetingError) {
            Navigator.pop(dialogContext);
            Navigator.pop(dialogContext);

            // SchedulerBinding.instance.addPostFrameCallback((_) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       content: Text(state.message),
            //       backgroundColor: Colors.red,
            //     ),
            //   );
            // });
            cubit.getCompanyMeetingsRequests(companyId);
          }
        },
        child: StatefulBuilder(
          builder: (statefulContext, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              // ── Title ──
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "تعديل الوعد",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(dialogContext),
                  ),
                ],
              ),

              // ── Content ──
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "تاريخ ووقت بدء الاجتماع",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ── حقل التاريخ والوقت ──
                  GestureDetector(
                    onTap: () async {
                      // ✅ استخدم dialogContext مش statefulContext
                      final pickedDate = await showDatePicker(
                        context: dialogContext,
                        // ✅ الحل — لو التاريخ في الماضي ابدأ من النهارده
                        initialDate: selectedDateTime.isBefore(DateTime.now())
                            ? DateTime.now()
                            : selectedDateTime,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate == null) return;

                      // ✅ استخدم dialogContext هنا كمان
                      final pickedTime = await showTimePicker(
                        context: dialogContext,
                        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                      );
                      if (pickedTime == null) return;

                      setState(() {
                        selectedDateTime = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${selectedDateTime.year}/${selectedDateTime.month.toString().padLeft(2, '0')}/${selectedDateTime.day.toString().padLeft(2, '0')}  "
                        "${selectedDateTime.hour.toString().padLeft(2, '0')}:${selectedDateTime.minute.toString().padLeft(2, '0')}",
                        textAlign: TextAlign.end,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── الأزرار في النص ✅ ──
                  BlocBuilder<OrganizationCubit, OrganizationState>(
                    bloc: cubit,
                    builder: (context, state) {
                      final isLoading = state is EditMeetingLoading;
                      return Row(
                        children: [
                          // زر حفظ
                          Expanded(
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      final model = EditMeetingRequestModel(
                                        startTime: selectedDateTime,
                                      );
                                      cubit.editMeetingTime(
                                        companyId,
                                        meetingRequestId,
                                        model,
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryOlive,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      "حفظ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // زر إلغاء بحواف ذهبية ✅
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                side: BorderSide(
                                  color: AppColors.primaryOlive, // ✅ حواف ذهبية
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "إلغاء",
                                style: TextStyle(color: AppColors.primaryOlive),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              // ✅ فاضي — الأزرار اتنقلت للـ content
              actions: const [],
            );
          },
        ),
      );
    },
  );
}
