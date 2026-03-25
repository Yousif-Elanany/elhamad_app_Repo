import 'dart:io';
import 'package:alhamd/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/network/cache_helper.dart';
import '../../../Committees/Model/CreateCommitMemberRequest.dart';
import '../../../Committees/viewModel/committees_cubit.dart';

class AddMemberCommitteesDialog extends StatefulWidget {
  final int committeeId;

  const AddMemberCommitteesDialog({super.key, required this.committeeId});

  @override
  State<AddMemberCommitteesDialog> createState() =>
      _AddMemberCommitteesDialogState();
}

class _AddMemberCommitteesDialogState extends State<AddMemberCommitteesDialog> {
  int _step = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameEnCtrl = TextEditingController();
  final _nameArCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _nationalIdCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  String? _nationality;
  DateTime? _birthDate;
  String? _birthDateError;
  String? _jobTitle;
  DateTime _startDate = DateTime.now();
  File? _pickedImage;
   bool isLoading = false;
  void showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50, // المسافة من فوق الشاشة
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryOlive,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
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

  void _onSave(BuildContext context) {
    if (_birthDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("اختار تاريخ الميلاد")));
      return;
    }

    if (_jobTitle == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("اختار المسمى الوظيفي")));
      return;
    }

    final request = CreateCommitMemberRequest(
      personalInfo: PersonalInfo(
        name: _nameEnCtrl.text,
        nameAr: _nameArCtrl.text,
        phoneNumber: _phoneCtrl.text,
        nationalId: _nationalIdCtrl.text,
        email: _emailCtrl.text,
        dateOfBirth: _birthDate!,
        nationality: _nationality ?? "",
        address: _addressCtrl.text,
        profilePictureDocumentId: 1, // مؤقتاً
      ),
      jobTitle: "Member",
      startDate: _startDate,
    );

    context.read<CommitteesCubit>().createCommitteeMember(
      CacheHelper.getData("companyId"),
      widget.committeeId,
      request,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommitteesCubit, CommitteesState>(
      listener: (context, state) {
        if (state is CreateCommitteeMemberSuccess) {
          final cubit = context.read<CommitteesCubit>();
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          final navigator = Navigator.of(context);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            navigator.pop();
            scaffoldMessenger.showSnackBar(
              const SnackBar(content: Text("تم إضافة العضو بنجاح")),
            );
            cubit.getCommitteeMembers(
              CacheHelper.getData("companyId"),
              widget.committeeId,
            );
          });
        }

        if (state is CreateCommitteeMemberError) {
          showTopSnackBar(context, state.error);
          setState(() {
            isLoading = false;
          });
        }
      },
      builder: (context, state) {
        final isLoading = state is CreateCommitteeMemberLoading;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620, maxHeight: 720),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  _buildStepIndicator(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: _step == 0
                          ? _buildPersonalStep()
                          : _buildJobStep(),
                    ),
                  ),
                  _buildFooter(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C1C1C),
            ),
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
                color: i ~/ 2 < _step
                    ? const Color(0xFF7a8c5e)
                    : const Color(0xFFDDDDDD),
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
                  color: isActive
                      ? const Color(0xFF7a8c5e)
                      : const Color(0xFF9E9E9E),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPersonalStep() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionTitle('البيانات الشخصية:'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _field(
                  'اسم الموظف (بالإنجليزية)',
                  'أدخل الاسم بالإنجليزية',
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الاسم مطلوب';
                    }
                    return null;
                  },
                  _nameEnCtrl,
                  required: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _field(
                  'الإسم (باللغة العربية)',
                  'أدخل الاسم بالعربية',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[\u0600-\u06FF\s]'),
                    ),
                  ],

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الاسم مطلوب';
                    }
                    if (!RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(value)) {
                      return 'عربي فقط';
                    }
                    return null;
                  },
                  _nameArCtrl,
                  required: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _datePicker(
                  'تاريخ الميلاد',
                  _birthDate,
                      (d) => setState(() => _birthDate = d),
                  required: true,
                  errorText: _birthDateError, // مرر الخطأ هنا
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _field(
                  'رقم الهاتف',
                  'أدخل رقم الهاتف',
                  _phoneCtrl,
                  required: true,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رقم الهاتف مطلوب';
                    }
                    if (value.length < 9) {
                      return 'رقم غير صحيح';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _field(
                  'البريد الإلكتروني',
                  'أدخل البريد الإلكتروني',
                  _emailCtrl,
                  required: true,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'البريد مطلوب';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'بريد غير صحيح';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _field(
                  'رقم الهوية',
                  'أدخل رقم الهوية الوطنية',
                  _nationalIdCtrl,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رقم الهوية مطلوب';
                    }
                    if (value.length < 10) {
                      return 'رقم غير صحيح';
                    }
                    return null;
                  },
                  required: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _dropdown(
            'الجنسية',
            ['سعودي', 'مصري', 'أردني', 'أخرى'],
            _nationality,
            (v) => setState(() => _nationality = v),
            optional: true,
          ),
          const SizedBox(height: 12),
          _multilineField(
            'العنوان',
            'أدخل تفاصيل العنوان',
            _addressCtrl,
            optional: true,
          ),
        ],
      ),
    );
  }
  final Map<String, String> jobTitles = {
    'مدير': 'Manager',
    'مهندس': 'Engineer',
    'محلل': 'Analyst',
    'مطور': 'Developer',
  };
  Widget _buildJobStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionTitle('البيانات الوظيفية:'),
        const SizedBox(height: 16),
        _uploadArea(),
        const SizedBox(height: 16),
          _dropdown(
            'المسمى الوظيفي',
            jobTitles.keys.toList(), // لعرض النصوص العربية
            _jobTitle,
            (v) => setState(() => _jobTitle = v),
            required: true,
            hint: 'اختر المسمى الوظيفي',
          ),
        const SizedBox(height: 12),
        _datePicker(
          'تاريخ البداية',
          _startDate,
          (d) => setState(() => _startDate = d),
          required: true,
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFEEEDEA))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
            onPressed: isLoading ? null : () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF555555),
              side: const BorderSide(color: Color(0xFFCCCCCC)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('إلغاء'),
          ),
          Row(
            children: [
              if (_step == 1) ...[
                OutlinedButton(
                  onPressed: isLoading ? null : () => setState(() => _step = 0),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF7a8c5e),
                    side: const BorderSide(color: Color(0xFF7a8c5e)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('السابق'),
                ),
                const SizedBox(width: 10),
              ],
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_step == 0) {
                          if (_formKey.currentState!.validate()) {
                            if (_birthDate == null) {
                              setState(() {
                                _birthDateError = 'اختار تاريخ الميلاد';
                              });
                              return;
                            }
                            setState(() => _step = 1);
                          }
                        } else {
                          _onSave(context);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7a8c5e),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        _step == 0 ? 'التالي' : 'حفظ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── باقي الـ helpers زي ما هي ──────────────────────────────────────────

  Widget _sectionTitle(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C1C1C),
          ),
        ),
        const SizedBox(height: 6),
        const Divider(color: Color(0xFFEEEDEA)),
      ],
    );
  }

  Widget _field(
    String label,
    String hint,

    TextEditingController controller, {
    bool required = false,

    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label, required: required),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: _inputDeco(hint),
        ),
      ],
    );
  }

  Widget _multilineField(
    String label,
    String hint,
    TextEditingController ctrl, {
    bool optional = false,
  }) {
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

  Widget _dropdown(
    String label,
    List<String> items,
    String? value,
    ValueChanged<String?> onChanged, {
    bool required = false,
    bool optional = false,
    String hint = 'اختر',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label, required: required, optional: optional),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          hint: Text(
            hint,
            style: const TextStyle(fontSize: 13, color: Color(0xFFAAAAAA)),
          ),
          decoration: _inputDeco(''),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 13)),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _datePicker(
      String label,
      DateTime? value,
      ValueChanged<DateTime> onPicked, {
        bool required = false,
        String? errorText, // متغير خطأ
      }) {
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
            if (picked != null) {
              onPicked(picked);
              setState(() {
                if (label == 'تاريخ الميلاد') _birthDateError = null; // شيل الخطأ بعد اختيار التاريخ
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
            decoration: BoxDecoration(
              border: Border.all(
                color: errorText != null ? Colors.red : const Color(0xFFCCCCCC),
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Color(0xFF9E9E9E),
                ),
                Text(
                  display,
                  style: TextStyle(
                    fontSize: 13,
                    color: value != null
                        ? const Color(0xFF333333)
                        : const Color(0xFFAAAAAA),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 12),
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
          child: _pickedImage != null ? _buildPreview() : _buildDropZone(),
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
            child: const Icon(
              Icons.upload_file_outlined,
              color: Color(0xFF7a8c5e),
              size: 22,
            ),
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
          const Text(
            'PDF,DOC,PNG أو JPG (2 MB)',
            style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA)),
          ),
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
              child: Image.file(
                _pickedImage!,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFDDE5CC),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.insert_drive_file_outlined,
                color: Color(0xFF7a8c5e),
              ),
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
          if (optional)
            const TextSpan(
              text: ' (اختياري)',
              style: TextStyle(
                color: Color(0xFFAAAAAA),
                fontWeight: FontWeight.normal,
              ),
            ),
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
