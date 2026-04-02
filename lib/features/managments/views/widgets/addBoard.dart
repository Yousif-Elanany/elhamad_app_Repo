import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../Models/CreateBoardRequestModel.dart';
import '../../viewModel/management_cubit.dart';

class AddBoardDialog extends StatefulWidget {
  final String companyId;
  final ManagementCubit cubit; // مرره من الخارج

  const AddBoardDialog({
    super.key,
    required this.companyId,
    required this.cubit,
  });

  @override
  State<AddBoardDialog> createState() => _AddboardState();
}

class _AddboardState extends State<AddBoardDialog> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _membersCountController = TextEditingController();
  final TextEditingController _vacantSeatsController = TextEditingController();

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  final DateTime _today = DateTime(
    DateTime
        .now()
        .year,
    DateTime
        .now()
        .month,
    DateTime
        .now()
        .day,
  );

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _today,
      firstDate: _today, // ✅ مينفعش قبل النهارده
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedStartDate = picked;
        _startDateController.text =
            intl.DateFormat('yyyy-MM-dd').format(picked);

        // لو تاريخ النهاية أصغر من البداية، امسحه
        if (_selectedEndDate != null && _selectedEndDate!.isBefore(picked)) {
          _selectedEndDate = null;
          _endDateController.clear();
        }
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    // ✅ تاريخ النهاية لازم يكون من نفس يوم البداية أو بعده
    final DateTime minEndDate = _selectedStartDate ?? _today;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: minEndDate,
      firstDate: minEndDate,
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedEndDate = picked;
        _endDateController.text = intl.DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _onSave() {
    if (_formkey.currentState!.validate()) {
      final model = CreateBoardRequestModel(
        startDate: _selectedStartDate!,
        endDate: _selectedEndDate!,
        membersCount: int.parse(_membersCountController.text),
        vacantSeats: int.parse(_vacantSeatsController.text),
      );

      widget.cubit.createNewBoardDirectorRequest(widget.companyId, model);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _membersCountController.dispose();
    _vacantSeatsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.8,
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "إضافة مجلس إدارة",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // --- التواريخ ---
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildDateField(
                          label: "تاريخ البداية *",
                          controller: _startDateController,
                          onTap: () => _selectStartDate(context),
                          validator: (_) {
                            if (_selectedStartDate == null) {
                              return "هذا الحقل مطلوب.";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildDateField(
                          label: "تاريخ النهاية *",
                          controller: _endDateController,
                          onTap: () => _selectEndDate(context),
                          validator: (_) {
                            if (_selectedEndDate == null) {
                              return "هذا الحقل مطلوب.";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // --- المقاعد الشاغرة ---
                  _buildNumberField(
                    label: "المقاعد الشاغرة *",
                    hint: "أدخل عدد المقاعد الشاغرة",
                    controller: _vacantSeatsController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "هذا الحقل مطلوب.";
                      final seats = int.tryParse(value);
                      if (seats == null || seats < 0)
                        return "العدد يجب أن يكون 0 أو أكثر.";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // --- عدد الأعضاء ---
                  _buildNumberField(
                    label: "عدد أعضاء مجلس الإدارة (لا يقل عن 3) *",
                    hint: "أدخل عدد أعضاء مجلس الإدارة",
                    controller: _membersCountController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "هذا الحقل مطلوب.";
                      final count = int.tryParse(value);
                      if (count == null || count < 3)
                        return "يجب أن يكون العدد 3 أو أكثر.";
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // --- Buttons ---
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("إلغاء",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _onSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B8B6B),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("حفظ",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ======= Helpers =======

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        FormField<String>(
          validator: validator,
          builder: (field) =>
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      await Future.microtask(onTap);
                      field.didChange(controller.text);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          // ✅ لون أحمر لو في error
                          color: field.hasError ? Colors.red : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.text.isEmpty
                                  ? "اختر التاريخ"
                                  : controller.text,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const Icon(Icons.calendar_today, size: 18),
                        ],
                      ),
                    ),
                  ),
                  if (field.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 6, right: 12),
                      child: Text(
                        field.errorText!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
        ),
      ],
    );
  }

  Widget _buildNumberField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            errorStyle: const TextStyle(color: Colors.red),
          ),
          validator: validator,
        ),
      ],
    );
  }
}