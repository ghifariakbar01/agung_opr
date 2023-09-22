import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/check_sheet/shared/state/cs_jenis.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../domain/local_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import 'cs_remote_service.dart';

/// [SAVED] MODEL =>
///
/// [
///   [CSJenis]
///
/// ]

class CSRepository {
  CSRepository(this._remoteService, this._storage);

  final CSRemoteService _remoteService;
  final CredentialsStorage _storage;

  Future<bool> hasOfflineData() => getCSJenisOFFLINE()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<CSJenis>>> getCSJenis() async {
    try {
      final listCSJenis = await _remoteService.getCSJenis();

      await _storage.save(CSJenis.CSJenisListToJson(listCSJenis));

      return right(listCSJenis);
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException catch (e) {
      return left(RemoteFailure.parse(message: e.message));
    } on JsonUnsupportedObjectError {
      return left(RemoteFailure.parse(message: 'JsonUnsupportedObjectError'));
    } on PlatformException {
      return left(RemoteFailure.storage());
    }
  }

  /// DATA: [CSJenis] FROM STORAGE
  ///
  Future<Either<RemoteFailure, List<CSJenis>>> getCSJenisOFFLINE() async {
    try {
      final csJenisStorage = await _storage.read();

      // debugger(message: 'called');

      log('CS JENIS STORAGE: $csJenisStorage');

      // HAS MAP
      if (csJenisStorage != null) {
        final responsMap = jsonDecode(csJenisStorage) as List<dynamic>;

        final List<CSJenis> response = CSJenis.CSJenisListFromJson(responsMap);

        log('CS JENIS STORAGE RESPONSE: $response');

        if (response.isNotEmpty) {
          return right(response);
        } else {
          return left(RemoteFailure.parse(message: 'LIST EMPTY'));
        }
      } else {
        return left(RemoteFailure.parse(message: 'LIST EMPTY'));
      }
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException catch (error) {
      return left(RemoteFailure.parse(message: error.message));
    }
  }

  Future<Either<LocalFailure, String?>> getStorageCondition() async {
    try {
      final storedCredentials = await _storage.read();

      if (storedCredentials == null) {
        return left(LocalFailure.empty());
      }

      debugger(message: 'called');

      return right(storedCredentials);
    } on FormatException {
      return left(LocalFailure.format('Error while parsing'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  Future<Unit> clearCSJenisStorage() async {
    final storedCredentials = await _storage.read();

    if (storedCredentials == null) {
      return unit;
    }

    await _storage.clear();

    return unit;
  }
}
