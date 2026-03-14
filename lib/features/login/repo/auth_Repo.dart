import '../model/LoginRequestModel.dart';
import '../model/LoginResponseModel.dart';
import '../services/auth_remote_data_source.dart';

class AuthRepository implements AuthRemoteDataSource {
  final AuthRemoteDataSource remote;

  AuthRepository(this.remote);

  @override
  Future<LoginResponseModel> login(LoginRequest request) async {
    return await remote.login(request);
  }

  @override
  Future<Map<String, dynamic>> loginWithSms(String nationalId) async {
    return remote.loginWithSms(nationalId);
  }
  @override
  Future<LoginResponseModel> verifyLogin(String nationalId, String pin) {
    return remote.verifyLogin(nationalId, pin);
  }

}