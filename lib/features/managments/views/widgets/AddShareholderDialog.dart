import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddShareholderDialog extends StatefulWidget {
  const AddShareholderDialog({super.key});

  @override
  State<AddShareholderDialog> createState() => _AddShareholderDialogState();
}

class _AddShareholderDialogState extends State<AddShareholderDialog> {
  final Color primaryGreen = const Color(0xFF8B8B6B); // اللون الأخضر الزيتوني من الصورة

  // Controllers للحقول
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _ownershipDateController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, // عرض مناسب للديالوج
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // الرأس
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("إضافة مساهم", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, size: 20)),
                ],
              ),
            ),
            const Divider(height: 1),

            // المحتوى القابل للتمرير
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- البيانات الأساسية ---
                    _buildSectionTitle("البيانات الأساسية:"),
                    Row(
                      children: [
                        Expanded(child: _buildTextField("الإسم (باللغة الإنجليزية) *", "أدخل الاسم بالإنجليزي")),
                        const SizedBox(width: 20),
                        Expanded(child: _buildTextField("الإسم (باللغة العربية) *", "أدخل الاسم بالعربي")),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _buildDropdownField("نوع المساهم *", "طبيعي")),
                        const SizedBox(width: 20),
                        Expanded(child: _buildTextField("رقم الهاتف *", "أدخل رقم الهاتف")),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _buildTextField("البريد الإلكتروني *", "أدخل البريد الإلكتروني")),
                        const SizedBox(width: 20),
                        Expanded(child: _buildTextField("رقم الهوية *", "أدخل رقم الهوية الوطنية")),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildDateField("تاريخ الميلاد *", _birthDateController),

                    const SizedBox(height: 30),

                    // --- البيانات للملكية ---
                    _buildSectionTitle("البيانات للملكية:"),
                    Row(
                      children: [
                        Expanded(child: _buildTextField("عدد الأسهم *", "0")),
                        const SizedBox(width: 20),
                        Expanded(child: _buildTextField("نسبة الملكية من رأس المال (%)", "0")),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildDateField("تاريخ تملك السهم (حسب التقويم الميلادي) (اختياري)", _ownershipDateController),

                    const SizedBox(height: 30),

                    // --- البيانات الإضافية ---
                    _buildSectionTitle("البيانات الإضافية:"),
                    Row(
                      children: [
                        Expanded(child: _buildDropdownField("الجنسية *", "اختر")),
                        const SizedBox(width: 20),
                        Expanded(child: _buildTextField("العنوان الوطني (اختياري)", "العنوان الوطني")),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Divider(height: 1),
            // الأزرار السفلية
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      minimumSize: const Size(120, 45),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      elevation: 0,
                    ),
                    child: const Text("حفظ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(120, 45),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text("إلغاء", style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label.replaceFirst('*', ''),
            style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500),
            children: label.contains('*') ? [const TextSpan(text: ' *', style: TextStyle(color: Colors.red))] : [],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label.replaceFirst('*', ''),
            style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500),
            children: label.contains('*') ? [const TextSpan(text: ' *', style: TextStyle(color: Colors.red))] : [],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(hint, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              items: const [],
              onChanged: null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label.replaceFirst('*', ''),
            style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500),
            children: label.contains('*') ? [const TextSpan(text: ' *', style: TextStyle(color: Colors.red))] : [],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: true,
          onTap: () => _selectDate(controller),
          decoration: InputDecoration(
            hintText: "اختر التاريخ",
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18, color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}