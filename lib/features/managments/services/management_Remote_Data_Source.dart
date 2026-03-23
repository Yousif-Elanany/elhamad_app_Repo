import 'package:alhamd/features/managments/Models/MemberModel.dart';

import '../../../core/network/DioService.dart';
import '../Models/DiewctorModel.dart';
import '../Models/ShareHolderResponse.dart';

class ManagementRemoteDataSource {
  ///// جلب معلومات الشركة
  Future<DirectorsResponseModel> getDirectors(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/boards-of-directors",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return DirectorsResponseModel.fromJson(response.data);
  }

  Future<MemberResponseModel> getMembers(
    String companyId,
    String boardId,
  ) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/boards-of-directors/$boardId/members",
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );
    print("response===> ${response.data}");

    return MemberResponseModel.fromJson(response.data);
  }

  Future<ShareHoldersResponseModel> getShareHolders(
      String companyId,
      ) async {
    final response = await DioHelper.get(
      "companies/$companyId/shareholders",
      query: {"Accept-Language": "ar"},
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );
    print("response===> ${response.data}");
    return ShareHoldersResponseModel.fromJson(response.data);
  }
}
