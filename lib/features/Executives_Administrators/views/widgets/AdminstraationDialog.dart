import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../../../localization_service.dart';

class AddContributorDialog extends StatefulWidget {
  const AddContributorDialog({super.key});

  @override
  State<AddContributorDialog> createState() => _AddContributorDialogState();
}

class _AddContributorDialogState extends State<AddContributorDialog> {
  final _formKey = GlobalKey<FormState>();

  // Personal
  final _nameArController = TextEditingController();
  final _nameEnController = TextEditingController();
  final _idController = TextEditingController();
  String? _selectedNationality;
  String? _selectedResidence;
  final _birthdateController = TextEditingController();

  // Membership
  String? _selectedJobTitle;
  String? _selectedJobRole;

  // Contact
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  PlatformFile? _profilePhoto;
  PlatformFile? _authPhoto;
  // Status
  bool _isActive = true;
  bool _canViewPrivate = false;

  // Upload labels
  String _profilePhotoLabel = 'اضغط للرفع أو قم بسحب وافلات للملف';
  String _authPhotoLabel = 'اضغط للرفع أو قم بسحب وافلات للملف';

  static const _green = Color(0xFF3A6B3A);
  static const _lightGreen = Color(0xFFE8F0E8);
  static const _borderColor = Color(0xFFDDE5DD);
  static const _labelColor = Color(0xFF444444);

  Future<void> _selectHijriDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final hijri = HijriCalendar.fromDate(picked);

      const hijriMonths = [
        'محرم', 'صفر', 'ربيع الأول', 'ربيع الثاني',
        'جمادى الأولى', 'جمادى الآخرة', 'رجب', 'شعبان',
        'رمضان', 'شوال', 'ذو القعدة', 'ذو الحجة',
      ];

      final monthName = hijriMonths[hijri.hMonth - 1];

