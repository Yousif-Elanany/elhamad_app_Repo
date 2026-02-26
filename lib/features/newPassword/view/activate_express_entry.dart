import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../localization_service.dart';
import '../../../core/routes/app_routes.dart';

class BiometricPage extends StatelessWidget {
  const BiometricPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = LocalizationService.getLang() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F5),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.fingerprint, size: 80, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "enable_biometric".tr(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "enable_biometric_desc".tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: "enable".tr(),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                    child: Text("later".tr(),
                        style: const TextStyle(color: Colors.grey, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
