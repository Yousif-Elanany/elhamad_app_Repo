import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Models/CreateShareHolderRequest.dart';
import '../../viewModel/management_cubit.dart';

class AddShareholderDialog extends StatefulWidget {
  final String companyId;

  const AddShareholderDialog({super.key, required this.companyId});

  @override
  State<AddShareholderDialog> createState() => _AddShareholderDialogState();
}

class _AddShareholderDialogState extends State<AddShareholderDialog> {
  final Color primaryGreen = const Color(0xFF8B8B6B);

  final _formKey = GlobalKey<FormState>();

  // Controllers — mapped 1-to-1 with CreateShareHolderRequestModel fields
  final _nameEnController = TextEditingController();
  final _nameArController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _addressController = TextEditingController();
  final _guardianUserIdController = TextEditingController();
  final _sharesOwnedController = TextEditingController();
  final _unifiedNationalNumberController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _acquisitionDateController = TextEditingController();
  bool isLoading = false;

  // Dropdown values
  String? _selectedShareholderType;
  String? _selectedNationality;

  String mapShareholderType(String value) {
    switch (value) {
      case 'طبيعي':
        return 'Natural';
      case 'اعتباري':
        return 'Legal'; // أو Corporate حسب الـ API
      default:
        return '';
    }
  }

  final List<String> _shareholderTypes = ['طبيعي', 'اعتباري'];
  final List<String> _nationalities = [
    'سعودي',
    'مصري',
    'اماراتي',
    'عراقي',
    'هندي',
    'كويتي',
    'عماني',
  ];

  @override
  void dispose() {
    _nameEnController.dispose();
    _nameArController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _addressController.dispose();
    _guardianUserIdController.dispose();
    _sharesOwnedController.dispose();
    _unifiedNationalNumberController.dispose();
    _birthDateController.dispose();
    _acquisitionDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: primaryGreen),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final model = CreateShareHolderRequestModel(
      name: _nameEnController.text.trim(),
      nameAr: _nameArController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      nationalId: _nationalIdController.text.trim(),
      nationality: _selectedNationality!,
      address: _addressController.text.trim(),
      dateOfBirth: DateTime.parse(_birthDateController.text),
      guardianUserId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      // guardianUserId: _guardianUserIdController.text.trim(),
      sharesOwned: int.parse(_sharesOwnedController.text.trim()),
      shareAcquisitionDate: DateTime.parse(_acquisitionDateController.text),
      shareholderType: mapShareholderType(_selectedShareholderType!),
      unifiedNationalNumber: _unifiedNationalNumberController.text.trim(),
    );

