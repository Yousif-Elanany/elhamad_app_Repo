import 'package:alhamd/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../localization_service.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final isArabic = LocalizationService.getLang() == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 16, color: Colors.black),
          label: Text("back".tr(), style: const TextStyle(color: Colors.black)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              "forgot_password".tr(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "forgot_password_desc".tr(),
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 40),
            Text("phone_or_email".tr(), style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: "phone_or_email_hint".tr(),
              controller: phoneController,
              textAlign: isArabic ? TextAlign.right : TextAlign.left, // ✅ هنا
            ),
            const Spacer(),
            CustomButton(
              text: "send_otp".tr(),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.otp);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
