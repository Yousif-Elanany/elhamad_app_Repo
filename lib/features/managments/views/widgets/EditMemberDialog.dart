import 'package:flutter/material.dart';

import '../../Models/editMemberOfBoardRequestModel.dart';

class EditMemberJobDialog extends StatefulWidget {
  final String? initialJobTitle;
  final String? initialMemberType;

  const EditMemberJobDialog({
    super.key,
    this.initialJobTitle,
    this.initialMemberType,
  });

  static Future<void> show(
    BuildContext context, {
    String? initialJobTitle,
    String? initialMemberType,
  }) {
    return showDialog(
      context: context,
      builder: (_) => EditMemberJobDialog(
        initialJobTitle: initialJobTitle,
        initialMemberType: initialMemberType,
        //  onSave: onSave,
      ),
    );
  }

  @override
  State<EditMemberJobDialog> createState() => _EditMemberJobDialogState();
}

class _EditMemberJobDialogState extends State<EditMemberJobDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _jobTitle;
  String? _memberType;

  final Map<String, String> jobTitles = {
    'مدير': '0',
    'مهندس': '1',
    'محلل': '2',
    'مطور': '3',
  };

  final Map<String, String> memberTypesMap = {
    'عضو كامل': 'Executive',
    'عضو مشارك': 'Associate',
    'عضو شرفي': 'Honorary',
  };

  @override
  void initState() {
    super.initState();

    _jobTitle = widget.initialJobTitle;

    _memberType = memberTypesMap.entries
        .firstWhere(
          (e) => e.value == widget.initialMemberType,
          orElse: () => const MapEntry('', ''),
        )
        .key;

    if (_memberType == '') _memberType = null;
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      // widget.onSave(
      //   EditMemberOfBoardModel(
      //     jobTitle: jobTitles[_jobTitle!]!,  // ✅ بيبعت '0','1','2','3'
      //     membershipType: _memberType!,
      //   ),
      // );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'تعديل البيانات الوظيفية',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Color(0xFF9E9E9E)),
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFF5F4F0),
                        shape: const CircleBorder(),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),

                // ── Job Title ──
                _dropdown(
                  'المسمى الوظيفي',
                  jobTitles.keys.toList(),
                  _jobTitle,
                  (v) => setState(() => _jobTitle = v),
                  required: true,
                  hint: 'اختر المسمى الوظيفي',
                ),
                const SizedBox(height: 12),

                // ── Member Type ──
                _dropdown(
                  'نوع العضوية',
                  memberTypesMap.keys.toList(),
                  _memberType,
                  (v) => setState(() => _memberType = v),
                ),
                const SizedBox(height: 24),

                // ── Buttons ──
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF555555),
                          side: const BorderSide(color: Color(0xFFCCCCCC)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('إلغاء'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _onSave,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7a8c5e),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'حفظ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Dropdown Helper ──
  Widget _dropdown(
    String label,
    List<String> items,
    String? value,
    ValueChanged<String?> onChanged, {
    bool required = false,
    String hint = 'اختر',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label, required: required),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: items.contains(value) ? value : null,
          // ✅ يمنع الكراش
          isExpanded: true,
          hint: Text(
            hint,
            style: const TextStyle(fontSize: 13, color: Color(0xFFAAAAAA)),
          ),
          decoration: _inputDeco(),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 13)),
                ),
              )
              .toList(),
          onChanged: onChanged,
          validator: required
              ? (v) => v == null ? 'هذا الحقل مطلوب.' : null
              : null,
        ),
      ],
    );
  }

  Widget _label(String text, {bool required = false}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF444444),
        ),
        children: [
          TextSpan(text: text),
          if (required)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  InputDecoration _inputDeco() {
    return InputDecoration(
      hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF7a8c5e), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
