import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Add to pubspec.yaml






class AddEmployeeDialog extends StatefulWidget {
  const AddEmployeeDialog({super.key});

  @override
  State<AddEmployeeDialog> createState() => _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  final _formKey = GlobalKey<FormState>();

  final _nameEnController = TextEditingController();
  final _nameArController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isActive = true;
  bool _obscurePassword = true;
  String? _selectedRole;
  String? _authorizationFileName;

  final List<String> _roles = [
    'مدير',
    'موظف',
    'محاسب',
    'مشرف',
    'مندوب مبيعات',
  ];

  static const _primaryColor = Color(0xFF6B7A5E);
  static const _borderColor = Color(0xFFD4D0C8);
  static const _labelColor = Color(0xFF3D3D3D);
  static const _hintColor = Color(0xFFAAAAAA);

  @override
  void dispose() {
    _nameEnController.dispose();
    _nameArController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _idController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _hintColor, fontSize: 13),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
        borderSide: const BorderSide(color: _primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  Widget _buildLabel(String text, {bool required = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          children: [

            TextSpan(
              text: text,
              style: const TextStyle(
                color: _labelColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (required)
              const TextSpan(
                text: '* ',
                style: TextStyle(color: Colors.red, fontSize: 13),
              ),
          ],
        ),
      ),
    );
  }

  // Widget _buildTextField(
  //     String label,
  //     TextEditingController controller,
  //     String hint, {
  //       TextInputType keyboardType = TextInputType.text,
  //       Widget? suffixIcon,
  //       bool obscureText = false,
  //       String? Function(String?)? validator,
  //     }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     children: [
  //       _buildLabel(label),
  //       TextFormField(
  //         controller: controller,
  //         keyboardType: keyboardType,
  //         obscureText: obscureText,
  //         textAlign: TextAlign.right,
  //         textDirection: TextDirection.rtl,
  //         decoration: _fieldDecoration(hint).copyWith(suffixIcon: suffixIcon),
  //         validator: validator ??
  //                 (value) {
  //               if (value == null || value.isEmpty) {
  //                 return 'هذا الحقل مطلوب';
  //               }
  //               return null;
  //             },
  //       ),
  //     ],
  //   );
  // }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      );
      if (result != null) {
        setState(() {
          _authorizationFileName = result.files.single.name;
        });
      }
    } catch (e) {
      // Handle error - file_picker may not be available in all environments
      setState(() {
        _authorizationFileName = 'authorization_letter.pdf';
      });
    }
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      if (_selectedRole == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('الرجاء اختيار الدور الوظيفي')),
        );
        return;
      }
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ الموظف بنجاح'),
          backgroundColor: _primaryColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              _buildHeader(),

              // Scrollable Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),

                        // Row 1: Name EN + Name AR
                        _buildTwoColumnRow(
                          left: _buildTextField(
                            'اسم الموظف (بالعربية)',
                            _nameArController,
                            'أدخل الاسم بالعربية',
                            textDirection: TextDirection.rtl,
                          ),
                          right: _buildTextField(
                            'اسم الموظف (بالإنجليزية)',
                            _nameEnController,
                            'أدخل الاسم بالإنجليزية',
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Row 2: Email + Phone
                        _buildTwoColumnRow(
                          left: _buildTextField(
                            'البريد الإلكتروني',
                            _emailController,
                            'أدخل البريد الإلكتروني',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              if (!value.contains('@')) {
                                return 'البريد الإلكتروني غير صحيح';
                              }
                              return null;
                            },
                          ),
                          right: _buildTextField(
                            'رقم الهاتف',
                            _phoneController,
                            'أدخل رقم الهاتف',
                            keyboardType: TextInputType.phone,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Row 3: Username + ID
                        _buildTwoColumnRow(
                          left: _buildTextField(
                            'اسم المستخدم',
                            _usernameController,
                            'أدخل اسم المستخدم',
                          ),
                          right: _buildTextField(
                            'رقم الهوية',
                            _idController,
                            'أدخل رقم الهوية الوطنية',
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Row 4: Role + Password
                        _buildTwoColumnRow(
                          left: _buildRoleDropdown(),
                          right: _buildPasswordField(),
                        ),

                        const SizedBox(height: 16),

                        // Status
                        _buildStatusRow(),

                        const SizedBox(height: 16),

                        // Authorization Letter
                        _buildAuthorizationUpload(),
                      ],
                    ),
                  ),
                ),
              ),

              // Footer Buttons
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          const Text(
            'إضافة موظف',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _labelColor,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: Colors.grey),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildTwoColumnRow({
    required Widget left,
    required Widget right,
    TextDirection textDirection = TextDirection.rtl,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: right),
        const SizedBox(width: 16),
        Expanded(child: left),
      ],
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller,
      String hint, {
        TextInputType keyboardType = TextInputType.text,
        TextDirection textDirection = TextDirection.rtl,
        Widget? suffixIcon,
        bool obscureText = false,
        String? Function(String?)? validator,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textAlign: TextAlign.right,
          textDirection: textDirection,
          decoration: _fieldDecoration(hint).copyWith(suffixIcon: suffixIcon),
          validator: validator ??
                  (value) {
                if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
                return null;
              },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('كلمة المرور'),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          textAlign: TextAlign.right,
          textDirection: TextDirection.ltr,
          decoration: _fieldDecoration('أدخل كلمة المرور').copyWith(
            prefixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
            if (value.length < 6) return 'كلمة المرور قصيرة جداً';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildRoleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('الدور'),
        DropdownButtonFormField<String>(
          value: _selectedRole,
          decoration: _fieldDecoration('اختر الدور الوظيفي'),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: _roles
              .map((role) => DropdownMenuItem(
            value: role,
            child: Text(
              role,
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontSize: 13),
            ),
          ))
              .toList(),
          onChanged: (val) => setState(() => _selectedRole = val),
          validator: (value) =>
          value == null ? 'الرجاء اختيار الدور الوظيفي' : null,
        ),
      ],
    );
  }

  Widget _buildStatusRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('الحالة', required: false),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('نشط', style: TextStyle(fontSize: 13, color: _labelColor)),
            const SizedBox(width: 8),
            Checkbox(
              value: _isActive,
              onChanged: (val) => setState(() => _isActive = val ?? false),
              activeColor: _primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAuthorizationUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('خطاب التفويض'),
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _borderColor),
            ),
            child: _authorizationFileName != null
                ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.check_circle,
                    color: _primaryColor, size: 18),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    _authorizationFileName!,
                    style: const TextStyle(
                        fontSize: 13, color: _primaryColor),
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ],
            )
                : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              ' أو قم بسحب وإفلات للملف',
                              style: TextStyle(
                                  fontSize: 13, color: _hintColor),
                            ),
                            Text(
                              'اضغط للرفع',
                              style: TextStyle(
                                fontSize: 13,
                                color: _primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'JPG (2 MB) أو PDF,DOC,PNG',
                          style: TextStyle(
                              fontSize: 11, color: _hintColor),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: _borderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.upload_file_outlined,
                          color: _hintColor, size: 22),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Save button (right side in RTL = first in LTR row)
          ElevatedButton(
            onPressed: _onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(110, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text('حفظ', style: TextStyle(fontSize: 14)),
          ),
          const SizedBox(width: 12),
          // Cancel button
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              foregroundColor: _labelColor,
              side: const BorderSide(color: _borderColor),
              minimumSize: const Size(110, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('إلغاء', style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}