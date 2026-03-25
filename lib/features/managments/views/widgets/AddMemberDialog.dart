import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';



// ─── Main Dialog ────────────────────────────────────────────────────────────

class AddMemberDialog extends StatefulWidget {
  const AddMemberDialog({super.key});

  @override
  State<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  int _step = 0;

  // Personal data
  final _nameEnCtrl = TextEditingController();
  final _nameArCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _nationalIdCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  DateTime? _birthDate;
  String? _nationality;

  // Job data
  String? _jobTitle;
  String? _memberType;
  DateTime _startDate = DateTime.now();
  File? _pickedImage;

  @override
  void dispose() {
    _nameEnCtrl.dispose();
    _nameArCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _nationalIdCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620, maxHeight: 720),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              _buildStepIndicator(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: _step == 0 ? _buildPersonalStep() : _buildJobStep(),
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEEDEA))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'إضافة عضو',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1C1C1C)),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: Color(0xFF9E9E9E)),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF5F4F0),
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }

  // ── Step Indicator ────────────────────────────────────────────────────────

  Widget _buildStepIndicator() {
    const steps = ['البيانات الشخصية', 'البيانات الوظيفية'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 4),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Expanded(
              child: Container(
                height: 2,
                color: i ~/ 2 < _step ? const Color(0xFF7a8c5e) : const Color(0xFFDDDDDD),
              ),
            );
          }
          final idx = i ~/ 2;
          final isActive = idx == _step;
          final isDone = idx < _step;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: isDone ? () => setState(() => _step = idx) : null,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: isActive
                      ? const Color(0xFF7a8c5e)
                      : isDone
                      ? const Color(0xFFc5d0a8)
                      : const Color(0xFFE0E0E0),
                  child: Text(
                    '${idx + 1}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isActive
                          ? Colors.white
                          : isDone
                          ? const Color(0xFF4a5a33)
                          : const Color(0xFF9E9E9E),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                steps[idx],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  color: isActive ? const Color(0xFF7a8c5e) : const Color(0xFF9E9E9E),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // ── Personal Step ─────────────────────────────────────────────────────────

  Widget _buildPersonalStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionTitle('البيانات الشخصية:'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _field('اسم الموظف (بالإنجليزية)', 'أدخل الاسم بالإنجليزية', _nameEnCtrl, required: true)),
            const SizedBox(width: 12),
            Expanded(child: _field('الإسم (باللغة العربية)', 'أدخل الاسم بالعربية', _nameArCtrl, required: true)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _datePicker('تاريخ الميلاد', _birthDate, (d) => setState(() => _birthDate = d), required: true)),
            const SizedBox(width: 12),
            Expanded(child: _field('رقم الهاتف', 'أدخل رقم الهاتف', _phoneCtrl, required: true, keyboardType: TextInputType.phone)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _field('البريد الإلكتروني', 'أدخل البريد الإلكتروني', _emailCtrl, required: true, keyboardType: TextInputType.emailAddress)),
            const SizedBox(width: 12),
            Expanded(child: _field('رقم الهوية', 'أدخل رقم الهوية الوطنية', _nationalIdCtrl, required: true)),
          ],
        ),
        const SizedBox(height: 12),
        _dropdown('الجنسية', ['سعودي', 'مصري', 'أردني', 'أخرى'], _nationality,
                (v) => setState(() => _nationality = v), optional: true),
        const SizedBox(height: 12),
        _multilineField('العنوان', 'أدخل تفاصيل العنوان', _addressCtrl, optional: true),
      ],
    );
  }

  // ── Job Step ──────────────────────────────────────────────────────────────

  Widget _buildJobStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionTitle('البيانات الوظيفية:'),
        const SizedBox(height: 16),
        _uploadArea(),
        const SizedBox(height: 16),
        _dropdown('المسمى الوظيفي', ['مدير', 'مهندس', 'محلل', 'مطور'], _jobTitle,
                (v) => setState(() => _jobTitle = v), required: true, hint: 'اختر المسمى الوظيفي'),
        const SizedBox(height: 12),
        _dropdown('نوع العضوية', ['عضو كامل', 'عضو مشارك', 'عضو شرفي'], _memberType,
                (v) => setState(() => _memberType = v), required: true),
        const SizedBox(height: 12),
        _datePicker('تاريخ البداية', _startDate, (d) => setState(() => _startDate = d), required: true),
      ],
    );
  }

  // ── Footer ────────────────────────────────────────────────────────────────

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFEEEDEA))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Cancel
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF555555),
              side: const BorderSide(color: Color(0xFFCCCCCC)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('إلغاء'),
          ),
          Row(
            children: [
              if (_step == 1) ...[
                OutlinedButton(
                  onPressed: () => setState(() => _step = 0),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF7a8c5e),
                    side: const BorderSide(color: Color(0xFF7a8c5e)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('السابق'),
                ),
                const SizedBox(width: 10),
              ],
              ElevatedButton(
                onPressed: () {
                  if (_step == 0) {
                    setState(() => _step = 1);
                  } else {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم الحفظ بنجاح!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7a8c5e),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Text(_step == 0 ? 'التالي' : 'حفظ',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _sectionTitle(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1C1C1C))),
        const SizedBox(height: 6),
        const Divider(color: Color(0xFFEEEDEA)),
      ],
    );
  }

  Widget _field(String label, String hint, TextEditingController ctrl,
      {bool required = false, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label, required: required),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          keyboardType: keyboardType,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 13),
          decoration: _inputDeco(hint),
        ),
      ],
    );
  }

  Widget _multilineField(String label, String hint, TextEditingController ctrl,
      {bool optional = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label, optional: optional),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          maxLines: 3,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 13),
          decoration: _inputDeco(hint),
        ),
      ],
    );
  }

  Widget _dropdown(String label, List<String> items, String? value, ValueChanged<String?> onChanged,
      {bool required = false, bool optional = false, String hint = 'اختر'}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label, required: required, optional: optional),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(fontSize: 13, color: Color(0xFFAAAAAA))),
          decoration: _inputDeco(''),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13))))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _datePicker(String label, DateTime? value, ValueChanged<DateTime> onPicked,
      {bool required = false}) {
    final display = value != null
        ? '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}'
        : 'اختر التاريخ';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label, required: required),
        const SizedBox(height: 4),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime(2100),
            );
            if (picked != null) onPicked(picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFCCCCCC)),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF9E9E9E)),
                Text(display,
                    style: TextStyle(
                        fontSize: 13,
                        color: value != null ? const Color(0xFF333333) : const Color(0xFFAAAAAA))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _uploadArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('الصورة الشخصية', optional: true),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () async {
            final result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc'],
            );
            if (result != null && result.files.single.path != null) {
              setState(() => _pickedImage = File(result.files.single.path!));
            }
          },
          child: _pickedImage != null
              ? _buildPreview()
              : _buildDropZone(),
        ),
      ],
    );
  }

  Widget _buildDropZone() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF9F9F7),
        border: Border.all(color: const Color(0xFFCCCCCC)),
      ),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEA),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(Icons.upload_file_outlined, color: Color(0xFF7a8c5e), size: 22),
          ),
          const SizedBox(height: 8),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
              children: [
                TextSpan(
                  text: 'اضغط للرفع',
                  style: TextStyle(
                    color: Color(0xFF7a8c5e),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: ' أو قم بسحب وإفالات للملف'),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Text('PDF,DOC,PNG أو JPG (2 MB)',
              style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA))),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    final name = _pickedImage!.path.split('/').last;
    final ext = name.split('.').last.toLowerCase();
    final isImage = ['jpg', 'jpeg', 'png'].contains(ext);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF0F3EA),
        border: Border.all(color: const Color(0xFF7a8c5e)),
      ),
      child: Row(
        children: [
          if (isImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.file(_pickedImage!, width: 48, height: 48, fit: BoxFit.cover),
            )
          else
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFDDE5CC),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.insert_drive_file_outlined, color: Color(0xFF7a8c5e)),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 13, color: Color(0xFF333333)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18, color: Color(0xFF888888)),
            onPressed: () => setState(() => _pickedImage = null),
          ),
        ],
      ),
    );
  }

  Widget _label(String text, {bool required = false, bool optional = false}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF444444)),
        children: [
          TextSpan(text: text),
          if (required)
            const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
          if (optional)
            const TextSpan(
                text: ' (اختياري)',
                style: TextStyle(color: Color(0xFFAAAAAA), fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }

  InputDecoration _inputDeco(String hint) {
    return InputDecoration(
      hintText: hint,
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
      filled: true,
      fillColor: Colors.white,
    );
  }
}