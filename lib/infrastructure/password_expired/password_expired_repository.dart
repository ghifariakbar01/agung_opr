import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../domain/local_failure.dart';
import '../credentials_storage.dart';

class PasswordExpiredRepository {
  PasswordExpiredRepository(this._credentialsStorage);

  final CredentialsStorage _credentialsStorage;

  Future<bool> isPasswordExpired() => getPasswordExpiredStorage()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<LocalFailure, String?>> getPasswordExpiredStorage() async {
    try {
      final storedCredentials = await _credentialsStorage.read();

      if (storedCredentials == null) {
        return left(LocalFailure.empty());
      }

      return right(storedCredentials);
    } on FormatException catch (e) {
      return left(LocalFailure.format(e.message));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  Future<Either<LocalFailure, Unit>> passwordExpired() async {
    try {
      await _credentialsStorage.save('${DateTime.now()}');

      return right(unit);
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  Future<Either<LocalFailure, Unit>> clearPasswordExpired() async {
    try {
      await _credentialsStorage.clear();

      return right(unit);
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }
}
