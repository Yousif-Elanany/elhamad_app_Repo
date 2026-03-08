import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/chatDialog.dart';

Future<void> showPolicyDialog(
  BuildContext context, {
  required String policyName,
}) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (_) => PolicyDialog(policyName: policyName),
  );
}

// ─── Policy Dialog ───────────────────────────────────────────────
class PolicyDialog extends StatefulWidget {
  final String policyName;
  const PolicyDialog({super.key, required this.policyName});

  @override
  State<PolicyDialog> createState() => _PolicyDialogState();
}

class _PolicyDialogState extends State<PolicyDialog>
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: TextField(
          controller: controller,
          maxLines: null,
          expands: true,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textDark,
            height: 1.7,
          ),
          decoration: const InputDecoration(
            hintText: 'اكتب تفاصيل السياسة هنا...',
            hintStyle: TextStyle(color: AppColors.white, fontSize: 14),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(16),
          ),
        ),
      ),
    );
  }
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
