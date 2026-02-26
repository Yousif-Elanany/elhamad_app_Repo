import 'package:flutter/material.dart';
import '../../../../core/network/cache_helper.dart';
import '../../../../localization_service.dart';

class Appdrawer extends StatelessWidget {
  const Appdrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = LocalizationService.getLang() == 'ar';

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            //header
            Container(
              alignment: Alignment.center,
              height: 160,
              width: double.infinity,
              child: Image.asset("assets/images/alhamdsplash.png", height: 80),
            ),

            _drawerItem(
              icon: Icons.home,
              title: "home".tr(),
              onTap: () => Navigator.pushNamed(context, "/home"),
              isArabic: isArabic,
            ),

            _drawerItem(
              icon: Icons.room_service,
              title: "services".tr(),
              onTap: () => Navigator.pushNamed(context, "/service"),
              isArabic: isArabic,
            ),

            _drawerItem(
              icon: Icons.contact_support,
              title: "contact_us".tr(),
              onTap: () => Navigator.pushNamed(context, "/Contactus"),
              isArabic: isArabic,
            ),

            _drawerItem(
              icon: Icons.settings,
              title: "settings".tr(),
              onTap: () => Navigator.pushNamed(context, "/settings"),
              isArabic: isArabic,
            ),

            const Spacer(),

            _drawerItem(
              icon: Icons.logout,
              title: "logout".tr(),
              isLogout: true,
              onTap: () async {
                await CacheHelper.removeData('token');
                await CacheHelper.clear();
                Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
              },
              isArabic: isArabic,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _drawerItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
  bool isLogout = false,
  bool isArabic = true,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Icon(
            icon,
            color: isLogout ? Colors.red : Colors.black,
            size: 30,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: isLogout ? Colors.red : Colors.black,
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  );
}
