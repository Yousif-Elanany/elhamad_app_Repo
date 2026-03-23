import '../../../core/network/DioService.dart';
import '../Models/TaskResponseModel.dart';

class MissionsRemoteDataSource {
  Future<TaskResponseModel> getMissions(String companyId) async {
    final response = await DioHelper.get(
      query: {"Accept-Language": "ar", "pageNumber": "1", "pageSize": "10"},
      "companies/$companyId/missions",
      requiresToken: true,
    );
    print("response===> ${response.data}");
    return TaskResponseModel.fromJson(response.data);
  }
}
