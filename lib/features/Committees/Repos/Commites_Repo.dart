import 'package:alhamd/features/home/models/SubscriptionsModel.dart';
import 'package:alhamd/features/managments/Models/DiewctorModel.dart';
import 'package:alhamd/features/managments/Models/MemberModel.dart';
import 'package:alhamd/features/managments/services/management_Remote_Data_Source.dart';

import '../Model/committeesResponseModel.dart';
import '../Services/Committees_Remote_Data_Source.dart';

class CommitteesRepository implements CommitteesRemoteDataSource {
  final CommitteesRemoteDataSource remote;

  CommitteesRepository(this.remote);

  @override
  Future<CommitteesResponseModel> getCommittees(String companyId) {
    return remote.getCommittees(companyId);
  }


}
