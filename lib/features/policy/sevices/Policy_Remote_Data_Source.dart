import 'package:alhamd/features/managments/Models/MemberModel.dart';

import '../../../core/network/DioService.dart';
import '../Model/PolicyRequestDetailModel.dart';
import '../Model/PolicyResponseModel.dart';
import '../Model/makeRequestPolicy.dart';
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

  Future<PoliciesRequestResponseModel> getPoliciesRequests(
      String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/policy-requests",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return PoliciesRequestResponseModel.fromJson(response.data);
  }

  Future<void> createPoliciesRequests(String companyId,
      CreateModelRequestModel model) async {
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/policy-requests",
      data: model.toJson(),
      requiresToken: true,
    );
    print("response===> ${response.data}");
  }

  Future<void> editPoliciesRequestById(String companyId,
      CreateModelRequestModel model, int policyId) async {
    final response = await DioHelper.put(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/policy-requests/$policyId",
      data: model.toJson(),
      requiresToken: true,
    );
    print("response===> ${response.data}");
  }

  Future<void> deletePoliciesRequests(String companyId, int policyId) async {
    final response = await DioHelper.delete(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/policy-requests/$policyId",
      requiresToken: true,
    );
    print("response===> ${response.data}");
  }


  Future<GetPolicyRequestDetailModel> getPoliciesRequestById(String companyId,
      int policyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/policy-requests/$policyId",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return GetPolicyRequestDetailModel.fromJson(response.data);
  }


}
