// lib/network/api_exceptions.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// كلاس موحد لأي Error جاي من الـ API أو الـ Dio
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message)';
}

/// Utility Function لتحويل DioError أو أي Error لـ ApiException
ApiException handleDioError(dynamic error) {
  if (error is DioException) {
    final data = error.response?.data;

    debugPrint("🔥 Dio Response Data: $data");

    // لو الـ API رجع Map وفيه message نستخدمه
    if (data is Map && data['message'] != null) {
      return ApiException(data['message'].toString());
    }

    // لو الـ API رجع String مباشرة
    if (data is String) {
      return ApiException(data);
    }

    // حالات timeout و connection error
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException("⏱️ انتهت مهلة الاتصال بالسيرفر، حاول لاحقًا");
      case DioExceptionType.sendTimeout:
        return ApiException("🚀 انتهت مهلة الإرسال");
      case DioExceptionType.receiveTimeout:
        return ApiException("📩 انتهت مهلة استقبال البيانات من السيرفر");
      case DioExceptionType.cancel:
        return ApiException("❌ تم إلغاء الطلب");
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return ApiException("📡 لا يوجد اتصال بالإنترنت");
        }
        return ApiException("❓ خطأ غير متوقع: ${error.message}");
      case DioExceptionType.badCertificate:
        return ApiException("🔒 شهادة غير موثوقة من السيرفر");
      case DioExceptionType.connectionError:
        return ApiException("📡 خطأ في الاتصال بالسيرفر");
      case DioExceptionType.badResponse:
      // لو مفيش رسالة واضحة نستخدم نص عام
        return ApiException("⚠️ حدث خطأ من السيرفر");
    }
  } else if (error is SocketException) {
    return ApiException("📡 لا يوجد اتصال بالإنترنت");
  } else {
    return ApiException("❓ حدث خطأ غير معروف");
  }
}
