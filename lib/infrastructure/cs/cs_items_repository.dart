import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/check_sheet/shared/state/cs_item.dart';
import '../../domain/local_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import 'cs_remote_service.dart';

/// [SAVED] MODEL =>
///
/// [
///   [CSItem]
///
/// ]

class CSItemsRepository {
  CSItemsRepository(this._remoteService, this._storage);

  final CSRemoteService _remoteService;
  final CredentialsStorage _storage;

  Future<bool> hasOfflineData() => getCSItemsOFFLINE()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<CSItem>>> getCSItems() async {
    try {
      final listCSItem = await _remoteService.getCSItems();

      await _storage.save(CSItem.CSItemListToJson(listCSItem));

      // debugger();

      return right(listCSItem);
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

  /// DATA: [CSItem] FROM STORAGE
  ///
  Future<Either<RemoteFailure, List<CSItem>>> getCSItemsOFFLINE() async {
    try {
      final frameStorage = await _storage.read();

      // HAS MAP
      if (frameStorage != null) {
        final responsMap = jsonDecode(frameStorage) as List<dynamic>;

        final List<CSItem> response = CSItem.CSItemListFromJson(responsMap);

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

  Future<Unit> clearCSItemsStorage() async {
    final storedCredentials = await _storage.read();

    if (storedCredentials == null) {
      return unit;
    }

    await _storage.clear();

    return unit;
  }
}
