import 'package:alhamd/features/Committees/Model/UsersSigntureRequestModel.dart';
import 'package:alhamd/features/Executives_Administrators/Models/createExecutiveRequestModel.dart';
import 'package:alhamd/features/Executives_Administrators/Models/getExecutiveByProfileIdResponseModel.dart';


import '../Models/EditExecutiveModel.dart';
import '../Models/ExecutivesResponseModel.dart';
import '../Services/Executives_Remote_Data_Source.dart';

class ExecutivesRepository implements ExecutivesRemoteDataSource {
  final ExecutivesRemoteDataSource remote;

  ExecutivesRepository(this.remote);

  @override
  Future<ExecutivesResponseModel> getExecutives(String companyId) {
    return remote.getExecutives(companyId);
  }


  @override
  Future<void> deleteExecutiveByProfileId(String companyId,
      int profileId,) {
    return remote.deleteExecutiveByProfileId(
      companyId,
      profileId,
    );
  }

  @override
  Future<void> editExecutiveByProfileId(String companyId,
      int profileId,
      EditExecutiveModel requestModel,) {
    return remote.editExecutiveByProfileId(companyId, profileId, requestModel);
  }

  @override
  Future<GetExecutiveByProfileIdResponseModel> getExecutiveByProfileId(
      String companyId,
      int profileId,) {
    return remote.getExecutiveByProfileId(companyId, profileId);
  }

  @override
  Future<void> createExecutives(String companyId,
      CreateExecutiveRequestModel requestModel) {
    return remote.createExecutives(companyId, requestModel);
  }

  @override
  sendSignatureRequest(String companyId, UsersSigntureRequestModel model) {
    return remote.sendSignatureRequest(companyId, model);
  }
}
