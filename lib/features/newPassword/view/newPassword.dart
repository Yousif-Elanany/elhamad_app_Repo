import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../localization_service.dart';
import '../../../core/routes/app_routes.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    final isArabic = LocalizationService.getLang() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F5),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                transform: Matrix4.translationValues(0, -30, 0),
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                  isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment:
                      isArabic ? Alignment.centerRight : Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios,
                            size: 16, color: Colors.black),
                        label: Text("back".tr(), style: const TextStyle(color: Colors.black)),
                      ),
                    ),
                    Text(
                      "new_password".tr(),
                      style:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "new_password_desc".tr(),
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 25),
                    Text("new_password".tr() + " *", style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: "new_password_hint".tr(),
                      isPassword: true,
                      controller: newPasswordController,
                    ),
                    const SizedBox(height: 20),
                    Text("confirm_password".tr() + " *",
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: "confirm_password_hint".tr(),
                      isPassword: true,
                      controller: confirmPasswordController,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F9F7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: isArabic
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            "password_requirements".tr(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const SizedBox(height: 8),
                          _buildRequirement("min_8_chars".tr()),
                          _buildRequirement("uppercase_lowercase".tr()),
                          _buildRequirement("at_least_one_number".tr()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      text: "save_password".tr(),
                      onPressed: () {
                        showSuccessSheet(context);
                      },
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.circle, size: 6, color: Colors.grey),
        ],
      ),
    );
  }
}

void showSuccessSheet(BuildContext context) {
  final isArabic = LocalizationService.getLang() == 'ar';
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) => Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 60),
            ),
            const SizedBox(height: 24),
            Text(
              "password_saved_success".tr(),
              style:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: "start".tr(),
              onPressed: () {
                Navigator.pushNamed(context, '/biometric');
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}
