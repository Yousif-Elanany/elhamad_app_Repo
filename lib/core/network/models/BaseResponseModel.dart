class BaseResponse<T> {
  final bool success;
  final String message;
  final T data;
  final int statusCode;

  BaseResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json) fromJsonT,
      ) {
    return BaseResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      data: fromJsonT(json['data']),
    );
  }
}
