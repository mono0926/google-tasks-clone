class AppException implements Exception {
  const AppException(this.code);
  final String code;

  static const notImplemented = AppException(AppErrorCodes.notImplemented);
}

class AppErrorCodes {
  static const notImplemented = 'notImplemented';
}
