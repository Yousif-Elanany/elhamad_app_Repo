import 'package:alhamd/localization_service.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/handleErrors/ValidationClass.dart';
import '../../../compaines/views/widgets/addComplain.dart';
import '../../../home/models/complainModel.dart';


class AddPolicyRequestDialog extends StatefulWidget {
  final ComplaintModel? model;
  AddPolicyRequestDialog({super.key, this.model});

  /// Helper to show the dialog
  static Future<Map<String, dynamic>?> show(
      BuildContext context, {
        ComplaintModel? model,
      }) {
    return showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AddPolicyRequestDialog(model: model),
    );
  }

  @override
  State<AddPolicyRequestDialog> createState() =>
      _AddPolicyRequestDialogState();
}

class _AddPolicyRequestDialogState extends State<AddPolicyRequestDialog> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _notesontroller = TextEditingController();
  bool get isAr => LocalizationService.getLang() == 'ar';

  final _formKey = GlobalKey<FormState>();
  final Color primaryOlive = const Color(0xFF8B8B6B);

  // Theme colors matching the screenshot
  static const Color _primaryColor = Color(0xFF6B7C5C); // olive green
  static const Color _borderColor = Color(0xFFDDDDDD);
  static const Color _labelColor = Color(0xFF333333);
  static const Color _hintColor = Color(0xFFAAAAAA);
  static const Color _cancelBorderColor = Color(0xFF6B7C5C);
  MessageType? _selectedType;
  final TextEditingController nameController = TextEditingController();

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
                      'add_policy'.tr(),
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
                        text: 'Policy Name'.tr(),
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
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: 'Policy Name'.tr(),
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
                          fieldName:'Policy Name'.tr(),
                          required: true,
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    _buildField(
                      label:'Select Template'.tr(),
                      hint: "choose".tr(),
                      controller: nameController,
                      isRequired: true,
                      isDropdown: true,
                      items: ["عادي", "غير عادي"],
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
  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    IconData? suffixIcon,
    bool isHighlighted = false,
    bool isDropdown = false,
    int maxLines = 1,
    bool isRequired = false,
    List<String>? items,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔴 Label + Star
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isRequired)
                const Text(
                  " *",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 6),

          /// 🔄 Dropdown or TextField
          isDropdown
              ? DropdownButtonFormField<String>(
            value: controller.text.isEmpty ? null : controller.text,
            items: items
                ?.map(
                  (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ),
            )
                .toList(),
            onChanged: (value) {
              controller.text = value ?? '';
            },
            validator: (value) {
              return SmartValidator.validate(
                value,
                fieldName: label,
                required: isRequired,
              );
            },
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: isHighlighted
                  ? primaryOlive.withOpacity(0.08)
                  : Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isHighlighted
                      ? primaryOlive
                      : Colors.grey.shade300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: primaryOlive, width: 1.5),
              ),
            ),
          )
              : TextFormField(
            controller: controller,
            maxLines: maxLines,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlign: isAr ? TextAlign.right : TextAlign.left,
            validator: (value) {
              return SmartValidator.validate(
                value,
                fieldName: label,
                required: isRequired,
              );
            },
            onChanged: (value) {
              _formKey.currentState?.validate();
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
              suffixIcon: suffixIcon != null
                  ? Icon(suffixIcon, size: 18)
                  : null,
              filled: true,
              fillColor: isHighlighted
                  ? primaryOlive.withOpacity(0.08)
                  : Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isHighlighted
                      ? primaryOlive
                      : Colors.grey.shade300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: primaryOlive, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

