import '../models/AboutUserModel.dart';
import '../models/CompanyDetailReasponseModel.dart';
import '../models/MeetingForTodayResponseModel.dart';
import '../services/home_Remote_Data_Source.dart';

class HomeRepository implements HomeRemoteDataSource {
  final HomeRemoteDataSource remote;

  HomeRepository(this.remote);


  //// جلب معلومات الشركة
  @override
  Future<CompanyDetailReasponseModel> getCompanyInfo(String companyId) {
    return remote.getCompanyInfo(companyId);
  }

  @override
  Future<MeetingForTodayReasponseModel> meetingForToday(String companyId) {
    return remote.meetingForToday(companyId);
  }


  @override
  Future<Map<String, dynamic>> getSubscriptions(String nationalId) {
    return remote.getSubscriptions(nationalId);
  }


  @override
  Future<AboutUserResponseModel> userForMe() {
    return remote.userForMe();
  }



  @override
  Future<Map<String, dynamic>> getManagementNotCompleted(String nationalId) {
    return remote.getManagementNotCompleted(nationalId);
  }
}
