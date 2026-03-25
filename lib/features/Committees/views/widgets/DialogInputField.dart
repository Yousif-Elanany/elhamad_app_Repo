import 'package:flutter/material.dart';

class DialogInputField extends StatelessWidget {
  final String label;
  final String? hint;
  final bool isDatePicker;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool isNumber;

  const DialogInputField(
      this.label, {
        super.key,
        this.hint,
        this.isDatePicker = false,
        this.controller,
        this.onTap,
        this.isNumber = false,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: isDatePicker,
          onTap: isDatePicker ? onTap : null,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: hint ?? (isDatePicker ? "اختر التاريخ" : ""),
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            filled: true,
            fillColor: const Color(0xFFF9F9F9),
            prefixIcon: isDatePicker
                ? const Icon(Icons.calendar_month_outlined, size: 18, color: Colors.grey)
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return "هذا الحقل مطلوب";
            if (isNumber) {
              final number = int.tryParse(value);
              if (number == null || number < 1) return "يجب أن يكون الرقم أكبر من 0";
            }
            return null;
          },
        ),
      ],
    );
  }
}