import 'package:alhamd/features/Tasks/Models/TaskResponseModel.dart';
import '../services/Task_Remote_Data_Source.dart';


class MissionsRepository implements MissionsRemoteDataSource {
  final MissionsRemoteDataSource remote;

  MissionsRepository(this.remote);

  @override
  Future<TaskResponseModel> getMissions(String companyId) {
    return remote.getMissions(companyId);
  }


}
