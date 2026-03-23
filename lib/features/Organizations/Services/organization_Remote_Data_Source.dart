import 'package:alhamd/features/managments/Models/MemberModel.dart';

import '../../../core/network/DioService.dart';
import '../model/OrganizationsRequestsResponseModel.dart';
import '../model/OrganizationsResponseModel.dart';

class OrganizationRemoteDataSource {
  ///// جلب معلومات الشركة
  Future<OrganizationsResponseModel> getCompanyMeetings(
    String companyId,
  ) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/meetings",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return OrganizationsResponseModel.fromJson(response.data);
  }

  Future<OrganizationsRequestsResponseModel> getCompanyMeetingsRequests(
    String companyId,
  ) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/meeting-requests",
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );
    print("response===> ${response.data}");

    return OrganizationsRequestsResponseModel.fromJson(response.data);
  }
}
