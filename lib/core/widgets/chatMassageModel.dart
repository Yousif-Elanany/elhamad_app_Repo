class ChatMessage {
  final String text;
  final bool isMine;
  final DateTime time;

  ChatMessage({required this.text, required this.isMine, DateTime? time})
      : time = time ?? DateTime.now();
}
