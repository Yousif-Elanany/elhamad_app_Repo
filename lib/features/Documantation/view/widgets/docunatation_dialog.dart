import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/chatDialog.dart';
enum DocumentStatus { approved, pending, rejected }

 showDocumantationDialog(
    BuildContext context, {
      required String policyName,
    }) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (_) => DocumantationDialog(policyName: policyName),
  );
}

// ─── Policy Dialog ───────────────────────────────────────────────
class DocumantationDialog extends StatefulWidget {
  final String policyName;
  const DocumantationDialog({super.key, required this.policyName});

  @override
  State<DocumantationDialog> createState() => _DocumantationDialogState();
}

class _DocumantationDialogState extends State<DocumantationDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Container(
        // width: 520,
        constraints: const BoxConstraints(maxHeight: 680),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 40,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ──
            _DialogHeader(
              title: widget.policyName,
              onClose: () => Navigator.of(context).pop(),
            ),

            // ── Tabs ──
            _DialogTabs(controller: _tabController),

            // ── Tab Content ──
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab 0: تفاصيل السياسة
                  _DetailsTab(controller: _detailsController),

                  // Tab 1: التعليقات
                  const _CommentsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Dialog Header ───────────────────────────────────────────────
class _DialogHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;
  const _DialogHeader({required this.title, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          // Close button (left side in RTL = visual right)

          // Title
          Text(
            ' $title *',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          const Spacer(),

          GestureDetector(
            onTap: onClose,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.close, size: 18, color: AppColors.primaryOlive),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Dialog Tabs ─────────────────────────────────────────────────
class _DialogTabs extends StatelessWidget {
  final TabController controller;
  const _DialogTabs({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: TabBar(
        controller: controller,
        labelColor: AppColors.primaryOlive,
        unselectedLabelColor: AppColors.textGrey,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          fontFamily: 'Cairo',
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Cairo',
        ),
        indicatorColor: AppColors.primary,
        indicatorWeight: 2.5,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [
          Tab(text: 'تفاصيل السياسة'),
          Tab(text: 'التعليقات'),
        ],
      ),
    );
  }
}

// ─── Tab 0: تفاصيل السياسة ───────────────────────────────────────
class _DetailsTab extends StatelessWidget {
  final TextEditingController controller;
  const _DetailsTab({required this.controller});

  @override
  Widget build(BuildContext context) {

    return  Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: DocumentDetailsCard(
          documentName: 'اسم الوثيقة *',
          submittedBy: 'مدير النظام',
          createdAt: 'الثلاثاء، 3 مارس 2026 في 12:12 ص',
          companyName: 'اضافه شركه تيست',
          status: DocumentStatus.approved,
          notes: 'الوصف (اختياري)',
        ),
      ),

    );
  }
}
class DocumentDetailsCard extends StatelessWidget {
  final String documentName;
  final String submittedBy;
  final String createdAt;
  final String companyName;
  final DocumentStatus status;
  final String? notes;

  const DocumentDetailsCard({
    super.key,
    required this.documentName,
    required this.submittedBy,
    required this.createdAt,
    required this.companyName,
    required this.status,
    this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRow(
            label: 'العنوان',
            value: documentName,
            valueStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          _buildDivider(),
          _buildRow(label: 'مقدم الطلب', value: submittedBy),
          _buildDivider(),
          _buildRow(label: 'تاريخ الإنشاء', value: createdAt),
          _buildDivider(),
          _buildRow(label: 'اسم الشركة', value: companyName),
          _buildDivider(),
          _buildStatusRow(),
          _buildDivider(),
          _buildNotesRow(),
        ],
      ),
    );
  }

  Widget _buildRow({
    required String label,
    required String value,
    TextStyle? valueStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF999999),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: valueStyle ??
                  const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2A2A2A),
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Status badge

          const SizedBox(
            width: 90,
            child: Text(
              'الحالة',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF999999),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 40),

          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: _StatusBadge(status: status),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Label row
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 14, bottom: 8),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'ملاحظات',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF999999),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        // Notes text area
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            notes ?? '',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF888888),
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0));
  }
}

