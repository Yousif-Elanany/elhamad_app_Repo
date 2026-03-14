import '../../../core/network/DioService.dart';
import '../model/LoginRequestModel.dart';
import '../model/LoginResponseModel.dart';

class AuthRemoteDataSource {
  Future<LoginResponseModel> verifyLogin(String nationalId,String pin) async {
    final response = await DioHelper.post(
      "auth/login/sms/verify",
      query: {
        "Accept-Language" :"ar"
      },
      data: {
        "nationalId": nationalId,
        "otp": pin

      }, // مهم جدًا: حول الكائن لـ Map قبل الإرسال

      requiresToken: false, // المستخدم الجديد مش محتاج توكن
    );
    print(response.data);
    return LoginResponseModel.fromJson(response.data);
  }
  Future<LoginResponseModel> login(LoginRequest request) async {
    final response = await DioHelper.post(
      query: {
        "Accept-Language" :"ar"
      },
      "auth/login",
      data: request.toJson(), // مهم جدًا: حول الكائن لـ Map قبل الإرسال

      requiresToken: false, // المستخدم الجديد مش محتاج توكن
    );
   print(response.data);
    return LoginResponseModel.fromJson(response.data);
  }

  Future<Map<String, dynamic>> loginWithSms(String nationalId) async {
    final response = await DioHelper.post(
      "auth/login/sms/request",
      query: {
        "Accept-Language" :"ar"
      },
      data: {
        "nationalId": nationalId
      }, // مهم جدًا: حول الكائن لـ Map قبل الإرسال

      requiresToken: false, // المستخدم الجديد مش محتاج توكن
    );

    return response.data;
  }


}
