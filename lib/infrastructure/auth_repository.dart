import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../domain/auth_failure.dart';
import '../domain/user_failure.dart';
import '../domain/value_objects_copy.dart';
import 'auth_remote_service.dart';
import 'credentials_storage.dart';
import 'exceptions.dart';

class AuthRepository {
  AuthRepository(
    this._credentialsStorage,
    this._remoteService,
  );

  final CredentialsStorage _credentialsStorage;
  final AuthRemoteService _remoteService;

  Future<bool> isSignedIn() => getSignedInUser()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<String> getUserString() => getSignedInUser()
      .then((value) => value.fold((_) => '', (userString) => userString ?? ''));

  Future<Either<AuthFailure, Unit>> signOut() async {
    return clearCredentialsStorage();
  }

  Future<Either<AuthFailure, Unit>> signInWithUsernameAndPassword({
    required UserId userId,
    required Password password,
    required Jobdesk jobdesk,
  }) async {
    try {
      final userIdStr = userId.getOrCrash();
      final passwordStr = password.getOrCrash();
      final jobdeskStr = jobdesk.getOrCrash();

      final authResponse = await _remoteService.signIn(
        userId: userIdStr,
        jobdesk: jobdeskStr,
        password: passwordStr,
      );

      return authResponse.when(
        withUser: (user) async {
          final userSave = jsonEncode(user);
          await _credentialsStorage.save(userSave);

          return right(unit);
        },
        failure: (errorCode, message) => left(AuthFailure.server(
          errorCode,
          message,
        )),
      );
    } on RestApiException catch (e) {
      return left(AuthFailure.server(e.errorCode));
    } on NoConnectionException {
      return left(const AuthFailure.noConnection());
    }
  }

  Future<Either<AuthFailure, Unit>> signInWithUsernameAndNoKtp({
    required UserId userId,
    required NoKtp noKtp,
    required Jobdesk jobdesk,
  }) async {
    try {
      final userIdStr = userId.getOrCrash();
      final passwordStr = noKtp.getOrCrash();
      final jobdeskStr = jobdesk.getOrCrash();

      final authResponse = await _remoteService.signInSupir(
        nama: userIdStr,
        jobdesk: jobdeskStr,
        noKtp: passwordStr,
      );

      return authResponse.when(
        withUser: (user) async {
          final userSave = jsonEncode(user);
          await _credentialsStorage.save(userSave);

          return right(unit);
        },
        failure: (errorCode, message) => left(AuthFailure.server(
          errorCode,
          message,
        )),
      );
    } on RestApiException catch (e) {
      return left(AuthFailure.server(e.errorCode));
    } on NoConnectionException {
      return left(const AuthFailure.noConnection());
    }
  }

  Future<Either<UserFailure, String?>> getSignedInUser() async {
    try {
      final storedCredentials = await _credentialsStorage.read();

      if (storedCredentials == null) {
        return left(UserFailure.empty());
      }

      return right(storedCredentials);
    } on FormatException {
      return left(UserFailure.errorParsing('Error while parsing'));
    } on PlatformException {
      return left(UserFailure.unknown(0, 'Platform exception while reading'));
    }
  }

  Future<Either<AuthFailure, Unit>> clearCredentialsStorage() async {
    try {
      await _credentialsStorage.clear();
      return right(unit);
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }
}
