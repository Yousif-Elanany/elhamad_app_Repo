import 'package:alhamd/features/Organizations/view/widgets/OrganizationRequestWidget.dart';
import 'package:alhamd/features/Organizations/view/widgets/OrganizationWidget.dart';
import 'package:alhamd/features/Organizations/view/widgets/StepCircle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart%20';
import '../../../core/constants/app_colors.dart';
import '../../../core/network/cache_helper.dart';
import '../../../core/network/handleErrors/ValidationClass.dart';
import '../../managments/views/widgets/managmentWidget.dart';
import '../ViewModel/organization_cubit.dart';
import '../model/MeetingRequestModel.dart';
import '../model/organization_model.dart';
import '../../../localization_service.dart';

class OrganizationRequest extends StatefulWidget {
  final OrganizationCubit cubit;
  const OrganizationRequest({super.key, required this.cubit});

  @override
  State<OrganizationRequest> createState() => _OrganizationRequestState();
}

class _OrganizationRequestState extends State<OrganizationRequest> {
  late Box<Organization> organizationsBox;
  int currentStep = 1;

  final Color primaryOlive = const Color(0xFF8B8B6B);
  final Color backgroundGrey = const Color(0xFFF8F9FA);
  final _formKey = GlobalKey<FormState>();
  PlatformFile? selectedFile;
  bool attachmentTouched = false;

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController actionController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  String? selectedDateTimeText;
  int selectedTabIndex = 0;
  DateTime? fromDate;
  DateTime? toDate;
  @override
  void initState() {
    super.initState();
    widget.cubit.getCompanyMeetingsRequests(CacheHelper.getData("companyId"));
  }