class _StatusBadge extends StatelessWidget {
  final DocumentStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _statusConfig(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: config.borderColor),
      ),
      child: Text(
        config.label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: config.textColor,
        ),
      ),
    );
  }

  _StatusConfig _statusConfig(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.approved:
        return _StatusConfig(
          label: 'تم الموافقة',
          textColor: const Color(0xFF2E7D52),
          backgroundColor: const Color(0xFFEAF6EF),
          borderColor: const Color(0xFFB2DFC5),
        );
      case DocumentStatus.pending:
        return _StatusConfig(
          label: 'قيد الانتظار',
          textColor: const Color(0xFF7A5C00),
          backgroundColor: const Color(0xFFFFF8E1),
          borderColor: const Color(0xFFFFE082),
        );
      case DocumentStatus.rejected:
        return _StatusConfig(
          label: 'مرفوض',
          textColor: const Color(0xFFC62828),
          backgroundColor: const Color(0xFFFFEBEE),
          borderColor: const Color(0xFFEF9A9A),
        );
    }
  }
}

class _StatusConfig {
  final String label;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;

  _StatusConfig({
    required this.label,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
  });
}

// ─── Tab 1: التعليقات ────────────────────────────────────────────
class _CommentsTab extends StatefulWidget {
  const _CommentsTab();

  @override
  State<_CommentsTab> createState() => _CommentsTabState();
}

class _CommentsTabState extends State<_CommentsTab> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Messages list — replace with your real data/state management
  final List<_ChatMessage> _messages = [];

  static const Color _primaryColor = Color(0xFF6B7C5C);
  static const Color _borderColor = Color(0xFFE0E0E0);
  static const Color _bgColor = Color(0xFFF5F5F5);
  static const Color _hintColor = Color(0xFFAAAAAA);

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(text: text, isMine: true));
      _messageController.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [

          Flexible(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: _borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Section title

                  // Messages area
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 220,
                      maxHeight: 320,
                    ),
                    child: _messages.isEmpty
                        ? const Center(
                      child: Text(
                        'لا توجد رسائل بعد. ابدأ المحادثة!',
                        style: TextStyle(
                          color: Color(0xFFAAAAAA),
                          fontSize: 14,
                        ),
                      ),
                    )
                        : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return _MessageBubble(message: _messages[index]);
                      },
                    ),
                  ),

                  const Divider(height: 1, thickness: 1, color: _borderColor),

                  // Input row
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        // Text field
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            onSubmitted: (_) => _sendMessage(),
                            decoration: InputDecoration(
                              hintText: 'اكتب رسالة...',
                              hintStyle: const TextStyle(
                                color: _hintColor,
                                fontSize: 14,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: _borderColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: _borderColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: _primaryColor,
                                ),
                              ),
                              filled: true,
                              fillColor: _bgColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Send icon button
                        GestureDetector(
                          onTap: _sendMessage,
                          child: const Padding(
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Icons.send,
                              color: _primaryColor,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data model ───────────────────────────────────────────────────────────────
class _ChatMessage {
  final String text;
  final bool isMine;
  final DateTime time;

  _ChatMessage({required this.text, required this.isMine, DateTime? time})
      : time = time ?? DateTime.now();
}

// ── Message bubble ────────────────────────────────────────────────────────────
class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMine;

    return Align(
      alignment: isMine ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.65,
        ),
        decoration: BoxDecoration(
          color: isMine ? const Color(0xFF6B7C5C) : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isMine ? Radius.zero : const Radius.circular(12),
            bottomRight: isMine ? const Radius.circular(12) : Radius.zero,
          ),
        ),
        child: Text(
          message.text,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 14,
            color: isMine ? Colors.white : const Color(0xFF333333),
          ),
        ),
      ),
    );
  }
}
