import '../../../core/network/DioService.dart';
import '../Model/ContactUsModel.dart';

class ContactRemoteDataSource {
  Future<ContactUsResponseModel> getContactUs(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/announcements",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return ContactUsResponseModel.fromJson(response.data);
  }

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
