import 'dart:io';

class RException<T> implements Exception {
  static const String kUnknownError = "unknown_error";
  static const int kUnknownErrorCode = -1;
  static const int kItemContFound = 404;
  static const kErrorNoConnection = -1001;
  static const kErrorTimeout = -1004;

  final int code;
  final String message;
  final T? data;
  RException({
    this.code = -1,
    this.message = kUnknownError,
    this.data,
  });

  RException.code(int code, [String? message, T? data])
      : this(
          code: code,
          message: message ?? kUnknownError,
          data: data,
        );

  RException.unknown([String? message, T? data])
      : this(
          code: kUnknownErrorCode,
          message: message ?? kUnknownError,
          data: data,
        );

  RException.noConnection()
      : this(
          code: kErrorNoConnection,
          message: "no_connection",
        );

  RException.timeout()
      : this(
          code: kErrorTimeout,
          message: "connection_timeout",
        );

  factory RException.wrap(dynamic error, [T? data]) {
    if (error is RException) {
      if (data != null) {
        return RException.code(error.code, error.message, data);
      }
      return error as RException<T>;
    }

    if (_isFileNotFoundError(error)) {
      FileSystemException err = error;
      return RException(
          code: kItemContFound,
          message: err.osError?.message ?? kUnknownError,
          data: data);
    }

    return RException<T>.unknown(error.toString(), data);
  }

  @override
  String toString() {
    return "[$code][$message]";
  }

  bool isError(int code) => this.code == code;
  static bool isCode(error, int code) {
    return error is RException && error.code == code;
  }

  static bool isCodes(error, List<int> codes) {
    return error is RException && codes.contains(error.code);
  }
}

bool _isFileNotFoundError(error) =>
    error is FileSystemException && error.osError?.errorCode == 2;
