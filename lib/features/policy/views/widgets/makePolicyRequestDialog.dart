import 'package:alhamd/localization_service.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/handleErrors/ValidationClass.dart';
import '../../../home/models/complainModel.dart';

enum MessageType { complaint, inquiry }

class makePolicyRequestDialog extends StatefulWidget {
  final ComplaintModel? model;
  makePolicyRequestDialog({super.key, this.model});

  /// Helper to show the dialog
  static Future<Map<String, dynamic>?> show(
    BuildContext context, {
    ComplaintModel? model,
  }) {
    return showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (_) => makePolicyRequestDialog(model: model),
    );
  }

  @override
  State<makePolicyRequestDialog> createState() =>
      _makePolicyRequestDialogState();
}

class _makePolicyRequestDialogState extends State<makePolicyRequestDialog> {
  MessageType? _selectedType;
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _notesontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Theme colors matching the screenshot
  static const Color _primaryColor = Color(0xFF6B7C5C); // olive green
  static const Color _borderColor = Color(0xFFDDDDDD);
  static const Color _labelColor = Color(0xFF333333);
  static const Color _hintColor = Color(0xFFAAAAAA);
  static const Color _cancelBorderColor = Color(0xFF6B7C5C);
  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      // Pre-fill fields if editing an existing request
      _messageController.text = widget.model!.content;
      _notesontroller.text = widget.model!.content;

      // You can also set _selectedType based on the model's type if needed
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(
        context,
      ).pop({'type': _selectedType, 'message': _messageController.text.trim()});
    }
  }

  void _onCancel() {
    Navigator.of(context).pop(null);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Policy_Request'.tr(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _primaryColor,
                      ),
                    ),
                    // Close button on the left (RTL: visually right side)
                    IconButton(
                      icon: const Icon(Icons.close, size: 22),
                      onPressed: _onCancel,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      color: _primaryColor,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Divider(
                  height: 20,
                  thickness: 1,
                  color: _borderColor,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Message Type ─────────────────────────
                    RichText(
                      text: TextSpan(
                        text: 'address'.tr(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _labelColor,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _messageController,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: 'ادخل العنوان',
                        hintStyle: const TextStyle(
                          color: _hintColor,
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: _borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: _borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: _primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        return SmartValidator.validate(
                          value,
                          fieldName: 'العنوان',
                          required: true,
                        );
                      },
                    ),

                    // Validation error for type
                    const SizedBox(height: 20),

                    // ── Message Text ─────────────────────────
                    RichText(
                      text: TextSpan(
                        text: 'notes'.tr(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _labelColor,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _messageController,
                      maxLines: 5,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: 'ادخل  الملاحظات',
                        hintStyle: const TextStyle(
                          color: _hintColor,
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: _borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: _borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: _primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        return SmartValidator.validate(
                          value,
                          fieldName: 'الملاحظات',
                          required: true,
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // ── Buttons ──────────────────────────────
                    Row(
                      children: [
                        // Save button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Force rebuild to show type error if needed
                              setState(() {});
                              _onSave();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
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
                        ),
                        const SizedBox(width: 12),
                        // Cancel button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _onCancel,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _cancelBorderColor,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(
                                color: _cancelBorderColor,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'إلغاء',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
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

// ── Reusable radio option widget ────────────────────────────────────────────
class _TypeOption extends StatelessWidget {
  final String label;
  final MessageType value;
  final MessageType? groupValue;
  final ValueChanged<MessageType?> onChanged;

  const _TypeOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool selected = groupValue == value;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFDDDDDD)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? const Color(0xFF6B7C5C)
                      : const Color(0xFFAAAAAA),
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF6B7C5C),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 10),

            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
            ),
          ],
        ),
      ),
    );
  }
}
