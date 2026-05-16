class AppException implements Exception {
  final _prefix;
  final _message;

  AppException([
    this._prefix,
    this._message,
  ]); // ([]) are Optional Positional parameter, here order matters

  String toString() => '$_prefix,$_message';
}

class FetchDataException extends AppException {
  FetchDataException([String? prefix])
      : super(prefix, "Error during communication");
}

class BadRequestException extends AppException {
  BadRequestException([String? prefix]) : super(prefix, "Invalid Request");
}

class UnauthorizedRequestException extends AppException {
  UnauthorizedRequestException([String? prefix])
      : super(prefix, 'Unauthorized Request');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? prefix]) : super(prefix, 'Invalid Input');
}
