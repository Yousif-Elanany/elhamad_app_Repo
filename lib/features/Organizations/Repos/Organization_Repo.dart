import 'package:alhamd/features/Organizations/Services/organization_Remote_Data_Source.dart';
import 'package:alhamd/features/home/models/SubscriptionsModel.dart';
import 'package:alhamd/features/managments/Models/DiewctorModel.dart';
import 'package:alhamd/features/managments/Models/MemberModel.dart';
import 'package:alhamd/features/managments/services/management_Remote_Data_Source.dart';

import '../model/OrganizationsRequestsResponseModel.dart';
import '../model/OrganizationsResponseModel.dart';

class OrganizationRepository implements OrganizationRemoteDataSource {
  final OrganizationRemoteDataSource remote;

  OrganizationRepository(this.remote);

  @override
  Future<OrganizationsRequestsResponseModel> getCompanyMeetingsRequests(String companyId) {
    return remote.getCompanyMeetingsRequests(companyId);
  }

  @override
  Future<OrganizationsResponseModel> getCompanyMeetings(String companyId) {
    return remote.getCompanyMeetings(companyId);
  }




}
