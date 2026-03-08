import 'package:flutter/material.dart';

import 'chatMassage.dart';

class ChatBox extends StatelessWidget {
  final List<dynamic> messages;
  final TextEditingController messageController;
  final ScrollController scrollController;
  final VoidCallback onSend;

  final Color borderColor;
  final Color primaryColor;
  final Color hintColor;
  final Color backgroundColor;

  const ChatBox({
    super.key,
    required this.messages,
    required this.messageController,
    required this.scrollController,
    required this.onSend,
    this.borderColor = const Color(0xFFE0E0E0),
    this.primaryColor = Colors.green,
    this.hintColor = const Color(0xFFAAAAAA),
    this.backgroundColor = const Color(0xFFF9F9F9),
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Messages Area
            Container(
              constraints: const BoxConstraints(
                minHeight: 220,
                maxHeight: 320,
              ),
              child: messages.isEmpty
                  ? Center(
                child: Text(
                  'لا توجد رسائل بعد. ابدأ المحادثة!',
                  style: TextStyle(
                    color: hintColor,
                    fontSize: 14,
                  ),
                ),
              )
                  : ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return MessageBubble(
                    message: messages[index],
                  );
                },
              ),
            ),

            Divider(height: 1, thickness: 1, color: borderColor),

            /// Input Row
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      onSubmitted: (_) => onSend(),
                      decoration: InputDecoration(
                        hintText: 'اكتب رسالة...',
                        hintStyle: TextStyle(
                          color: hintColor,
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                          BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                          BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                          BorderSide(color: primaryColor),
                        ),
                        filled: true,
                        fillColor: backgroundColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onSend,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.send,
                        color: primaryColor,
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
    );
  }
}