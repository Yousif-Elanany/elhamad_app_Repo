import '../../../core/network/DioService.dart';


class ContactRemoteDataSource {

  // Future<LoginResponseModel> login(LoginRequest request) async {
  //   final response = await DioHelper.post(
  //     query: {
  //       "Accept-Language" :"ar"
  //     },
  //     "auth/login",
  //     data: request.toJson(), // مهم جدًا: حول الكائن لـ Map قبل الإرسال
  //
  //     requiresToken: false, // المستخدم الجديد مش محتاج توكن
  //   );
  //
  //   return LoginResponseModel.fromJson(response.data);
  // }
  //
  // Future<Map<String, dynamic>> loginWithSms(String nationalId) async {
  //   final response = await DioHelper.post(
  //     "auth/login/sms/request",
  //     query: {
  //       "Accept-Language" :"ar"
  //     },
  //     data: {
  //       "nationalId": nationalId
  //     }, // مهم جدًا: حول الكائن لـ Map قبل الإرسال
  //
  //     requiresToken: false, // المستخدم الجديد مش محتاج توكن
  //   );
  //
  //   return response.data;
  // }
}
