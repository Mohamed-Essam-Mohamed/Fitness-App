
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic errorData;

  ServerException({required this.message, this.statusCode, this.errorData});

  @override
  String toString() {
    return 'ServerException: $message (Status: $statusCode)';
  }
}

