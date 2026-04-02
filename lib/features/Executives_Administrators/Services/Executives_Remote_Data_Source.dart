import 'package:alhamd/features/managments/Models/MemberModel.dart';
import 'package:flutter/foundation.dart';

import '../../../core/network/DioService.dart';
import '../../Committees/Model/UsersSigntureRequestModel.dart';
import '../Models/EditExecutiveModel.dart';
import '../Models/ExecutivesResponseModel.dart';
import '../Models/createExecutiveRequestModel.dart';
import '../Models/getExecutiveByProfileIdResponseModel.dart';

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

  ///// جلب معلومات الشركة
  Future<GetExecutiveByProfileIdResponseModel> getExecutiveByProfileId(
    String companyId,
    int profileId,
  ) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/executives/$profileId",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return GetExecutiveByProfileIdResponseModel.fromJson(response.data);
  }

  Future<void> createExecutives(
    String companyId,
    CreateExecutiveRequestModel requestModel,
  ) async {
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/executives",
      data: requestModel.toJson(),
      requiresToken: true,
    );
    if (kDebugMode) {
      print("response===> ${response.data}");
    }
  }

  Future<void> editExecutiveByProfileId(
    String companyId,
    int profileId,
    EditExecutiveModel requestModel,
  ) async {
    final response = await DioHelper.put(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/executives/$profileId",
      data: requestModel.toJson(),
      requiresToken: true,
    );
    if (kDebugMode) {
      print("response===> ${response.data}");
    }
  }

  Future<void> deleteExecutiveByProfileId(
    String companyId,
    int profileId,
  ) async {
    final response = await DioHelper.delete(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/executives/$profileId",
      requiresToken: true,
    );
    if (kDebugMode) {
      print("response===> ${response.data}");
    }
  }

  sendSignatureRequest(
    String companyId,
    UsersSigntureRequestModel model,
  ) async {
    final response = await DioHelper.post(
      query: {"Accept-Language": "ar"},
      "companies/$companyId/signature-requests",
      data: model.toJson(),
      requiresToken: true,
    );
    print("response===> ${response.data}");
  }
}