  // Detect Language and Direction
  bool get isAr => LocalizationService.getLang() == 'ar';

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    bool isRequired = false,
  }) {
    return FormField<String>(
      validator: (value) {
        if (isRequired && controller.text.isEmpty) {
          return "هذا الحقل مطلوب";
        }
        return null;
      },
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔴 Label
              Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isRequired)
                    const Text(" *", style: TextStyle(color: Colors.red)),
                ],
              ),

              const SizedBox(height: 6),

              GestureDetector(
                onTap: () async {
                  FocusScope.of(state.context).unfocus();

                  DateTime? pickedDate = await showDatePicker(
                    context: state.context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate == null) return;

                  final formatted =
                      "${pickedDate.year}-"
                      "${pickedDate.month.toString().padLeft(2, '0')}-"
                      "${pickedDate.day.toString().padLeft(2, '0')}";

                  controller.text = formatted;

                  state.didChange(formatted);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: state.hasError ? Colors.red : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: controller,
                          builder: (_, value, __) {
                            return Text(
                              value.text.isEmpty ? "........." : value.text,
                              style: const TextStyle(fontSize: 12),
                            );
                          },
                        ),
                      ),

                      const Icon(Icons.calendar_today_outlined),
                    ],
                  ),
                ),
              ),

              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    state.errorText ?? "",
                    style: const TextStyle(color: Colors.red, fontSize: 11),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _filterData() {
    // 🔥 هنا تحط فلترة الـ List حسب fromDate و toDate

    print("From: $fromDate");
    print("To: $toDate");

    setState(() {});
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0:
        return const Center(child: Text("بانتظار الرد"));
      case 1:
        return const Center(child: Text("تم الموافقة"));
      case 2:
        return const Center(child: Text("تم الرفض"));
      case 3:
        return const Center(child: Text("ملغاة"));
      default:
        return const SizedBox();
    }
  }

  Widget _buildDateSelector({
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryOlive,
          ),
        ),
        SizedBox(height: 12),

        GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );

            if (picked != null) {
              onDateSelected(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // /// 🔵 Label
                // Text(
                //   label,
                //   style: const TextStyle(
                //     fontSize: 11,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.grey,
                //   ),
                // ),
                //
                // const SizedBox(height: 6),

                /// 📅 التاريخ أو النص الافتراضي
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? "لم يتم الاختيار"
                          : selectedDate.toString().split(" ").first,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(Icons.calendar_today_outlined, size: 18),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showFilterDialog() async {
    DateTime? tempFrom = fromDate;
    DateTime? tempTo = toDate;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                "اختر الفترة",
                style: TextStyle(color: AppColors.primaryOlive),
              ),

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(color: AppColors.primaryOlive),

                  /// 🔵 من تاريخ
                  _buildDateSelector(
                    label: "من تاريخ",
                    selectedDate: tempFrom,
                    onDateSelected: (date) {
                      setStateDialog(() {
                        tempFrom = date;
                      });
                    },
                  ),

                  const SizedBox(height: 15),

                  /// 🔴 إلى تاريخ
                  _buildDateSelector(
                    label: "إلى تاريخ",
                    selectedDate: tempTo,
                    onDateSelected: (date) {
                      setStateDialog(() {
                        tempTo = date;
                      });
                    },
                  ),
                ],
              ),

              actions: [
                Row(
                  children: [
                    /// 🔴 إلغاء
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: AppColors.primaryOlive),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          "إلغاء",
                          style: TextStyle(
                            color: AppColors.primaryOlive,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    /// 🔵 تطبيق
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            fromDate = tempFrom;
                            toDate = tempTo;
                          });

                          Navigator.pop(context);
                          _filterData();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: AppColors.primaryOlive,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "تطبيق",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTabs() {
    return Row(
      children: List.generate(4, (index) {
        final titles = ["بانتظار الرد", "تم الموافقة", "تم الرفض", "ملغاة"];

        final isSelected = selectedTabIndex == index;

        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedTabIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? primaryOlive : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  titles[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDateTimeField({
    required String label,
    required TextEditingController controller,
    bool isRequired = false,
  }) {
    return FormField<String>(
      validator: (value) {
        if (isRequired && controller.text.isEmpty) {
          return "هذا الحقل مطلوب";
        }
        return null;
      },
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔴 Label
              Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isRequired)
                    const Text(" *", style: TextStyle(color: Colors.red)),
                ],
              ),

              const SizedBox(height: 6),

              GestureDetector(
                onTap: () async {
                  FocusScope.of(state.context).unfocus();

                  DateTime? pickedDate = await showDatePicker(
                    context: state.context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate == null) return;

                  TimeOfDay? pickedTime = await showTimePicker(
                    context: state.context,
                    initialTime: TimeOfDay.now(),
                  );

                  pickedTime ??= TimeOfDay.now();

                  final finalDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );

                  final formatted =
                      "${finalDateTime.year}-"
                      "${finalDateTime.month.toString().padLeft(2, '0')}-"
                      "${finalDateTime.day.toString().padLeft(2, '0')} "
                      "${finalDateTime.hour.toString().padLeft(2, '0')}:"
                      "${finalDateTime.minute.toString().padLeft(2, '0')}";

                  controller.text = formatted;

                  state.didChange(formatted);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: state.hasError ? Colors.red : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// 📌 النص
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: controller,
                          builder: (_, value, __) {
                            return Text(
                              value.text.isEmpty ? "....." : value.text,
                              style: const TextStyle(fontSize: 12),
                            );
                          },
                        ),
                      ),

                      const Icon(Icons.calendar_today_outlined),
                    ],
                  ),
                ),
              ),

              /// 🔴 Error
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    state.errorText ?? "",
                    style: const TextStyle(color: Colors.red, fontSize: 11),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
  final Map<String, String> orgTypeMap = {
    "عادي": "Ordinary",
    "غير عادي": "ExtraOrdinary",
  };
  // --- Step 1: Input ---
  Widget _buildStep1(StateSetter setModalState) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildStepper(1),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: _buildField(
                  label: "org_type".tr(),
                  hint: "choose".tr(),
                  controller: nameController,
                  isRequired: true,
                  isDropdown: true,
                  items: orgTypeMap.keys.toList(), // 👈 اللي هيظهر
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildField(
                  label: "action".tr(),
                  hint: "enter_action".tr(),
                  controller: actionController,
                  isRequired: true,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: _buildDateTimeField(
                  label: "org_date".tr(),
                  controller: dateController,
                  isRequired: true,
                ),
              ),

            ],
          ),

          _buildAttachmentField(isRequired: true),
          _buildField(
            label: "notes".tr(),
            hint: "test_text".tr(),
            controller: notesController,
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: isAr ? Alignment.centerLeft : Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryOlive,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setModalState(() => currentStep = 2);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "next".tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    isAr ? Icons.arrow_forward : Icons.arrow_back,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildStep2(StateSetter setModalState, OrganizationState state) {
    return Column(
      children: [
        _buildStepper(2),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              _buildReviewRow("org_type".tr(), nameController.text),
              _buildReviewRow("action".tr(), actionController.text),
              _buildReviewRow("org_date_Time".tr(), dateController.text),
              _buildReviewRow(
                "attachments".tr(),
                selectedFile?.name ?? "",
                isLink: true,
              ),
              _buildReviewRow("notes".tr(), ""),

              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  notesController.text.isEmpty
                      ? "no_notes".tr()
                      : notesController.text,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryOlive,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),

                // ✅ هنا التعديل
                onPressed: state is CreateMeetingLoading
                    ? null
                    : () {
                  // ✅ تحويل التاريخ للفورمات الصح
                  DateTime parsedDate = DateTime.parse(
                    dateController.text.replaceFirst(" ", "T"),
                  );

                  String formattedDate = parsedDate.toUtc().toIso8601String();

                  final model = MeetingRequestModel(
                    meetingType: orgTypeMap[nameController.text] ?? "",
                    procedureType: actionController.text,
                    startTime: formattedDate, // ✅ هنا التعديل
                    attachmentDocumentIds: [0],
                    notes: notesController.text,
                  );

                  context.read<OrganizationCubit>().createMeetingRequest(
                    CacheHelper.getData("companyId"),
                    model,
                  );

                  setModalState(() => currentStep = 3);
                },

                // ✅ loading بدل النص
                child: state is CreateMeetingLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : Text(
                  "confirm_meeting".tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () => setModalState(() => currentStep = 1),
                child: Text(
                  "edit".tr(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- Step 3: Success ---
  Widget _buildStep3(OrganizationState state) {
    if (state is CreateMeetingLoading) {
      return const Column(
        children: [
          SizedBox(height: 30),
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text("جاري إنشاء الطلب..."),
        ],
      );
    }
    if (state is CreateMeetingSuccess) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text("تم بنجاح 🎉"),
                backgroundColor: AppColors.primaryOlive
            ),
          );
          widget.cubit.getCompanyMeetingsRequests(CacheHelper.getData("companyId"));
        }
      });
      Navigator.pop(context);

    }

    if (state is CreateMeetingError) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.primaryOlive
            ),
          );
          widget.cubit.getCompanyMeetingsRequests(CacheHelper.getData("companyId"));
        }
      });
      Navigator.pop(context);
    }

    return SizedBox();
  }

  // UI Helpers
  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    IconData? suffixIcon,
    bool isHighlighted = false,
    bool isDropdown = false,
    int maxLines = 1,
    bool isRequired = false,
    List<String>? items,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔴 Label + Star
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isRequired)
                const Text(
                  " *",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 6),

          /// 🔄 Dropdown or TextField
          isDropdown
              ? DropdownButtonFormField<String>(
                  value: controller.text.isEmpty ? null : controller.text,
                  items: items
                      ?.map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.text = value ?? '';
                  },
                  validator: (value) {
                    return SmartValidator.validate(
                      value,
                      fieldName: label,
                      required: isRequired,
                    );
                  },
                  decoration: InputDecoration(
                    hintText: hint,
                    filled: true,
                    fillColor: isHighlighted
                        ? primaryOlive.withOpacity(0.08)
                        : Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isHighlighted
                            ? primaryOlive
                            : Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: primaryOlive, width: 1.5),
                    ),
                  ),
                )
              : TextFormField(
                  controller: controller,
                  maxLines: maxLines,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlign: isAr ? TextAlign.right : TextAlign.left,
                  validator: (value) {
                    return SmartValidator.validate(
                      value,
                      fieldName: label,
                      required: isRequired,
                    );
                  },
                  onChanged: (value) {
                    _formKey.currentState?.validate();
                  },
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                    suffixIcon: suffixIcon != null
                        ? Icon(suffixIcon, size: 18)
                        : null,
                    filled: true,
                    fillColor: isHighlighted
                        ? primaryOlive.withOpacity(0.08)
                        : Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isHighlighted
                            ? primaryOlive
                            : Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: primaryOlive, width: 1.5),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildAttachmentField({bool isRequired = false}) {
    return FormField<PlatformFile>(
      validator: (value) {
        if (isRequired && value == null && selectedFile == null) {
          return "هذا الحقل مطلوب";
        }
        return null;
      },
      builder: (FormFieldState<PlatformFile> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔴 Label + Star
            Row(
              children: [
                Text(
                  "attachments".tr(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isRequired)
                  const Text(
                    " *",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 6),

            /// 📎 Upload Box
            GestureDetector(
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: [
                    'pdf',
                    'doc',
                    'docx',
                    'png',
                    'jpg',
                    'jpeg',
                  ],
                );

                if (result != null) {
                  final file = result.files.first;

                  /// 🔥 Check file size (2 MB)
                  if (file.size <= 2 * 1024 * 1024) {
                    setState(() {
                      selectedFile = file;
                    });

                    state.didChange(file); // مهم جداً
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("File size must be less than 2 MB"),
                      ),
                    );
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: selectedFile != null
                      ? primaryOlive.withOpacity(0.08)
                      : Colors.white,
                  border: Border.all(
                    color: state.hasError
                        ? Colors.red
                        : (selectedFile != null
                              ? primaryOlive
                              : Colors.grey.shade300),
                    width: selectedFile != null ? 1.5 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      selectedFile != null
                          ? Icons.check_circle
                          : Icons.cloud_upload_outlined,
                      color: selectedFile != null ? Colors.green : primaryOlive,
                    ),
                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        selectedFile?.name ?? "upload_hint".tr(),
                        style: TextStyle(
                          fontSize: 11,
                          color: selectedFile != null
                              ? Colors.black
                              : Colors.grey,
                          fontWeight: selectedFile != null
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                      ),
                    ),

                    /// ❌ Remove
                    if (selectedFile != null)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFile = null;
                          });
                          state.didChange(null);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            /// ❌ Error Message
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 11),
                ),
              ),

            const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  Widget _buildStepper(int step) {
    return Row(
      children: [
        stepCircle(
          isAr ? "1" : "2",
          isAr ? "details_step".tr() : "review_step".tr(),
          isAr ? true : step >= 2,
        ),
        Expanded(
          child: Container(
            height: 1,
            color: step >= 2 ? primaryOlive : Colors.grey.shade300,
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
        stepCircle(
          isAr ? "2" : "1",
          isAr ? "review_step".tr() : "details_step".tr(),
          isAr ? step >= 2 : step == 1,
        ),
      ],
    );
  }

  Widget _buildReviewRow(String label, String value, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isLink ? Colors.blue : Colors.black,
              decoration: isLink ? TextDecoration.underline : null,
            ),
          ),
        ],
      ),
    );
  }

  void _clearControllers() {
    nameController.clear();
    actionController.clear();
    cityController.clear();
    locationController.clear();
    dateController.clear();
    timeController.clear();
    emailController.clear();
    notesController.clear();
  }

  void _showAddOrganizationSheet() {
    currentStep = 1;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),

      // 👇 مهم جدًا نستخدم (_) مش (context)
      builder: (_) => BlocProvider.value(
        value: context.read<OrganizationCubit>(), // ✅ تمرير الكيوبيت

        child: BlocConsumer<OrganizationCubit, OrganizationState>(
          listener: (context, state) {

          },
          builder: (context, state) => StatefulBuilder(
            builder: (context, setModalState) => Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),

              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ===== Header =====
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "request_meeting".tr(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // ===== Steps =====
                    if (currentStep == 1)
                      _buildStep1(setModalState)
                    else if (currentStep == 2)
                      _buildStep2(setModalState, state)
                    else
                      _buildStep3(state),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getFilterText() {
    if (fromDate == null && toDate == null) {
      return "كل الفترات";
    }

    if (fromDate != null && toDate != null) {
      return "${fromDate!.toString().split(" ").first} → "
          "${toDate!.toString().split(" ").first}";
    }

    if (fromDate != null) {
      return "من ${fromDate!.toString().split(" ").first}";
    }

    return "إلى ${toDate!.toString().split(" ").first}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text("organizations".tr()),
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      //   leading: SizedBox(),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //
      //       icon: const Icon(Icons.arrow_forward, color: Colors.black),
      //       tooltip: "request_meeting".tr(),
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ✅ الصف الأول (الزر + لو عايز عناصر تانية)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _showAddOrganizationSheet,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryOlive,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.add, color: Colors.white, size: 18),
                    label: Text(
                      "request_meeting".tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Align(
            //   alignment: Alignment.centerRight,
            //   child: GestureDetector(
            //     onTap: _showFilterDialog,
            //     child: Container(
            //       // width: double.infinity,
            //       padding: const EdgeInsets.symmetric(
            //         horizontal: 14,
            //         vertical: 8,
            //       ),
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         border: Border.all(color: primaryOlive),
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       child: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //
            //           /// 🔵 النص اللي بيعرض الفترة
            //           Text(
            //             _getFilterText(),
            //             style: TextStyle(
            //               color: primaryOlive,
            //               fontSize: 12,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //
            //           const SizedBox(width: 6),
            //
            //           Icon(
            //             Icons.filter_list,
            //             size: 18,
            //             color: primaryOlive,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            //
            const SizedBox(height: 10),

            /// 🔥 المحتوى
            Expanded(
              child: BlocBuilder<OrganizationCubit, OrganizationState>(
                builder: (context, state) {
                  /// 🔄 Loading
                  if (state is GetRequestsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  /// ❌ Error
                  if (state is GetRequestsError) {
                    return Center(
                      child: Text(
                        "حدث خطأ: ${state.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  /// ✅ Success
                  if (state is GetRequestsSuccess) {
                    final requests = state.data.items ?? []; // حسب الموديل

                    /// 🟡 Empty
                    if (requests.isEmpty) {
                      return const Center(
                        child: Text(
                          "لا يوجد طلبات اجتماعات",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    /// 📋 List
                    return ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: requests.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final request = requests[index];

                        return OrganizationRequestWidget(
                          caseName: request.id?.toString() ?? '',

                          startDate: request.startTime != null
                              ? DateFormat(
                                  'yyyy-MM-dd',
                                ).format(request.startTime!)
                              : '',

                          Time: request.startTime != null
                              ? DateFormat('hh:mm a').format(request.startTime!)
                              : '',

                          boardMembers: request.status ?? '0',
                          activeMembers: request.id?.toString() ?? '0',
                          availableSeats: request.id?.toString() ?? '0',

                          status: request.status ?? "قيد الانتظار", // حسب API

                          onViewTap: () {
                            // TODO: تفاصيل الطلب
                          },

                          onGroupTap: () {
                            // TODO: navigation لو محتاج
                          },
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
