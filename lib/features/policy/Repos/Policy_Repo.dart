import 'package:alhamd/features/home/models/SubscriptionsModel.dart';
import 'package:alhamd/features/managments/Models/DiewctorModel.dart';
import 'package:alhamd/features/managments/Models/MemberModel.dart';
import 'package:alhamd/features/managments/services/management_Remote_Data_Source.dart';
import 'package:alhamd/features/policy/Model/makeRequestPolicy.dart';

import '../Model/PolicyRequestDetailModel.dart';
import '../Model/PolicyResponseModel.dart';
import '../Model/policiesRequestResponseModel.dart';
import '../sevices/Policy_Remote_Data_Source.dart';

class PolicyRepository implements PolicyRemoteDataSource {
  final PolicyRemoteDataSource remote;

  PolicyRepository(this.remote);

  @override
  Future<PoliciesResponseModel> getPolicies(String companyId) {
    return remote.getPolicies(companyId);
  }

  @override
  Future<PoliciesRequestResponseModel> getPoliciesRequests(String companyId) {
    return remote.getPoliciesRequests(companyId);
  }

  @override
  Future<void> createPoliciesRequests(String companyId,
      CreateModelRequestModel model,) {
    return remote.createPoliciesRequests(companyId, model);
  }

  @override
  Future<void> deletePoliciesRequests(String companyId, int policyId) {
    return remote.deletePoliciesRequests(companyId, policyId);
  }

  @override
  Future<void> editPoliciesRequestById(String companyId,
      CreateModelRequestModel model,
      int policyId,) {
    return remote.editPoliciesRequestById(companyId, model, policyId);
  }

  @override
  Future<GetPolicyRequestDetailModel> getPoliciesRequestById(String companyId,
      int policyId,) {
    return remote.getPoliciesRequestById(companyId, policyId);
  }
}
