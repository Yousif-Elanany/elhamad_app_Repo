part of 'documantation_cubit.dart';

@immutable
sealed class DocumantationState {}

/// الحالة الابتدائية
final class DocumantationInitial extends DocumantationState {}

/// =====================
/// Documentation
/// =====================

final class DocumentationLoading extends DocumantationState {}

final class DocumentationSuccess extends DocumantationState {
  final DocumentationResponseModel data;

  DocumentationSuccess(this.data);
}

final class DocumentationError extends DocumantationState {
  final String message;

  DocumentationError(this.message);
}

/// =====================
/// Documentation Requests
/// =====================

final class DocumentationRequestsLoading extends DocumantationState {}

final class DocumentationRequestsSuccess extends DocumantationState {
  final DocumentationRequestResponseModel data;

  DocumentationRequestsSuccess(this.data);
}

final class DocumentationRequestsError extends DocumantationState {
  final String message;

  DocumentationRequestsError(this.message);
}
