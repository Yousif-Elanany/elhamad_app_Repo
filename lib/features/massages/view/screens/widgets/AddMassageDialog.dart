import 'package:alhamd/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

void showSendMessageDialog(BuildContext context) {
  showDialog(context: context, builder: (_) => const SendMessageDialog());
}

class SendMessageDialog extends StatefulWidget {
  const SendMessageDialog({super.key});

  @override
  State<SendMessageDialog> createState() => _SendMessageDialogState();
}

class _SendMessageDialogState extends State<SendMessageDialog> {
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  String? _sendVia;

  static const Color _green = Color(0xFF6B8C5A);
  String? _selectedRecipient;

  @override
  void dispose() {
    _recipientController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: SizedBox(
        width: 700,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Header ──
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ارسال رسالة',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryOlive,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: AppColors.primaryOlive,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, thickness: 1, color: AppColors.primaryOlive),

              // ── Form ──
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // رسالة الي
                    _FormLabel(label: 'رسالة الي', required: true),
                    const SizedBox(height: 8),
                    _RecipientField(
                      items: const ['موظف 1', 'موظف 2', 'موظف 3'], // أو من API
                      value: _selectedRecipient,
                      onChanged: (v) => setState(() => _selectedRecipient = v),
                    ),                      const SizedBox(height: 20),

                    // عنوان الرسالة
                    _FormLabel(label: 'عنوان الرسالة', required: true),
                    const SizedBox(height: 8),
                    _StyledTextField(controller: _titleController),
                    const SizedBox(height: 20),

                    // نص الرسالة
                    _FormLabel(label: 'نص الرسالة', required: true),
                    const SizedBox(height: 8),
                    _StyledTextField(
                      controller: _bodyController,
                      hint: 'ادخل نص الرسالة',
                      maxLines: 5,
                    ),
                    const SizedBox(height: 20),

                    // ارسال عبر
                    _FormLabel(label: 'ارسال عبر', required: true),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(
                          child: _RadioOption(
                            label: 'رسالة نصية',
                            value: 'sms',
                            groupValue: _sendVia,
                            onChanged: (v) => setState(() => _sendVia = v),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _RadioOption(
                            label: 'البريد الإلكتروني',
                            value: 'email',
                            groupValue: _sendVia,
                            onChanged: (v) => setState(() => _sendVia = v),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _RadioOption(
                            label: 'تطبيق الجوال',
                            value: 'app',
                            groupValue: _sendVia,
                            onChanged: (v) => setState(() => _sendVia = v),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // save logic
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryOlive,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'حفظ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryOlive,
                            side:  BorderSide(color: AppColors.primaryOlive),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            'إلغاء',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
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

// ─────────────────────────────────────────────
// Reusable Widgets
// ─────────────────────────────────────────────

class _FormLabel extends StatelessWidget {
  final String label;
  final bool required;
  const _FormLabel({required this.label, this.required = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        if (required)
          const Text(
            ' *',
            style: TextStyle(
              color: Color(0xFFE53E3E),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}

class _RecipientField extends StatefulWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const _RecipientField({
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  State<_RecipientField> createState() => _RecipientFieldState();
}

class _RecipientFieldState extends State<_RecipientField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCCCCCC)),
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      padding:  EdgeInsets.symmetric(horizontal: 14),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: AppColors.white,
          value: widget.value,
          hint:  Text(
            'اختر',
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
          ),
          isExpanded: true,
          alignment: AlignmentDirectional.centerStart,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF555555)),
          items: widget.items
              .map((item) => DropdownMenuItem<String>(
            value: item,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              item,
              textDirection: TextDirection.ltr,
              style:  TextStyle(fontSize: 14,color:  AppColors.primaryOlive),
            ),
          ))
              .toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}

class _StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const _StyledTextField({
    required this.controller,
    this.hint = '',
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFF6B8C5A)),
        ),
      ),
    );
  }
}

class _RadioOption extends StatelessWidget {
  final String label;
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const _RadioOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryOlive),
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: AppColors.primaryOlive,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 11, color: AppColors.primaryOlive),
            ),
          ],
        ),
      ),
    );
  }
}
