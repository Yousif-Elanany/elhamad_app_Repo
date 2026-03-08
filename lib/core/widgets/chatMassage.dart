// ── Message bubble ────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import 'chatMassageModel.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({required this.message});

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