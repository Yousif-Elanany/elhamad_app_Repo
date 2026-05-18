import 'package:alhamd/features/massages/Models/MassageDetailResponseModel.dart';

import 'package:alhamd/features/massages/Models/createMassageRequestModel.dart';

import '../Models/MassageResponseModel.dart';
import '../Services/Massage_Remote_Data_Source.dart';

class MassageRepository implements MassageRemoteDataSource {
  final MassageRemoteDataSource remote;

  MassageRepository(this.remote);

  @override
  Future<MassageResponseModel> getMassage(String companyId) {
    return remote.getMassage(companyId);
  }

  @override
  Future<void> createMassage(String companyId, CreateMassageModel model) {
    return remote.createMassage(companyId, model);
  }

  @override
  Future<MassageDetailModel> getMassageById(String companyId, int massageId) {
    return remote.getMassageById(companyId, massageId);
  }

  @override
  Future<void> resendMassageById(String companyId, int massageId) {
    return remote.resendMassageById(companyId, massageId);
  }
}
