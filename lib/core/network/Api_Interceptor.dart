import 'package:alhamd/core/constants/constants.dart';
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
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requiresToken = options.extra['requiresToken'] as bool? ?? true;

    if (requiresToken && !options.headers.containsKey('Authorization')) {
      // نحاول نجيب التوكن من getAccessToken أولاً
      String? token = await getAccessToken();

      // لو null، نجرب نجيب من CacheHelper
      token = CacheHelper.getData("token");

      print("🔑 [Interceptor] Token from getAccessToken: $token");

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    debugPrint(
      '📤 [REQUEST] ${options.method.toUpperCase()} => ${options.uri}',
    );
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final apiError = handleDioError(err);

    if (apiError.statusCode == 401) {
      // نجرب نجدد التوكن أولاً
      final refreshed = await refreshToken();

      if (refreshed) {
        // إعادة تنفيذ الـ request الأصلي مع التوكن الجديد
        final options = err.requestOptions;
        final newToken = await getAccessToken() ?? CacheHelper.getData("token");
        if (newToken != null) {
          options.headers['Authorization'] = 'Bearer $newToken';
        }

        final cloneReq = await dio.fetch(options);
        return handler.resolve(cloneReq);
      } else {
        // لو ما نجحش التجديد، نعمل logout
        await onLogout();
      }
    }

    super.onError(err, handler);
  }

  Future<bool> refreshToken() async {
    try {
      final refreshToken = await CacheHelper.getData("refToken");
      final response = await dio.post(
        '${baseUrl}auth/refresh',
        data: {'refreshToken': refreshToken},
        queryParameters: {
          "Accept-Language": "ar"
        },
        options: Options(
          extra: {'requiresToken': false}, // ما تحتاجش Authorization هنا
        ),
      );

      final newAccessToken = response.data['accessToken'];
      final newRefreshToken = response.data['refreshToken'];

      if (newAccessToken != null && newRefreshToken != null) {
        await CacheHelper.saveData(key: "token", value: newAccessToken);
        await CacheHelper.saveData(key: "refToken", value: newRefreshToken);
        return true;
      }

      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      '✅ [RESPONSE] ${response.statusCode} => ${response.requestOptions.uri}',
    );
    return handler.next(response);
  }
}
