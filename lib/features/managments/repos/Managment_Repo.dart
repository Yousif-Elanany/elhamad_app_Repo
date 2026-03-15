import 'package:alhamd/features/home/models/SubscriptionsModel.dart';
import 'package:alhamd/features/managments/Models/DiewctorModel.dart';
import 'package:alhamd/features/managments/Models/MemberModel.dart';
import 'package:alhamd/features/managments/services/management_Remote_Data_Source.dart';

class ManagementRepository implements ManagementRemoteDataSource {
  final ManagementRemoteDataSource remote;

  ManagementRepository(this.remote);

  @override
  Future<DirectorsResponseModel> getDirectors(String companyId) {
    return remote.getDirectors(companyId);
  }

  @override
  Future<MemberResponseModel> getMembers(String companyId, String boardId) {
    return remote.getMembers(companyId, boardId);
  }

  @override
  Future<Map<String, dynamic>> getShareHolders() {
    return remote.getShareHolders();
  }
}
