import 'package:alhamd/core/network/cache_helper.dart';
import 'package:alhamd/features/home/repo/home_Repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/AboutUserModel.dart';
import '../models/CompanyDetailReasponseModel.dart';
import '../models/MeetingForTodayResponseModel.dart';
import '../models/SubscriptionsModel.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit(this.repository) : super(HomeInitial());
  CompanyDetailReasponseModel? companyInfo;
  MeetingForTodayReasponseModel? meetings;
  List<SubscriptionsResponseModel>? subscriptions;
  String? companyId;
  String? nationalId;

  Future<void> loadHomeData() async {
    print("🔥 loadHomeData called");
    try {
      emit(HomeLoading());

      /// 1️⃣ userForMe
      final user = await repository.userForMe();
      companyId = user.companyId;
      await CacheHelper.saveData(key: "companyId", value: companyId);
print( "userForMe===> Cashed , companyId: ${CacheHelper.getData("companyId")}");
      /// 2️⃣ company detail
      if (companyId != null) {
        companyInfo = await repository.getCompanyInfo(companyId!);
    print( "companyInfo===> ${companyInfo!.name}" );

      }

      /// 3️⃣ subscriptions2
      if (companyId != null) {
        subscriptions = await repository.getSubscriptions(companyId!);
      }

      /// 4️⃣ meetings
      if (companyId != null) {
        meetings = await repository.meetingForToday(companyId!);
      }

      emit(HomeSuccess());
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }


  /// Company Info
  Future<void> getCompanyInfo(String companyId) async {
    try {
      emit(CompanyInfoLoading());

      final data = await repository.getCompanyInfo(companyId);
      print(data);


      emit(CompanyInfoSuccess(data));
    } catch (e) {
      emit(CompanyInfoFailure(e.toString()));
    }
  }

  /// Meeting Today
  Future<void> meetingForToday(String companyId) async {
    try {
      emit(MeetingTodayLoading());

      final data = await repository.meetingForToday(companyId);

      emit(MeetingTodaySuccess(data));
    } catch (e) {
      emit(MeetingTodayFailure(e.toString()));
    }
  }

  /// Subscriptions
  Future<void> getSubscriptions(String companyId) async {
    try {
      emit(SubscriptionsLoading());

      final data = await repository.getSubscriptions(companyId);

      emit(SubscriptionsSuccess(data));
    } catch (e) {
      emit(SubscriptionsFailure(e.toString()));
    }
  }

  /// User For Me
  Future<void> userForMe() async {
    try {
      emit(UserForMeLoading());

      final data = await repository.userForMe();

      emit(UserForMeSuccess(data));
    } catch (e) {
      emit(UserForMeFailure(e.toString()));
    }
  }

  /// Management Not Completed
  Future<void> getManagementNotCompleted(String nationalId) async {
    try {
      emit(ManagementNotCompletedLoading());

      final data = await repository.getManagementNotCompleted(nationalId);

      emit(ManagementNotCompletedSuccess(data));
    } catch (e) {
      emit(ManagementNotCompletedFailure(e.toString()));
    }
  }
}