    context.read<ManagementCubit>().createShareHolder(
      widget.companyId,
      model,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManagementCubit, ManagementState>(
      listener: (context, state) {
        if (state is CreateShareHolderSuccess) {
          Navigator.pop(context, true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إضافة المساهم بنجاح'),
              backgroundColor: Color(0xFF8B8B6B),
            ),
          );
        } else if (state is CreateShareHolderError) {
          Navigator.pop(context);
          print("Error creating shareholder: ${state.message}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Dialog(
        backgroundColor: Colors.white,
        insetPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.8,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Header ────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "إضافة مساهم",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, size: 20),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // ── Scrollable Body ───────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ─ البيانات الأساسية ──────────────────────────
                        _buildSectionTitle("البيانات الأساسية:"),
                        _buildRow([
                          _buildTextField(
                            label: "الإسم (باللغة الإنجليزية)",
                            hint: "أدخل الاسم بالإنجليزي",
                            controller: _nameEnController,
                            isRequired: true,
                            validator: (v) {
                              if (v == null || v
                                  .trim()
                                  .isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              if (!RegExp(r'^[a-zA-Z\s]+$')
                                  .hasMatch(v.trim())) {
                                return 'يجب إدخال الاسم بالإنجليزية فقط';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            label: "الإسم (باللغة العربية)",
                            hint: "أدخل الاسم بالعربي",
                            controller: _nameArController,
                            isRequired: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[\u0600-\u06FF\s]')),
                            ],
                            validator: (v) {
                              if (v == null || v
                                  .trim()
                                  .isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              if (!RegExp(r'^[\u0600-\u06FF\s]+$')
                                  .hasMatch(v.trim())) {
                                return 'يجب إدخال الاسم بالعربية فقط';
                              }
                              return null;
                            },
                          ),
                        ]),
                        const SizedBox(height: 20),
                        _buildRow([
                          _buildDropdownField(
                            label: "نوع المساهم",
                            hint: "اختر",
                            value: _selectedShareholderType,
                            items: _shareholderTypes,
                            isRequired: true,
                            onChanged: (v) =>
                                setState(
                                        () => _selectedShareholderType = v),
                            validator: (v) =>
                            v == null ? 'هذا الحقل مطلوب' : null,
                          ),
                          _buildTextField(
                            label: "رقم الهاتف",
                            hint: "أدخل رقم الهاتف",
                            controller: _phoneController,
                            isRequired: true,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (v) {
                              if (v == null || v
                                  .trim()
                                  .isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              if (v
                                  .trim()
                                  .length < 9) {
                                return 'رقم الهاتف غير صحيح';
                              }
                              return null;
                            },
                          ),
                        ]),
                        const SizedBox(height: 20),
                        _buildRow([
                          _buildTextField(
                            label: "البريد الإلكتروني",
                            hint: "أدخل البريد الإلكتروني",
                            controller: _emailController,
                            isRequired: true,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v
                                  .trim()
                                  .isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$')
                                  .hasMatch(v.trim())) {
                                return 'البريد الإلكتروني غير صحيح';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            label: "رقم الهوية",
                            hint: "أدخل رقم الهوية الوطنية",
                            controller: _nationalIdController,
                            isRequired: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (v) {
                              if (v == null || v
                                  .trim()
                                  .isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              if (v
                                  .trim()
                                  .length < 10) {
                                return 'رقم الهوية غير صحيح';
                              }
                              return null;
                            },
                          ),
                        ]),
                        const SizedBox(height: 20),
                        _buildDateField(
                          label: "تاريخ الميلاد",
                          controller: _birthDateController,
                          isRequired: true,
                          validator: (v) =>
                          (v == null || v.isEmpty)
                              ? 'هذا الحقل مطلوب'
                              : null,
                        ),

                        const SizedBox(height: 30),

                        // ─ البيانات للملكية ───────────────────────────
                        _buildSectionTitle("البيانات للملكية:"),
                        _buildRow([
                          _buildTextField(
                            label: "عدد الأسهم",
                            hint: "0",
                            controller: _sharesOwnedController,
                            isRequired: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (v) {
                              if (v == null || v
                                  .trim()
                                  .isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              final n = int.tryParse(v.trim());
                              if (n == null || n <= 0) {
                                return 'يجب أن يكون العدد أكبر من صفر';
                              }
                              return null;
                            },
                          ),
                        ]),
                        const SizedBox(height: 20),
                        _buildDateField(
                          label:
                          "تاريخ تملك السهم (حسب التقويم الميلادي)",
                          controller: _acquisitionDateController,
                          isRequired: true,
                          validator: (v) =>
                          (v == null || v.isEmpty)
                              ? 'هذا الحقل مطلوب'
                              : null,
                        ),

                        const SizedBox(height: 30),

                        // ─ البيانات الإضافية ──────────────────────────
                        _buildSectionTitle("البيانات الإضافية:"),
                        _buildRow([
                          _buildDropdownField(
                            label: "الجنسية",
                            hint: "اختر",
                            value: _selectedNationality,
                            items: _nationalities,
                            isRequired: true,
                            onChanged: (v) =>
                                setState(() => _selectedNationality = v),
                            validator: (v) =>
                            v == null ? 'هذا الحقل مطلوب' : null,
                          ),
                          _buildTextField(
                            label: "العنوان الوطني",
                            hint: "أدخل العنوان الوطني",
                            controller: _addressController,
                            validator: (v) =>
                            (v == null || v
                                .trim()
                                .isEmpty)
                                ? 'هذا الحقل مطلوب'
                                : null,
                          ),
                        ]),

                      ],
                    ),
                  ),
                ),

                const Divider(height: 1),

                // ── Footer Buttons ─────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: BlocBuilder<ManagementCubit, ManagementState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: isLoading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryGreen,
                              minimumSize: const Size(120, 45),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              elevation: 0,
                            ),
                            child: isLoading
                                ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2),
                            )
                                : const Text(
                              "حفظ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: isLoading
                                ? null
                                : () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(120, 45),
                              side:
                              BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            child: const Text("إلغاء",
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Layout Helpers ────────────────────────────────────────────────────────

  Widget _buildRow(List<Widget> children) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
          .expand((w) => [Expanded(child: w), const SizedBox(width: 20)])
          .toList()
        ..removeLast(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333)),
      ),
    );
  }

  // ─── Field Widgets ─────────────────────────────────────────────────────────

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isRequired = false,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, isRequired),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          textAlign: TextAlign.right,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: isRequired ? validator : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: _inputDecoration(hint),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    bool isRequired = false,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, isRequired),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint,
              style:
              TextStyle(color: Colors.grey.shade600, fontSize: 13)),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: _inputDecoration(null),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    bool isRequired = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, isRequired),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: () => _selectDate(controller),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: _inputDecoration("اختر التاريخ").copyWith(
            suffixIcon: const Icon(Icons.calendar_today_outlined,
                size: 18, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  // ─── Shared Helpers ────────────────────────────────────────────────────────

  /// Renders the field label with an optional red asterisk when [isRequired] is true.
  Widget _buildLabel(String text, bool isRequired) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w500),
        children: isRequired
            ? [
          const TextSpan(
              text: ' *', style: TextStyle(color: Colors.red))
        ]
            : [],
      ),
    );
  }

  InputDecoration _inputDecoration(String? hint) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );
    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.red),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
      border: border,
      enabledBorder: border,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }
}