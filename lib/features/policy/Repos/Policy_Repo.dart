import 'package:alhamd/features/home/models/SubscriptionsModel.dart';
import 'package:alhamd/features/managments/Models/DiewctorModel.dart';
import 'package:alhamd/features/managments/Models/MemberModel.dart';
import 'package:alhamd/features/managments/services/management_Remote_Data_Source.dart';

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




}
