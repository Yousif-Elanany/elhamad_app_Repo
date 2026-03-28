import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/network/cache_helper.dart';
import '../../../Committees/viewModel/committees_cubit.dart';
import '../../Model/EditMemberModel.dart';

class EditMemberDialog extends StatefulWidget {
  final int memberId;
  final int committee;
  final String currentJobTitle;
  final DateTime currentStartDate;

  const EditMemberDialog({
    super.key,
    required this.memberId,
    required this.currentJobTitle,
    required this.currentStartDate,
    required this.committee,
  });

  @override
  State<EditMemberDialog> createState() => _EditMemberDialogState();
}

class _EditMemberDialogState extends State<EditMemberDialog> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _startDate;
  // أضف ده في الـ class
  final Map<String, String> jobTitles = {
    'مدير': '0',
    'مهندس': '1',
    'محلل': '2',
    'مطور': '3',
  };

  String? _selectedJobTitle; // ← القيمة العربية المختارة
  @override
  void initState() {
    super.initState();
    _startDate = widget.currentStartDate;

    // ← نجيب الـ key العربي من الـ value الإنجليزي
    _selectedJobTitle = jobTitles.entries
        .firstWhere(
          (e) => e.value == widget.currentJobTitle,
          orElse: () => jobTitles.entries.first,
        )
        .key;
  }



  void _onSave(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedJobTitle == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("اختار المسمى الوظيفي")));
      return;
    }
    final request = EditMemberModel(
      jobTitle: jobTitles[_selectedJobTitle]!, // ← بيبعت "Manager" مش "مدير"
      startDate: _startDate,
    );
    print(request.jobTitle);
    print(request.startDate);

    context.read<CommitteesCubit>().editMember(
      CacheHelper.getData("companyId"),
      widget.memberId,
      request,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommitteesCubit, CommitteesState>(
      listener: (context, state) {
        if (state is EditMemberSuccess) {
          final cubit = context.read<CommitteesCubit>();
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          final navigator = Navigator.of(context);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            navigator.pop();
            scaffoldMessenger.showSnackBar(
               SnackBar(content: Text("تم التعديل بنجاح"),backgroundColor: AppColors.primaryOlive,),
            );
            cubit.getCommitteeMembers(
              CacheHelper.getData("companyId"),
             widget.committee ,
            );
          });
        }

        if (state is EditMemberError) {
          final error = state.error;
          final scaffoldMessenger = ScaffoldMessenger.of(context);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            scaffoldMessenger.showSnackBar(
              SnackBar(content: Text(error)),
            );
          });
        }
      },
      builder: (context, state) {
        final isLoading = state is EditMemberLoading;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 40),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Header ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'تعديل بيانات العضو',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                        IconButton(
                          onPressed: isLoading
                              ? null
                              : () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.grey),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Divider(height: 1),
                    const SizedBox(height: 20),

                    // ── المسمى الوظيفي ──
                    _buildLabel('المسمى الوظيفي', required: true),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      dropdownColor: Colors.white,
                      value: _selectedJobTitle,
                      isExpanded: true,
                      hint: const Text(
                        'اختر المسمى الوظيفي',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFAAAAAA),
                        ),
                      ),
                      decoration: _inputDeco(''),
                      items: jobTitles.keys
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: isLoading
                          ? null
                          : (v) => setState(() => _selectedJobTitle = v),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'هذا الحقل مطلوب';
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // ── تاريخ البداية ──
                    _buildLabel('تاريخ البداية', required: true),
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: isLoading
                          ? null
                          : () async {
                              final today = DateTime.now();
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: _startDate,
                                // ← أول يوم متاح هو اليوم الحالي
                                firstDate: today,
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setState(() => _startDate = picked);
                              }
                            },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 13,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFCCCCCC)),
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
                              '${_startDate.day.toString().padLeft(2, '0')}/${_startDate.month.toString().padLeft(2, '0')}/${_startDate.year}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Buttons ──
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isLoading
                                ? null
                                : () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFFDDDDDD),
                                width: 1.5,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: Colors.grey[700],
                            ),
                            child: const Text(
                              'إلغاء',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () => _onSave(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7a8c5e),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
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
                                : const Text(
                                    'حفظ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
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
      },
    );
  }

  Widget _buildLabel(String text, {bool required = false}) {
    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
