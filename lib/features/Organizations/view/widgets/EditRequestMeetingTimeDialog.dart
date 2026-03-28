import 'package:flutter/material.dart';
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
        listener: (context, state) {
          if (state is EditMeetingSuccess) {
            Navigator.pop(dialogContext);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("تم تعديل الموعد بنجاح 🎉"),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is EditMeetingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "تعديل الوعد",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(dialogContext),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "تاريخ ووقت بدء الاجتماع",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  // ── حقل التاريخ والوقت ──
                  GestureDetector(
                    onTap: () async {
                      // 1) اختيار التاريخ
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDateTime,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate == null) return;

                      // 2) اختيار الوقت
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime:
                        TimeOfDay.fromDateTime(selectedDateTime),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${selectedDateTime.year}/${selectedDateTime.month.toString().padLeft(2, '0')}/${selectedDateTime.day.toString().padLeft(2, '0')}  ${selectedDateTime.hour.toString().padLeft(2, '0')}:${selectedDateTime.minute.toString().padLeft(2, '0')}",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                // زر إلغاء
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("إلغاء"),
                  ),
                ),
                const SizedBox(width: 12),
                // زر حفظ
                Expanded(
                  child: BlocBuilder<OrganizationCubit, OrganizationState>(
                    bloc: cubit,
                    builder: (context, state) {
                      final isLoading = state is EditMeetingLoading;
                      return ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                          final model = EditMeetingRequestModel(
                            startTime:
                            selectedDateTime,
                          );
                          cubit.editMeetingTime(
                            companyId,
                            meetingRequestId,
                            model,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7D7D3C),
                          padding: const EdgeInsets.symmetric(vertical: 14),
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
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}