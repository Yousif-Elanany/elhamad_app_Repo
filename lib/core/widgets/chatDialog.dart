import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ComplaintDetailsDialog extends StatefulWidget {
  final String title;

  const ComplaintDetailsDialog({super.key, this.title = 'مسال مول'});

  /// Helper to show the dialog
  static Future<void> show(BuildContext context, {String title = 'مسال مول'}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => ComplaintDetailsDialog(title: title),
    );
  }

  @override
  State<ComplaintDetailsDialog> createState() => _ComplaintDetailsDialogState();
}

class _ComplaintDetailsDialogState extends State<ComplaintDetailsDialog> {
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style:  TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryOlive,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 22,
                      color: AppColors.primaryOlive,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, thickness: 1, color: _borderColor),
             Padding(
              padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Text(
                'تفاصيل الشكوى',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryOlive
                ),
              ),
            ),
            // ── Body card ────────────────────────────────────
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
                                return _MessageBubble(
                                  message: _messages[index],
                                );
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
