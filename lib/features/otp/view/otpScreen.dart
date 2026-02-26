import 'package:alhamd/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../localization_service.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = LocalizationService.getLang() == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            isArabic ? Icons.arrow_back_ios :
            Icons.arrow_back_ios,
            size: 16,
            color: Colors.black,
          ),
          label: Text("back".tr(), style: const TextStyle(color: Colors.black)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              "otp_title".tr(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "otp_desc".tr(),
              style: const TextStyle(color: Colors.grey),
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) => _otpBox()),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "resend".tr(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              text: "confirm".tr(),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.newPassword);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _otpBox() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
