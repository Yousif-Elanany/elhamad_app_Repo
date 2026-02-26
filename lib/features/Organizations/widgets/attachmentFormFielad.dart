import 'package:alhamd/core/constants/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../localization_service.dart';

Widget buildAttachmentField({
  bool isRequired = false,
  required BuildContext context,
  PlatformFile? selectedFile,
  void Function()? onTapForClose,
  void Function()? onTapForUpload,
}) {
  return FormField<PlatformFile>(
    validator: (value) {
      if (isRequired && value == null) {
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
            onTap: onTapForUpload,


            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: selectedFile != null
                    ? AppColors.primaryOlive.withOpacity(0.08)
                    : Colors.white,
                border: Border.all(
                  color: state.hasError
                      ? Colors.red
                      : (selectedFile != null
                            ? AppColors.primaryOlive
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
                    color: selectedFile != null
                        ? Colors.green
                        : AppColors.primaryOlive,
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
                      onTap: onTapForClose,


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