      _birthdateController.text =
      "${hijri.hDay.toString().padLeft(2, '0')} $monthName ${hijri.hYear}";
    }
  }

  Future<PlatformFile?> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;

      // تحقق من الحجم (2MB)
      if (file.size <= 2 * 1024 * 1024) {
        return file;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حجم الملف يجب ألا يتجاوز 2MB')),
        );
      }
    }

    return null;
  }

  @override
  void dispose() {
    _nameArController.dispose();
    _nameEnController.dispose();
    _idController.dispose();
    _birthdateController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760, maxHeight: 700),
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 20,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSection(
                          'البيانات الشخصية:',
                          _buildPersonalSection(),
                        ),
                        const SizedBox(height: 24),
                        _buildSection(
                          'بيانات العضوية:',
                          _buildMembershipSection(),
                        ),
                        const SizedBox(height: 24),
                        _buildSection(
                          'بيانات التواصل:',
                          _buildContactSection(),
                        ),
                        const SizedBox(height: 24),
                        _buildStatusSection(),
                      ],
                    ),
                  ),
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 20, 20, 16),
      decoration:  BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Executive/Administrative Addition".tr(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryOlive,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close, color: AppColors.primaryOlive),
            // style: IconButton.styleFrom(
            //   backgroundColor: const Color(0xFFF5F5F5),
            //   shape: const CircleBorder(),
            //   padding: const EdgeInsets.all(6),
            // ),
          ),
        ],
      ),
    );
  }

  // ── Section Wrapper ──────────────────────────
  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: _lightGreen, width: 2)),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _green,
            ),
          ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  // ── Personal Section ─────────────────────────
  Widget _buildPersonalSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _nameArController,
                label: 'الاسم (باللغة العربية)',
                hint: 'أدخل الاسم بالعربية',
                required: true,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'هذا الحقل مطلوب' : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _nameEnController,
                label: 'الاسم (باللغة الإنجليزية)',
                hint: 'أدخل الاسم بالإنجليزية',
                required: true,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'هذا الحقل مطلوب' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _idController,
                label: 'رقم الهوية',
                hint: 'أدخل رقم الهوية الوطنية',
                required: true,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'هذا الحقل مطلوب' : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDropdown(
                label: 'الجنسية',
                hint: 'اختر',
                value: _selectedNationality,
                items: ['سعودي', 'مقيم', 'أخرى'],
                onChanged: (v) => setState(() => _selectedNationality = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                label: 'محل الإقامة',
                hint: 'اختر',
                value: _selectedResidence,
                items: [
                  'الرياض',
                  'جدة',
                  'مكة المكرمة',
                  'المدينة المنورة',
                  'الدمام',
                ],
                onChanged: (v) => setState(() => _selectedResidence = v),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _birthdateController,
                label: 'تاريخ الميلاد (بالتقويم الهجري)',
                hint: 'اختر التاريخ الهجري',
                required: true,

                readOnly: true,
                onTap: _selectHijriDate,
                suffixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  size: 12,
                  color: Colors.grey,
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'هذا الحقل مطلوب' : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildUploadArea(
                label: 'صورة شخصية',
                fileName: _profilePhoto?.name ?? 'اضغط للرفع',
                onTap: () async {
                  final file = await _pickFile();
                  if (file != null) {
                    setState(() {
                      _profilePhoto = file;
                    });
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildUploadArea(
                label: 'صورة التفويض',
                fileName: _authPhoto?.name ?? 'اضغط للرفع',
                onTap: () async {
                  final file = await _pickFile();
                  if (file != null) {
                    setState(() {
                      _authPhoto = file;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Membership Section ───────────────────────
  Widget _buildMembershipSection() {
    return Row(
      children: [
        Expanded(
          child: _buildDropdown(
            label: 'المسمى الوظيفي',
            hint: 'اختر',
            value: _selectedJobTitle,
            items: ['مدير عام', 'نائب الرئيس', 'عضو مجلس إدارة'],
            onChanged: (v) => setState(() => _selectedJobTitle = v),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildDropdown(
            label: 'اسم الدور الوظيفي',
            hint: 'اختر',
            value: _selectedJobRole,
            items: ['رئيس', 'نائب', 'عضو'],
            onChanged: (v) => setState(() => _selectedJobRole = v),
          ),
        ),
      ],
    );
  }

  // ── Contact Section ──────────────────────────
  Widget _buildContactSection() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            controller: _phoneController,
            label: 'رقم الهاتف',
            hint: 'أدخل رقم الهاتف',
            required: true,
            keyboardType: TextInputType.phone,
            validator: (v) =>
                (v == null || v.isEmpty) ? 'هذا الحقل مطلوب' : null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTextField(
            controller: _emailController,
            label: 'البريد الإلكتروني',
            hint: 'أدخل البريد الإلكتروني',
            required: true,
            keyboardType: TextInputType.emailAddress,
            validator: (v) =>
                (v == null || v.isEmpty) ? 'هذا الحقل مطلوب' : null,
          ),
        ),
      ],
    );
  }

  // ── Status Section ───────────────────────────
  Widget _buildStatusSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Active Toggle
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('النشاط', required: true),
            const SizedBox(height: 8),
            Row(
              children: [
                Switch(
                  value: _isActive,
                  activeColor: AppColors.primaryOlive,
                  onChanged: (v) => setState(() => _isActive = v),
                ),
                const SizedBox(width: 8),
                Text(
                  _isActive ? 'نشط' : 'غير نشط',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _isActive ? AppColors.primaryOlive : Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 16),
        // Can View Private
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('يمكنه رؤية الملفات الخاصة؟', required: true),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _buildRadioOption('لا', false)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildRadioOption('نعم', true)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption(String label, bool value) {
    final selected = _canViewPrivate == value;
    return GestureDetector(
      onTap: () => setState(() => _canViewPrivate = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? AppColors.primaryOlive : _borderColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
          color: selected
              ? AppColors.primaryOlive.withOpacity(0.1)
              : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.primaryOlive : Colors.grey,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryOlive,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: selected ? AppColors.primaryOlive : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Footer ───────────────────────────────────
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 16, 28, 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOlive,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: _onSave,
            child: const Text('حفظ'),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primaryOlive, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              foregroundColor: AppColors.primaryOlive,
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
        ],
      ),
    );
  }

  // ── Reusable Widgets ─────────────────────────

  Widget _buildLabel(String text, {bool required = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryOlive,
            ),
          ),
        ),
        if (required) ...[
          const SizedBox(width: 4),
          const Text('*', style: TextStyle(color: Colors.red, fontSize: 14)),
        ],
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool required = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    bool readOnly = false,
    Future<dynamic> Function()? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, required: required),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          onTap: onTap,
          validator: validator,
          textAlign: TextAlign.right,
          readOnly: readOnly,
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: const Color(0xFFFAFAFA),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _borderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _green, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, required: true),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFAFAFA),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _borderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _green, width: 1.5),
            ),
          ),
          hint: Text(
            hint,
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 14)),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildUploadArea({
    required String label,
    required String fileName,
    required VoidCallback onTap,
  }) {
    final hasFile = fileName != 'اضغط للرفع';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, required: true),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: hasFile ? _green : const Color(0xFFB0C8B0),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(10),
              color: hasFile
                  ? const Color(0xFFF0F7F0)
                  : const Color(0xFFF7FBF7),
            ),
            child: Column(
              children: [
                Icon(Icons.upload_outlined, color: _green, size: 14),
                const SizedBox(height: 6),
                hasFile
                    ? Text(
                        fileName,
                        style: const TextStyle(
                          fontSize: 10,
                          color: _green,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF666666),
                            fontFamily: 'Cairo',
                          ),
                          children: [
                            const TextSpan(
                              text: 'اضغط للرفع ',
                              style: TextStyle(
                                color: _green,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: 'أو قم بسحب وافلات للملف'),
                          ],
                        ),
                      ),
                const SizedBox(height: 4),
                const Text(
                  'PDF,DOC,PNG أو JPG (2 MB)',
                  style: TextStyle(fontSize: 8, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم الحفظ بنجاح!', textDirection: TextDirection.rtl),
          backgroundColor: Color(0xFF3A6B3A),
        ),
      );
      Navigator.pop(context);
    }
  }
}
