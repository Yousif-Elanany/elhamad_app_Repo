import 'package:alhamd/features/home/models/SubscriptionsModel.dart';
import 'package:alhamd/features/managments/Models/DiewctorModel.dart';
import 'package:alhamd/features/managments/Models/MemberModel.dart';
import 'package:alhamd/features/managments/services/management_Remote_Data_Source.dart';

import '../Models/ExecutivesResponseModel.dart';
import '../Services/Executives_Remote_Data_Source.dart';

class ExecutivesRepository implements ExecutivesRemoteDataSource {
  final ExecutivesRemoteDataSource remote;

  ExecutivesRepository(this.remote);

  @override
  Future<ExecutivesResponseModel> getExecutives(String companyId) {
    return remote.getExecutives(companyId);
  }


}
