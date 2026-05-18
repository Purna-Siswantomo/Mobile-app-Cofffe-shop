sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

class UnauthorizedException extends AppException {
  const UnauthorizedException() : super('Sesi berakhir, silakan login kembali');
}

class ForbiddenException extends AppException {
  const ForbiddenException() : super('Akses tidak diizinkan');
}

class NotFoundException extends AppException {
  const NotFoundException() : super('Data tidak ditemukan');
}

class ValidationException extends AppException {
  const ValidationException(this.errors) : super('Data tidak valid');

  final Map<String, List<String>> errors;
}

class ServerException extends AppException {
  const ServerException() : super('Terjadi kesalahan server');
}

class NetworkException extends AppException {
  const NetworkException() : super('Tidak ada koneksi internet');
}

class UnknownException extends AppException {
  const UnknownException(super.message);
}
