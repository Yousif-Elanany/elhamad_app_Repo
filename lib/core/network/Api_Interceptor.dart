import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../main.dart';
import '../constants/app_colors.dart';
import 'cache_helper.dart';
import 'handleErrors/ApiException.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio;
  final Future<String?> Function() getAccessToken;
  final Future<void> Function() onLogout; // غير VoidCallback لـ Future

  ApiInterceptor({
    required this.dio,
    required this.getAccessToken,
    required this.onLogout,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final requiresToken = options.extra['requiresToken'] as bool? ?? true;

    if (requiresToken && !options.headers.containsKey('Authorization')) {
      // نحاول نجيب التوكن من getAccessToken أولاً
      String? token = await getAccessToken();

      // لو null، نجرب نجيب من CacheHelper
      token ??= CacheHelper.getToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    debugPrint('📤 [REQUEST] ${options.method.toUpperCase()} => ${options.uri}');
    return handler.next(options);
  }



  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final apiError = handleDioError(err);

    debugPrint('${err.requestOptions.uri}');
    debugPrint('Message: ${apiError.message}');

    if (apiError.statusCode == 401) {
      // 1️⃣ مسح البيانات المحلية
      await CacheHelper.clear();
      // 2️⃣ اظهار Toast
      Fluttertoast.showToast(
        msg: "تم انتهاء مدة الجلسة",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.primary,
        textColor: Colors.white,
      );

      // 3️⃣ توجيه المستخدم للصفحة المطلوبة
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/login', // route اسم صفحة تسجيل الدخول
            (route) => false, // يشيل كل الصفحات القديمة
      );
    }

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('✅ [RESPONSE] ${response.statusCode} => ${response.requestOptions.uri}');
    return handler.next(response);
  }
}
