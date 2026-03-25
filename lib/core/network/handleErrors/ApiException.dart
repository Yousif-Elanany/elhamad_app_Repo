// lib/network/api_exceptions.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// ── Type Enum ─────────────────────────────────────────────────
enum ApiExceptionType {
  noInternet,
  timeout,
  serverError,
  unauthorized,
  forbidden,
  notFound,
  badRequest,
  cancelled,
  unknown,
}

/// كلاس موحد لأي Error جاي من الـ API أو الـ Dio
class ApiException implements Exception {
  final String message;
  final ApiExceptionType type;
  final int? statusCode;
  final dynamic data;

  ApiException(
      this.message, {
        this.type = ApiExceptionType.unknown,
        this.statusCode,
        this.data,
      });

  bool get isNoInternet  => type == ApiExceptionType.noInternet;
  bool get isUnauthorized => type == ApiExceptionType.unauthorized;
  bool get isServerError  => type == ApiExceptionType.serverError;
  bool get isTimeout      => type == ApiExceptionType.timeout;

  @override
  String toString() =>
      '$message)';
}

/// Utility Function لتحويل DioError أو أي Error لـ ApiException
ApiException handleDioError(dynamic error) {
  if (error is DioException) {
    final data = error.response?.data;
    debugPrint("🔥 Dio Response Data: $data");

    // لو الـ API رجع Map وفيه detail نستخدمه
    if (data is Map && data['detail'] != null) {
      return ApiException(
        data['detail'].toString(),
        type: _typeFromStatusCode(error.response?.statusCode),
        statusCode: error.response?.statusCode,
        data: data,
      );
    }

    // fallback لو فيه message
    if (data is Map && data['message'] != null) {
      return ApiException(
        data['message'].toString(),
        type: _typeFromStatusCode(error.response?.statusCode),
        statusCode: error.response?.statusCode,
        data: data,
      );
    }

    // لو الـ API رجع String مباشرة
    if (data is String && data.isNotEmpty) {
      return ApiException(
        data,
        type: _typeFromStatusCode(error.response?.statusCode),
        statusCode: error.response?.statusCode,
      );
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException(
          "⏱️ انتهت مهلة الاتصال بالسيرفر، حاول لاحقًا",
          type: ApiExceptionType.timeout,
        );

      case DioExceptionType.sendTimeout:
        return ApiException(
          "🚀 انتهت مهلة الإرسال",
          type: ApiExceptionType.timeout,
        );

      case DioExceptionType.receiveTimeout:
        return ApiException(
          "📩 انتهت مهلة استقبال البيانات من السيرفر",
          type: ApiExceptionType.timeout,
        );

      case DioExceptionType.cancel:
        return ApiException(
          "❌ تم إلغاء الطلب",
          type: ApiExceptionType.cancelled,
        );

      case DioExceptionType.badCertificate:
        return ApiException(
          "🔒 شهادة غير موثوقة من السيرفر",
          type: ApiExceptionType.serverError,
        );

      case DioExceptionType.connectionError:
        if (error.error is SocketException) {
          return ApiException(
            "📡 لا يوجد اتصال بالإنترنت",
            type: ApiExceptionType.noInternet,
          );
        }
        return ApiException(
          "🔌 تعذر الوصول للسيرفر، تحقق من اتصالك",
          type: ApiExceptionType.noInternet,
        );

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return ApiException(
            "📡 لا يوجد اتصال بالإنترنت",
            type: ApiExceptionType.noInternet,
          );
        }
        return ApiException(
          "❓ خطأ غير متوقع: ${error.message}",
          type: ApiExceptionType.unknown,
        );

      case DioExceptionType.badResponse:
        final code = error.response?.statusCode;
        return ApiException(
          _messageFromStatusCode(code),
          type: _typeFromStatusCode(code),
          statusCode: code,
        );
    }
  } else if (error is SocketException) {
    return ApiException(
      "📡 لا يوجد اتصال بالإنترنت",
      type: ApiExceptionType.noInternet,
    );
  }

  return ApiException(
    "❓ حدث خطأ غير معروف",
    type: ApiExceptionType.unknown,
  );
}
// ── Helpers ───────────────────────────────────────────────────
ApiExceptionType _typeFromStatusCode(int? code) {
  switch (code) {
    case 400: return ApiExceptionType.badRequest;
    case 401: return ApiExceptionType.unauthorized;
    case 403: return ApiExceptionType.forbidden;
    case 404: return ApiExceptionType.notFound;
    default:
      if (code != null && code >= 500) return ApiExceptionType.serverError;
      return ApiExceptionType.unknown;
  }
}

String _messageFromStatusCode(int? code) {
  switch (code) {
    case 400: return "⚠️ بيانات غير صحيحة";
    case 401: return "🔐 غير مصرح، تحقق من بياناتك";
    case 403: return "🚫 ليس لديك صلاحية";
    case 404: return "🔍 المورد غير موجود";
    case 500: return "🛠️ خطأ داخلي في السيرفر";
    default:  return "⚠️ حدث خطأ من السيرفر (${code ?? '?'})";
  }
}