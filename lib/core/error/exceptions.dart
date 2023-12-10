import 'error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException(this.errorModel);
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class BadResposneException extends ServerException {
  BadResposneException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class FetchDataException extends ServerException {
  FetchDataException(super.errorModel);
}

class BadRequestException extends ServerException {
  BadRequestException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}
class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class NoInternetConnectionException extends ServerException {
  NoInternetConnectionException(super.errorModel,);
}



class ConflictException extends ServerException {
  ConflictException(super.errorModel);
}
class CancleExeption extends ServerException {
  CancleExeption(super.errorModel);
}