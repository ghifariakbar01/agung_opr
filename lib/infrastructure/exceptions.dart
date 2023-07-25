class CacheException implements Exception {}

class RestApiException implements Exception {
  RestApiException(this.errorCode, this.message);

  final int? errorCode;
  final String? message;
}

class NoConnectionException implements Exception {}

class UnknownException implements Exception {}
