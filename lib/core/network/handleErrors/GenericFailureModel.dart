class Failure<T> {
  final String message;
  final int? statusCode;
  final T? data;

  const Failure({
    required this.message,
    this.statusCode,
    this.data,
  });
}
