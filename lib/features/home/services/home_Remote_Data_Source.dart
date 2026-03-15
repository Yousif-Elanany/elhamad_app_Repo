import '../../../core/network/DioService.dart';
import '../models/AboutUserModel.dart';
import '../models/CompanyDetailReasponseModel.dart';
import '../models/MeetingForTodayResponseModel.dart';
import '../models/SubscriptionsModel.dart';

class HomeRemoteDataSource {

  ///// جلب معلومات الشركة
  Future<CompanyDetailReasponseModel> getCompanyInfo(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/dashboard/company-details",
      requiresToken: true,
    );
print("response===> ${response.data['shareCount']}");
    return CompanyDetailReasponseModel.fromJson(response.data);
  }

  Future<MeetingForTodayReasponseModel> meetingForToday(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/dashboard/meetings/for-today",
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );

    return MeetingForTodayReasponseModel.fromJson(response.data);
  }

  Future<AboutUserResponseModel> userForMe() async {
    final response = await DioHelper.get(
      "users/me",
      query: {"Accept-Language": "ar"},
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );

    return AboutUserResponseModel.fromJson(response.data);
  }



  Future<List<SubscriptionsResponseModel>> getSubscriptions(String companyId) async {
    final response = await DioHelper.get(
      "companies/$companyId/subscriptions/usages",
      query: {"Accept-Language": "ar"},
      requiresToken: true,
    );

    // الريسبونس هنا عبارة عن List
    return List<SubscriptionsResponseModel>.from(
        response.data.map((x) => SubscriptionsResponseModel.fromJson(x)));
  }

  Future<Map<String, dynamic>> getManagementNotCompleted(
    String nationalId,
  ) async {
    final response = await DioHelper.post(
      "auth/login/sms/request",
      query: {"Accept-Language": "ar"},
      data: {
        "nationalId": nationalId,
      }, // مهم جدًا: حول الكائن لـ Map قبل الإرسال

      requiresToken: false, // المستخدم الجديد مش محتاج توكن
    );

    return response.data;
  }

}
