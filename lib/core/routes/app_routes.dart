import 'package:alhamd/features/Executives_Administrators/views/screens/Executives_Administrators_screen.dart';
import 'package:alhamd/features/notification/view/notification.dart';
import 'package:flutter/material.dart';

import '../../features/Executives_Administrators/views/screens/Executives_Administrators_screen.dart';
import '../../features/Organizations/view/Organizations.dart';
import '../../features/forgetpassword/view/forgetPasswordScreen.dart';
import '../../features/home/view/screens/homePage.dart';
import '../../features/policy/views/screens/RulesAndRegulations.dart';
import '../../features/setting/view/settings.dart';
import '../../features/login/view/loginscreen.dart';
import '../../features/meeting/view/meetingDetailed.dart';
import '../../features/meeting/view/metting.dart';
import '../../features/newPassword/view/activate_express_entry.dart';
import '../../features/newPassword/view/newPassword.dart';
import '../../features/otp/view/otpScreen.dart';
import '../../features/home/view/screens/contactUs.dart';
import '../../features/service/view/service.dart';

class AppRoutes {
  static const String login = '/';
  static const String forgotPassword = '/forgotPassword';
  static const String otp = '/otp';
  static const String newPassword = '/newPassword';
    static const String Administrators = '/ExecutivesAdministrators';
  static const String biometric ='/biometric';
  static const String home='/home';
  static const String service='/service';
  static const String meeting='/meeting';
  static const String notification='/notification';
  static const String meetingDetailed='/detailed';
  static const String organizations="/organizations";
  static const String contactus="/Contactus";
  static const String settingspage="/settings";
  static const String rules="/Rule";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case rules:
        return MaterialPageRoute(builder: (_) => const RulesAndRegulations());
      case Administrators:
        return MaterialPageRoute(builder: (_) => const ExecutivesAdministrators());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case otp:
        return MaterialPageRoute(builder: (_) => const OtpPage());
      case newPassword:
        return MaterialPageRoute(builder: (_) => const NewPasswordPage());
      case biometric:
        return MaterialPageRoute(builder: (context) => BiometricPage(),);
      case home:
        return MaterialPageRoute(builder: (context) => CompanyHomePage(),);
      case service:
        return MaterialPageRoute(builder: (context) => ServicesPage(),);
      case meeting:
        return MaterialPageRoute(builder: (context) => MeetingsPage(),);
      case notification:
        return MaterialPageRoute(builder: (context) => NotificationsPage(),);
      case meetingDetailed:
        return MaterialPageRoute(builder: (context) => MeetingDetailsPage(),);
      case organizations:
        return MaterialPageRoute(builder: (context) => Organizations(),);
      case contactus:
        return MaterialPageRoute(builder: (context) => Contactus(),);
      case settingspage:
        return MaterialPageRoute(builder: (context) => Settings(),);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}