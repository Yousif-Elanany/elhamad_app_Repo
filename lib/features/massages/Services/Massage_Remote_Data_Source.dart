import 'package:alhamd/features/managments/Models/MemberModel.dart';

import '../../../core/network/DioService.dart';
import '../Models/MassageResponseModel.dart';

class MassageRemoteDataSource {
  ///// جلب MassageResponseModel الشركة
  Future<MassageResponseModel> getMassage(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/announcements",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return MassageResponseModel.fromJson(response.data);
  }
}
