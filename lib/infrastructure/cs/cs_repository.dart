import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/check_sheet/shared/state/cs_jenis_state.dart';
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
///   [CSJenisState]
///
/// ]

class CSRepository {
  CSRepository(this._remoteService, this._storage);

  final CSRemoteService _remoteService;
  final CredentialsStorage _storage;

  Future<bool> hasOfflineData() => getCSJenisOFFLINE()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<CSJenisState>>> getCSJenis() async {
    try {
      final listCSJenis = await _remoteService.getCSJenis();

      await _storage.save(CSJenisState.CSJenisListToJson(listCSJenis));

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

  /// DATA: [CSJenisState] FROM STORAGE
  ///
  Future<Either<RemoteFailure, List<CSJenisState>>> getCSJenisOFFLINE() async {
    try {
      final frameStorage = await _storage.read();

      // debugger(message: 'called');

      log('FRAME STORAGE: $frameStorage');

      // HAS MAP
      if (frameStorage != null) {
        debugger(message: 'called');

        final responsMap =
            jsonDecode(frameStorage) as List<Map<String, dynamic>>;

        final List<CSJenisState> response =
            CSJenisState.CSJenisListFromJson(responsMap);

        debugger(message: 'called');

        log('CS JENIS STORAGE RESPONSE: $response');

        if (response.isNotEmpty) {
          debugger(message: 'called');

          return right(response);
        } else {
          debugger(message: 'called');

          return left(RemoteFailure.parse(message: 'LIST EMPTY'));
        }
      } else {
        debugger(message: 'called');

        return left(RemoteFailure.parse(message: 'LIST EMPTY'));
      }
    } on RestApiException catch (e) {
      debugger(message: 'called');

      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      debugger(message: 'called');

      return left(RemoteFailure.noConnection());
    } on FormatException catch (error) {
      debugger(message: 'called');

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
}
