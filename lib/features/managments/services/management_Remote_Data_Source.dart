import 'package:alhamd/features/managments/Models/MemberModel.dart';

import '../../../core/network/DioService.dart';
import '../Models/DiewctorModel.dart';


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

  Future<MemberResponseModel> getMembers(String companyId,String boardId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/boards-of-directors/$boardId/members",
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );

    return MemberResponseModel.fromJson(response.data);
  }

  Future<Map<String,dynamic>> getShareHolders() async {
    final response = await DioHelper.get(
      "users/me",
      query: {"Accept-Language": "ar"},
      requiresToken: true, // المستخدم الجديد مش محتاج توكن
    );

    return response.data;
  }



}
