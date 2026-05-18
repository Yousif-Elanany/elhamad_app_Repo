import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/cache_helper.dart';
import '../../Model/PolicyRequestDetailModel.dart';
import '../../viewModel/policy_cubit.dart';

// ==================== HOW TO USE ====================
// showDialog(
//   context: context,
//   builder: (_) => PolicyRequestDetailsDialog(
//     requestId: item.id,
//     cubit: context.read<PolicyCubit>(),
//   ),
// );

class PolicyRequestDetailsDialog extends StatefulWidget {
  final int requestId;
  final PolicyCubit cubit;

  const PolicyRequestDetailsDialog({
    super.key,
    required this.requestId,
    required this.cubit,
  });

  @override
  State<PolicyRequestDetailsDialog> createState() =>
      _PolicyRequestDetailsDialogState();
}

class _PolicyRequestDetailsDialogState extends State<PolicyRequestDetailsDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    widget.cubit.getPoliciesRequestById(
      CacheHelper.getData("companyId"),
      widget.requestId,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    const months = [
      '',
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    const weekDays = [
      '',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    int hour = date.hour % 12;
    if (hour == 0) hour = 12;
    final period = date.hour >= 12 ? 'م' : 'ص';
    final minute = date.minute.toString().padLeft(2, '0');
    return '${weekDays[date.weekday]}، ${date.day} ${months[date.month]} ${date.year} في $hour:$minute $period';
  }

  String _getStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'في انتظار المراجعة';
      case 'awaitingchanges':
        return 'في انتظار التغييرات';
      case 'approved':
        return 'موافق عليه';
      case 'rejected':
        return 'مرفوض';
      case 'failed':
        return 'فشل';
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'awaitingchanges':
        return const Color(0xFF6B7280);
      case 'approved':
        return Colors.green;
      case 'rejected':
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusBorderColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'awaitingchanges':
        return const Color(0xFFD1D5DB);
      case 'approved':
        return Colors.green;
      case 'rejected':
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cubit,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        backgroundColor: Colors.white,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520, maxHeight: 680),
          child: BlocBuilder<PolicyCubit, PolicyState>(
            builder: (context, state) {
              // ---- Header title ----
              String headerTitle = 'تفاصيل طلب السياسة';
              if (state is GetPolicyRequestByIdSuccess) {
                headerTitle = 'تفاصيل طلب السياسة ';
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(context, headerTitle),
                  _buildTabs(),
                  Flexible(child: _buildBody(state)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(PolicyState state) {
    if (state is GetPolicyRequestByIdLoading) {
      return const Padding(
        padding: EdgeInsets.all(48),
        child: CircularProgressIndicator(),
      );
    }

    if (state is GetPolicyRequestByIdError) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 12),
            Text(state.message, style: const TextStyle(color: Colors.red)),
          ],
        ),
      );
    }

    if (state is GetPolicyRequestByIdSuccess) {
      return TabBarView(
        controller: _tabController,
        children: [_buildDetailsTab(state.data), _buildCommentsTab()],
      );
    }

    // initial / other states
    return const Padding(
      padding: EdgeInsets.all(48),
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              widget.cubit.fetchPoliciesRequests(
                CacheHelper.getData("companyId"),
              );
            },

            child: const Icon(Icons.close, size: 20, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.black,
        indicatorWeight: 2,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        tabs: const [
          Tab(text: 'تفاصيل طلب السياسة'),
          Tab(text: 'التعليقات'),
        ],
      ),
    );
  }

  Widget _buildDetailsTab(GetPolicyRequestDetailModel d) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          children: [
            _detailRow('العنوان', d.title),
            _divider(),
            _detailRow('مقدم الطلب', d.requestedByName),
            _divider(),
            _detailRow('تاريخ الإنشاء', _formatDate(d.createdAt)),
            _divider(),
            _detailRow('اسم الشركة', d.companyName),
            _divider(),
            _detailRowWidget('الحالة', _buildStatusBadge(d.status)),
            _divider(),
            _detailRow('تم تغير الحالة في', _formatDate(d.statusUpdatedAt)),
            _divider(),
            _detailRowNotes('ملاحظات', d.notes),
            if (d.rejectionReason != null &&
                d.rejectionReason.toString().isNotEmpty) ...[
              _divider(),
              _detailRowNotes(
                'سبب الرفض',
                d.rejectionReason.toString(),
                isRed: true,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRowWidget(String label, Widget valueWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(alignment: Alignment.centerRight, child: valueWidget),
          ),
        ],
      ),
    );
  }

  Widget _detailRowNotes(String label, String value, {bool isRed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isRed
                    ? const Color(0xFFFFEEEE)
                    : const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 14,
                  color: isRed ? Colors.red : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _getStatusBorderColor(status)),
      ),
      child: Text(
        _getStatusLabel(status),
        style: TextStyle(
          fontSize: 13,
          color: _getStatusColor(status),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _divider() => const Divider(height: 1, color: Color(0xFFE5E7EB));

  Widget _buildCommentsTab() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.comment_outlined, size: 48, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              'لا توجد تعليقات',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
