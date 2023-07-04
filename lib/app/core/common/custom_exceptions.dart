class NoInternetCustomException implements Exception {
  final String message;

  NoInternetCustomException({this.message = 'No internet connection'});

  @override
  String toString() => 'NoInternetCustomException: $message';
}

class ResponseCustomException implements Exception {
  final String message;

  ResponseCustomException(this.message);

  @override
  String toString() => 'ResponseCustomException: $message';
}

class UnknownNetworkCustomException implements Exception {
  final String message;

  UnknownNetworkCustomException({this.message = 'Unknown network error'});

  @override
  String toString() => 'UnknownNetworkCustomException: $message';
}
