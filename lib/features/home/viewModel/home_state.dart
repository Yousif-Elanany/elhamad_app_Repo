part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class HomeFailure extends HomeState {
  final String error;

  HomeFailure(this.error);
}

/// Company Info
class CompanyInfoLoading extends HomeState {}

class CompanyInfoSuccess extends HomeState {
  final CompanyDetailReasponseModel data;

  CompanyInfoSuccess(this.data);
}

class CompanyInfoFailure extends HomeState {
  final String error;

  CompanyInfoFailure(this.error);
}

/// Meeting Today
class MeetingTodayLoading extends HomeState {}

class MeetingTodaySuccess extends HomeState {
  final MeetingForTodayReasponseModel data;

  MeetingTodaySuccess(this.data);
}

class MeetingTodayFailure extends HomeState {
  final String error;

  MeetingTodayFailure(this.error);
}

/// Subscriptions
class SubscriptionsLoading extends HomeState {}

class SubscriptionsSuccess extends HomeState {
  final List<SubscriptionsResponseModel> data;

  SubscriptionsSuccess(this.data);
}

class SubscriptionsFailure extends HomeState {
  final String error;

  SubscriptionsFailure(this.error);
}

/// User For Me
class UserForMeLoading extends HomeState {}

class UserForMeSuccess extends HomeState {
  final AboutUserResponseModel data;

  UserForMeSuccess(this.data);
}

class UserForMeFailure extends HomeState {
  final String error;

  UserForMeFailure(this.error);
}

/// Management Not Completed
class ManagementNotCompletedLoading extends HomeState {}

class ManagementNotCompletedSuccess extends HomeState {
  final Map<String, dynamic> data;

  ManagementNotCompletedSuccess(this.data);
}

class ManagementNotCompletedFailure extends HomeState {
  final String error;

  ManagementNotCompletedFailure(this.error);
}