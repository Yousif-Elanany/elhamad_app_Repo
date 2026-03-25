import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/cache_helper.dart';
import '../../Model/CreateCommitRequest.dart';
import '../../viewModel/committees_cubit.dart';
import '../widgets/DialogDropdownField.dart';
import '../widgets/DialogInputField.dart';

class AddCommitteeDialog extends StatefulWidget {
  const AddCommitteeDialog({super.key});

  @override
  State<AddCommitteeDialog> createState() => _AddCommitteeDialogState();
}

class _AddCommitteeDialogState extends State<AddCommitteeDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;
  late final TextEditingController _numOfMemberController;
  late final TextEditingController _numOfMeetingController;

  String? _dialogSelectedType;

  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _numOfMemberController = TextEditingController();
    _numOfMeetingController = TextEditingController();
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _numOfMemberController.dispose();
    _numOfMeetingController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  bool _isValidDates() {
    if (_startDateController.text.isEmpty || _endDateController.text.isEmpty) return false;
    try {
      final start = DateTime.parse(_startDateController.text);
      final end = DateTime.parse(_endDateController.text);
      return !start.isAfter(end);
    } catch (e) {
      return false;
    }
  }

  void _onSave(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    if (_dialogSelectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("اختار نوع اللجنة")),
      );
      return;
    }

    if (!_isValidDates()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تاريخ البداية يجب أن يكون قبل أو يساوي تاريخ النهاية"),
        ),
      );
      return;
    }

    final request = CreateCommitRequest(
      type: committeeTypes[_dialogSelectedType].toString(),
      membersCount: int.parse(_numOfMemberController.text),
      startDate: _startDateController.text,
      endDate: _endDateController.text,
      yearlyMeetingsCount: int.parse(_numOfMeetingController.text),
    );

    context.read<CommitteesCubit>().createCommittees(
      CacheHelper.getData("companyId"),
      request,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommitteesCubit, CommitteesState>(
      listener: (context, state) {
        if (state is CreateCommitteesSuccess) {
          final cubit = context.read<CommitteesCubit>();
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          final navigator = Navigator.of(context);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            navigator.pop();
            scaffoldMessenger.showSnackBar(
              const SnackBar(content: Text("تم الحفظ بنجاح")),
            );
            cubit.getCommittees(CacheHelper.getData("companyId"));
          });
        }

        if (state is CreateCommitteesError) {
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
        final isLoading = state is CreateCommitteesLoading;

        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "اضافة لجنة",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              IconButton(
                onPressed: isLoading ? null : () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: SizedBox(
                width: 600,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DialogDropdownField(
                            label: "نوع اللجنة *",
                            value: _dialogSelectedType,
                            onChanged: (val) =>
                                setState(() => _dialogSelectedType = val),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: DialogInputField(
                            "عدد الاعضاء *",
                            hint: "0",
                            isNumber: true,
                            controller: _numOfMemberController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: DialogInputField(
                            "تاريخ البداية*",
                            isDatePicker: true,
                            controller: _startDateController,
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.tryParse(_startDateController.text) ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setState(() => _startDateController.text = _formatDate(picked));
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: DialogInputField(
                            "تاريخ النهاية*",
                            isDatePicker: true,
                            controller: _endDateController,
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.tryParse(_endDateController.text) ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setState(() => _endDateController.text = _formatDate(picked));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    DialogInputField(
                      "عدد الاجتماعات في السنه *",
                      hint: "1",
                      isNumber: true,
                      controller: _numOfMeetingController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: const Text("إلغاء", style: TextStyle(color: Colors.black54)),
            ),
            ElevatedButton(
              onPressed: isLoading ? null : () => _onSave(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB4B496),
                minimumSize: const Size(100, 45),
              ),
              child: isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
                  : const Text("حفظ", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}