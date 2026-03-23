import '../Models/MassageResponseModel.dart';
import '../Services/Massage_Remote_Data_Source.dart';

class MassageRepository implements MassageRemoteDataSource {
  final MassageRemoteDataSource remote;

  MassageRepository(this.remote);

  @override
  Future<MassageResponseModel> getMassage(String companyId) {
    return remote.getMassage(companyId);
  }


}
