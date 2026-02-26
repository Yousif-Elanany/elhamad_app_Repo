import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/network/cache_helper.dart';
import 'features/Organizations/model/organization_model.dart';
import 'core/routes/app_routes.dart';
import 'features/login/view/loginscreen.dart';
import 'localization_service.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await CacheHelper.init();
  await LocalizationService.init();
  Hive.registerAdapter(OrganizationAdapter());

  await Hive.openBox<Organization>('organizations');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LocalizationService.box.listenable(),
      builder: (context, box, _) {
        final isArabic = LocalizationService.getLang() == 'ar';

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.login,
          navigatorKey: navigatorKey,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          locale: Locale(isArabic ? 'ar' : 'en'),
          builder: (context, child) {
            return Directionality(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: child!,
            );
          },
        );
      },
    );
  }
}
