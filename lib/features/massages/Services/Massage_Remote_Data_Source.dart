import 'package:alhamd/features/managments/Models/MemberModel.dart';

import '../../../core/network/DioService.dart';
import '../Models/MassageDetailResponseModel.dart';
import '../Models/MassageResponseModel.dart';
import '../Models/createMassageRequestModel.dart';

class MassageRemoteDataSource {
  ///// جلب MassageResponseModel الشركة
  Future<MassageResponseModel> getMassage(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/announcements",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return MassageResponseModel.fromJson(response.data);
  }

  Future<void> createMassage(String companyId, CreateMassageModel model) async {
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar"},
      data: model.toJson(),
      "companies/$companyId/announcements",
      requiresToken: true,
    );
    print("response===> ${response.data}");
  }

  Future<MassageDetailModel> getMassageById(String companyId,
      int massageId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/announcements/$massageId",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return MassageDetailModel.fromJson(response.data);
  }

  Future<void> resendMassageById(String companyId, int massageId) async {
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/announcements/$massageId/resend-failed",
      requiresToken: true,
    );
    print("response===> ${response.data}");
  }

}
