import 'package:alhamd/core/network/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/network/handleErrors/ApiException.dart';
import '../model/LoginRequestModel.dart';
import '../repo/auth_Repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository repository;

  LoginCubit(this.repository) : super(LoginInitial());

  Future<void> login(LoginRequest request) async {
    emit(LoginLoading());
    try {
      final response = await repository.login(request);
      CacheHelper.saveData(key: "token", value: response.accessToken);
      print("cashed token: ${CacheHelper.getData("token")}");
      emit(LoginSuccess(response.username ?? 'Login successful'));
    } catch (e) {
      if (e is ApiException) {
        emit(LoginFailure(e.message, type: e.type));
      } else {
        emit(LoginFailure(e.toString()));
      }
    }
  }

  Future<void> loginWithSms(String nationalId) async {
    emit(LoginSmsLoading());
    try {
      final response = await repository.loginWithSms(nationalId);
      emit(LoginSmsSuccess(response['message'] ?? 'SMS login successful'));
    } catch (e) {
      if (e is ApiException) {
        emit(LoginSmsFailure(e.message, type: e.type));
      } else {
        emit(LoginSmsFailure(e.toString()));
      }
    }
  }

  Future<void> verifyLoginWithSms(String nationalId, String pin) async {
    emit(VerifyLoginSmsLoading());
    try {
      final response = await repository.verifyLogin(nationalId, pin);
      CacheHelper.saveData(key: "token", value: response.accessToken);
      print("cashed token: ${CacheHelper.getData("token")}");


      emit(
        VerifyLoginSmsSuccess(
          "تم تسجيل الدخول بنجاح" ?? 'SMS verify successful',
        ),
      );
    } catch (e) {
      if (e is ApiException) {
        emit(VerifyLoginSmsFailure(e.message, type: e.type));
      } else {
        emit(VerifyLoginSmsFailure(e.toString()));
      }
    }
  }
}
