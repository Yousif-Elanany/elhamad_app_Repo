// lib/network/dio_helper.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'api_interceptor.dart';
import 'handleErrors/ApiException.dart';

class DioHelper {
  static late Dio _dio;
  static final navigatorKey = GlobalKey<NavigatorState>();

  static late Future<String?> Function() _getAccessToken;
  static late Future<void> Function() _onLogout;

  /// تهيئة DioHelper
  static Future<void> init({
    required Future<String?> Function() getAccessToken,
    required Future<void> Function() onLogout,
  }) async {
    _getAccessToken = getAccessToken;
    _onLogout = onLogout;

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {},
      ),
    );

    _dio.interceptors.add(
      ApiInterceptor(
        dio: _dio,
        getAccessToken: _getAccessToken,
        onLogout: _onLogout,
      ),
    );
  }

  // ================== HTTP METHODS ==================

  static Future<Response> get(
      String url, {
        Map<String, dynamic>? query,
        Map<String, dynamic>? headers,
        bool requiresToken = false, // خلي الافتراضي false
        ResponseType responseType = ResponseType.json,   Map<String, dynamic>? data, // تقدر تغيّره حسب الحاجة
      }) async {
    try {
      return await _dio.get(
        url,
        queryParameters: query,
        options: _buildOptions(
          headers: headers,
          requiresToken: requiresToken,
          responseType: responseType, // مهم للملفات أو النصوص
        ),
      );
    } catch (e) {
      throw _extractError(e);
    }
  }


  static Future<Response> post(
      String url, {
        dynamic data,
        Map<String, dynamic>? query,
        Map<String, dynamic>? headers,
        bool requiresToken = true,
        bool? isMultipart,
        ResponseType? responseType, // 🔹 مهم جداً
      }) async {
    try {
      final options = _buildOptions(
        headers: headers,
        requiresToken: requiresToken,
      ).copyWith(
        responseType: responseType ?? ResponseType.json, // لو محددش يبقى JSON
      );

      return await _dio.post(
        url,
        queryParameters: query,
        data: data,
        options: options,
      );
    } catch (e) {
      throw _extractError(e);
    }
  }


  static Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    bool requiresToken = true,
  }) async {
    try {
      return await _dio.put(
        url,
        queryParameters: query,
        data: data,
        options: _buildOptions(headers: headers, requiresToken: requiresToken),
      );
    } catch (e) {
      throw _extractError(e);
    }
  }

  static Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool requiresToken = true,
  }) async {
    try {
      return await _dio.delete(
        url,
        queryParameters: query,
        data: data,
        options: _buildOptions(headers: headers, requiresToken: requiresToken),
      );
    } catch (e) {
      throw _extractError(e);
    }
  }

  // ================== PRIVATE HELPERS ==================

  /// يبني الـ Options بالهيدرز الافتراضية + اللي جاية من الكول
  static Options _buildOptions({
    Map<String, dynamic>? headers,
    bool requiresToken = true,
    ResponseType? responseType,
  }) {
    final finalHeaders = <String, dynamic>{
      ...?headers,
    };

    // 👈 حط Content-Type JSON بس لو مش Multipart
    if (!finalHeaders.containsKey('Content-Type')) {
      finalHeaders['Content-Type'] = 'application/json';
    }

    return Options(
      headers: finalHeaders,
      responseType: responseType,
      extra: {"requiresToken": requiresToken},
    );
  }


    /// هندل موحد للأخطاء (يعتمد على handleDioError)
    static ApiException _extractError(dynamic e) {
      return handleDioError(e);
    }
}
