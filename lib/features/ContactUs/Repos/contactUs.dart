import '../Services/Contact_Remote_Data_Source.dart';


class ContactRepository implements ContactRemoteDataSource {
  final ContactRemoteDataSource remote;

  ContactRepository(this.remote);

  // Future<LoginResponseModel> login(LoginRequest request) async {
  //   return await remote.login(request);
  // }
  //
  // @override
  // Future<Map<String, dynamic>> loginWithSms(String nationalId) async {
  //   return remote.loginWithSms(nationalId);
  // }
}
