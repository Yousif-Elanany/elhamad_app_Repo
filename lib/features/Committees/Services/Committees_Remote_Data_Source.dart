import 'package:alhamd/features/managments/Models/MemberModel.dart';

import '../../../core/network/DioService.dart';
import '../Model/committeesResponseModel.dart';

class CommitteesRemoteDataSource {

     ///// جلب معلومات الشركة
  Future<CommitteesResponseModel> getCommittees(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/committees",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return CommitteesResponseModel.fromJson(response.data);
  }


}
