import 'package:alhamd/features/managments/Models/MemberModel.dart';

import '../../../core/network/DioService.dart';
import '../Models/ExecutivesResponseModel.dart';

class ExecutivesRemoteDataSource {
  ///// جلب معلومات الشركة
  Future<ExecutivesResponseModel> getExecutives(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/executives",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return ExecutivesResponseModel.fromJson(response.data);
  }
}
