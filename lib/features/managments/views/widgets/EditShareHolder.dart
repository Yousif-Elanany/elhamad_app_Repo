import 'package:alhamd/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class EditShareholderSheet extends StatefulWidget {
  const EditShareholderSheet({super.key});

  @override
  State<EditShareholderSheet> createState() => _EditShareholderSheetState();
}

class _EditShareholderSheetState extends State<EditShareholderSheet> {
  late TextEditingController _sharesCtrl;
  late TextEditingController _percentCtrl;
  DateTime? _ownershipDate;
  late String _guardian;

  final List<String> _guardians = ['مساهم أول', 'مساهم ثاني', 'مساهم ثالث'];

  // @override
  // void initState() {
  //   super.initState();
  //   // _sharesCtrl =
  //   // TextEditingController(text: '${widget.shareholder.sharesCount}');
  //   // _percentCtrl = TextEditingController(
  //   // text: '${widget.shareholder.ownershipPercent.toStringAsFixed(0)}');
  //   // _ownershipDate = widget.shareholder.ownershipDate;
  //   // _guardian = widget.shareholder.guardianName;
  //   //
  //   // _sharesCtrl.addListener(() {
  //   // final v = int.tryParse(_sharesCtrl.text) ?? 0;
  //   // // Mock: percent = shares (simplified, real calc depends on total shares)
  //   // _percentCtrl.text = '$v';
  //   // });
  // }
  @override
  void initState() {
    super.initState();

    _sharesCtrl = TextEditingController();
    _percentCtrl = TextEditingController();
    _guardian = _guardians.first; // قيمة ابتدائية
  }

  @override
  void dispose() {
    _sharesCtrl.dispose();
    _percentCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _ownershipDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primaryOlive,
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _ownershipDate = picked);
  }

  void _save() {
    Navigator.pop(context);
    // Validate required fields
    // if (_sharesCtrl.text.trim().isEmpty) {
    // _showError('حقل عدد الأسهم مطلوب');
    // return;
    // }
    // if (_ownershipDate == null) {
    // _showError('حقل تاريخ تملك السهم مطلوب');
    // return;
    // }
    // if (_guardian.trim().isEmpty) {
    // _showError('حقل اسم ولي الأمر مطلوب');
    // return;
    // }
    //
    // final updated = widget.shareholder
    // ..sharesCount = int.tryParse(_sharesCtrl.text) ?? widget.shareholder.sharesCount
    // ..ownershipPercent = double.tryParse(_percentCtrl.text) ?? widget.shareholder.ownershipPercent
    // ..ownershipDate = _ownershipDate
    // ..guardianName = _guardian;
    // Navigator.pop(context, updated);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: const Color(0xFFC0392B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _dateLabel(DateTime? d) {
    if (d == null) return 'اختر تاريخاً';
    return '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.primaryOlive,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'تعديل مساهم',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: AppColors.primaryOlive),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(color: Colors.grey, height: 0),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'البيانات الملكية:',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryOlive,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Shares + Percent
                  Row(
                    children: [
                      Expanded(
                        child: _formField(
                          label: 'عدد الأسهم',
                          isRequired: true,
                          child: TextField(
                            controller: _sharesCtrl,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            decoration: _inputDeco(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _formField(
                          label: 'نسبة الملكية من رأس المال (%)',
                          isRequired: true,
                          child: TextField(
                            controller: _percentCtrl,
                            readOnly: true,
                            textAlign: TextAlign.right,
                            style: TextStyle(color: AppColors.primaryOlive),
                            decoration: _inputDeco(disabled: true),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Date picker
                  _formField(
                    label: 'تاريخ تملك السهم (حسب التقويم الميلادي)',
                    isRequired: true,
                    child: InkWell(
                      onTap: _pickDate,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primaryOlive,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFFAFAF8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _dateLabel(_ownershipDate),
                              style: TextStyle(
                                fontSize: 13,
                                color: _ownershipDate != null
                                    ? AppColors.primaryOlive
                                    : AppColors.primaryOlive,
                              ),
                            ),
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 18,
                              color: AppColors.primaryOlive,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Guardian dropdown
                  _formField(
                    label: 'اسم ولي الأمر',
                    isRequired: true,
                    child: DropdownButtonFormField<String>(
                      value: _guardian,
                      isExpanded: true,
                      decoration: _inputDeco(),
                      items: _guardians
                          .map(
                            (g) => DropdownMenuItem(
                              value: g,
                              child: Text(
                                g,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _guardian = v!),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: AppColors.primaryOlive, height: 1),
            // Footer
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        side: BorderSide(color: AppColors.primaryOlive),
                        foregroundColor: AppColors.primaryOlive,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'إلغاء',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOlive,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'حفظ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formField({
    required String label,
    required Widget child,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.primaryOlive,
              fontWeight: FontWeight.w500,
              fontFamily: 'Cairo',
            ),
            children: isRequired
                ? const [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Color(0xFFC0392B),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 5),
        child,
      ],
    );
  }

  InputDecoration _inputDeco({bool disabled = false}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      filled: true,
      fillColor: disabled ? const Color(0xFFF0F0EC) : const Color(0xFFFAFAF8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryOlive, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryOlive, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryOlive, width: 1.5),
      ),
      isDense: true,
    );
  }
}
