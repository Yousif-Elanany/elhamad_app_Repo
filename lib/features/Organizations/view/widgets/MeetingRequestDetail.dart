import 'package:alhamd/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ViewModel/organization_cubit.dart';
import 'EditRequestMeetingTimeDialog.dart';

void showMeetingDetailsSheet({
  required BuildContext context,
  required String companyId,
  required int meetingId,
  required OrganizationCubit cubit,
}) {
  cubit.getCompanyMeetingDetail(companyId, meetingId);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      return BlocConsumer<OrganizationCubit, OrganizationState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is EditMeetingSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("تم تعديل الموعد بنجاح 🎉"),
                backgroundColor: Colors.green,
              ),
            );
            cubit.getCompanyMeetingDetail(companyId, meetingId);
          }
          if (state is CancelMeetingSuccess) {
            Navigator.pop(sheetContext);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("تم الغاء الموعد بنجاح 🎉"),
                backgroundColor: Colors.green,
              ),
            );
            cubit.getCompanyMeetingsRequests(companyId);
          }
          if (state is CancelMeetingError) {
            Navigator.pop(sheetContext);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.primaryOlive,
              ),
            );
            cubit.getCompanyMeetingsRequests(companyId);
          }
          if (state is EditMeetingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.primaryOlive,
              ),
            );
          }
        },
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                if (notification.extent <= notification.minExtent) {
                  Navigator.pop(sheetContext);
                  cubit.getCompanyMeetingsRequests(companyId);                // ✅ لو الشيت اتسحب لتحت النص ده — ينده الـ API

                }
                return true;
              },
              child: DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.75,
                minChildSize: 0.5,
                maxChildSize: 0.95,
                builder: (_, scrollController) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Header ──
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // عنوان + إغلاق
                            Row(
                              children: [
                                const Text(
                                  "تفاصيل الجمعيه",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // زر إلغاء
                                OutlinedButton.icon(
                                  onPressed: () {
                                    cubit.cancelMeetingRequest(
                                      companyId,
                                      meetingId,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  label: const Text(
                                    "إلغاء",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.red),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // زر تعديل — يظهر فقط لو البيانات اتحملت
                                if (state is GetMeetingDetailSuccess)
                                  OutlinedButton.icon(
                                    onPressed: () {
                                      showEditMeetingDialog(
                                        context: context,
                                        companyId: companyId,
                                        meetingRequestId: meetingId,
                                        currentStartTime:
                                            state.data.startTime ??
                                            DateTime.now(),
                                        cubit: cubit,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      size: 18,
                                    ),
                                    label: const Text("تعديل الموعد"),
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(sheetContext);
                                    cubit.getCompanyMeetingsRequests(companyId);
                                  },
                                  child: const Icon(Icons.close),
                                ),
                              ],
                            ),
                          ],
                        ),
              
                        const SizedBox(height: 20),
              
                        // ── Body ──
                        Expanded(
                          child: _buildBody(
                            state: state,
                            scrollController: scrollController,
                            companyId: companyId,
                            meetingId: meetingId,
                            cubit: cubit,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    },
  );
}

// ── Build Body ──
Widget _buildBody({
  required OrganizationState state,
  required ScrollController scrollController,
  required String companyId,
  required int meetingId,
  required OrganizationCubit cubit,
}) {
  // Loading
  if (state is GetMeetingDetailLoading) {
    return const Center(child: CircularProgressIndicator());
  }

  // Error
  if (state is GetMeetingDetailError) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 12),
          Text(
            state.error,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () =>
                cubit.getCompanyMeetingDetail(companyId, meetingId),
            icon: const Icon(Icons.refresh),
            label: const Text("إعادة المحاولة"),
          ),
        ],
      ),
    );
  }

  // Success
  if (state is GetMeetingDetailSuccess) {
    final meeting = state.data;
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
              label: "وقت البدء",
              value: meeting.startTime != null
                  ? _formatDateTime(meeting.startTime!)
                  : "-",
            ),
            const Divider(),
            _buildDetailRow(
              label: "نوع الإجراء",
              value: meeting.procedureType ?? "-",
            ),
            const Divider(),
            _buildDetailRow(
              label: "نوع الجمعيه",
              value: meeting.meetingType ?? "-",
            ),
            const Divider(),
            _buildDetailRow(label: "المدينة", value: meeting.city ?? "-"),
            const Divider(),
            _buildDetailRow(
              label: "مكان الاجتماع",
              value: meeting.meetingVenue ?? "-",
            ),
            const Divider(),
            _buildDetailRow(label: "الملاحظات", value: meeting.notes ?? "-"),
            const Divider(),
            _buildDetailRow(
              label: "مطلوب في",
              value: meeting.createdAt != null
                  ? _formatDateTime(meeting.createdAt!)
                  : "-",
            ),
            const Divider(),
            _buildStatusRow(status: meeting.status ?? "-"),
            const Divider(),

            // ── المرفقات ──
            const Text(
              "المرفقات",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            if (meeting.attachments.isEmpty)
              const Text("لا توجد مرفقات")
            else
              ...meeting.attachments.map(
                (a) => _buildAttachmentItem(
                  fileName: a.fileName ?? "",
                  onDownload: () {
                    // launchUrl(Uri.parse(a.url ?? ""));
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  return const SizedBox();
}

// ── Helpers ──

Widget _buildDetailRow({required String label, required String value}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(width: 8),

        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget _buildStatusRow({required String status}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "الحالة",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(status, style: const TextStyle(fontSize: 14)),
        ),
      ],
    ),
  );
}

Widget _buildAttachmentItem({
  required String fileName,
  required VoidCallback onDownload,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onDownload,
          child: const Icon(Icons.download_outlined, color: Colors.grey),
        ),
        Expanded(
          child: Text(
            fileName,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.insert_drive_file_outlined, color: Colors.grey),
      ],
    ),
  );
}

String _formatDateTime(DateTime dateTime) {
  return "${_dayName(dateTime.weekday)}، ${dateTime.day} ${_monthName(dateTime.month)} ${dateTime.year} في ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour < 12 ? 'ص' : 'م'}";
}

String _dayName(int weekday) {
  const days = [
    "الاثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
    "السبت",
    "الأحد",
  ];
  return days[weekday - 1];
}

String _monthName(int month) {
  const months = [
    "يناير",
    "فبراير",
    "مارس",
    "أبريل",
    "مايو",
    "يونيو",
    "يوليو",
    "أغسطس",
    "سبتمبر",
    "أكتوبر",
    "نوفمبر",
    "ديسمبر",
  ];
  return months[month - 1];
}
