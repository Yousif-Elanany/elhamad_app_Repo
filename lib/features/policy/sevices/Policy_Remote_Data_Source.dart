import 'package:alhamd/features/managments/Models/MemberModel.dart';

import '../../../core/network/DioService.dart';
import '../Model/PolicyResponseModel.dart';
import '../Model/policiesRequestResponseModel.dart';

class PolicyRemoteDataSource {

     ///// جلب معلومات الشركة
  Future<PoliciesResponseModel> getPolicies(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/policies",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return PoliciesResponseModel.fromJson(response.data);
  }

  Future<PoliciesRequestResponseModel> getPoliciesRequests(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/policy-requests",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return PoliciesRequestResponseModel.fromJson(response.data);
  }


}
