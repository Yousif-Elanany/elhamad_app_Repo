import 'package:flutter/material.dart';
import '../../../localization_service.dart';
import '../../home/view/widgets/appdrawer.dart';
// تأكد من المسار الصحيح للـ LocalizationService
// import '../../../core/localization/localization_service.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    // نعرف اللغة الحالية عشان نحدد حالة الزرار
    String currentLang = LocalizationService.getLang();

    return Scaffold(
      drawer: const Appdrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          "settings".tr(),
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // كارت تغيير اللغة
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: ListTile(
              leading: const Icon(Icons.language, color: Color(0xff86896E)),
              title: Text("language".tr()),
              subtitle: Text("current_language_name".tr()),
              trailing: Switch(
                value: currentLang == 'en',
                activeColor: const Color(0xff86896E),
                onChanged: (bool value) async {
                  // تغيير اللغة
                  String newLang = value ? 'en' : 'ar';
                  await LocalizationService.changeLanguage(newLang);

                  // إعادة بناء الشاشة الحالية
                  if (mounted) {
                    setState(() {});

                    // نصيحة احترافية: إذا كنت تستخدم MaterialApp مع locale،
                    // التغيير سيسمع في التطبيق كله تلقائياً.
                  }
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          // قسم "عن التطبيق" كمثال لشكل الإعدادات
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "change_app_language".tr(),
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}