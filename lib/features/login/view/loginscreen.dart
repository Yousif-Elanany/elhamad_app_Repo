import 'package:flutter/material.dart';
import '../../../core/network/cache_helper.dart';
import '../../../core/routes/app_routes.dart';
import '../../../localization_service.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController userController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final isArabic = LocalizationService.getLang() == 'ar';

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5), // لون الخلفية
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: isArabic ? CrossAxisAlignment.start : CrossAxisAlignment.start,


          children: [
            // شعار التطبيق
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              color: Colors.white,
              child: Center(
                child: Image.asset('assets/images/alhamdsplash.png', width: 150),
              ),
            ),

            // الكارد الأبيض
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
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: isArabic ? CrossAxisAlignment.start :
                CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 10),

                  // عنوان الصفحة
                  Text(
                    "login".tr(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // اسم المستخدم
                  Text("username_label".tr(),
                      style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: "username_hint".tr(),
                    controller: userController,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  ),

                  const SizedBox(height: 20),

                  // كلمة المرور
                  Text("password_label".tr(), style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 8),

                    CustomTextField(
                      hintText: "password_hint".tr(),
                      isPassword: true,
                      controller: passwordController,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    ),


                  const SizedBox(height: 10),

                  // تذكرني ونسيت كلمة المرور
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (val) {},
                            activeColor: const Color(0xFF86896E),
                          ),
                          Text("remember_me".tr(), style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "forgot_password?".tr(),
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // زر تسجيل الدخول
                  CustomButton(
                    text: "login".tr(),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.forgotPassword);
                    },
                  ),

                  const SizedBox(height: 20),

                  // زر تغيير اللغة
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        // تبديل اللغة
                        String newLang = LocalizationService.getLang() == 'en' ? 'ar' : 'en';
                        await LocalizationService.changeLanguage(newLang);

                        // إعادة بناء الصفحة لإظهار اللغة الجديدة
                        setState(() {});
                      },
                      child: Text(
                        "change_lang".tr(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
