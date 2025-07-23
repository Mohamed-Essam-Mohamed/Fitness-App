class ServerException implements Exception {
  ServerException({required this.message, this.statusCode, this.errorData});
  final String message;
  final int? statusCode;
  final dynamic errorData;

  @override
  String toString() {
    return 'ServerException: $message (Status: $statusCode)';
  }
}
