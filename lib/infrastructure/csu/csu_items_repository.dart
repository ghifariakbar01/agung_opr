import '../credentials_storage.dart';
import '../update_csu/update_csu_remote_service.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/state/csu_items.dart';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../domain/local_failure.dart';
import '../exceptions.dart';

/// LIST OF [CSUItems]
/// [SAVED] MODEL => [
/* 
    List<CSUItems> 

   [
    {
      "id_item": 1,
      "nama_ina": "Semua Area",
      "nama_eng": "All Area",
      "grup": "Exterior"
    },
    {
      "id_item": 1,
      "nama_ina": "Semua Area",
      "nama_eng": "All Area",
      "grup": "Exterior"
    },
    {
      "id_item": 1,
      "nama_ina": "Semua Area",
      "nama_eng": "All Area",
      "grup": "Exterior"
    }, 
   ]
   
*/

class CSUItemsRepository {
  CSUItemsRepository(this._remoteService, this._storage);

  final UpdateCSUFrameRemoteService _remoteService;
  final CredentialsStorage _storage;

  Future<bool> hasOfflineData() => getCSUItemsOffline()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<CSUItems>>> getCSUItems() async {
    try {
      // debugger(message: 'called');

      final listCSUItems = await _remoteService.getCSUItems();

      await this._SAVECSUItems(csuItemsParam: listCSUItems);

      return right(listCSUItems);
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

  /// DATA: [CSUItems] FROM STORAGE
  ///
  /// get [CSUItems]
  Future<Either<RemoteFailure, List<CSUItems>>> getCSUItemsOffline() async {
    try {
      final csuItemStorage = await _storage.read();

      debugger(message: 'called');

      log('CSU ITEM STORAGE: $csuItemStorage');

      // HAS MAP
      if (csuItemStorage != null) {
        // debugger(message: 'called');

        final responsMap =
            jsonDecode(csuItemStorage) as List<Map<String, dynamic>>;

        final List<CSUItems> response = listCSUItemsFromJson(responsMap);

        // debugger(message: 'called');

        log('CSU STORAGE RESPONSE: $response');

        if (response.isNotEmpty) {
          // debugger(message: 'called');

          return right(response);
        } else {
          // debugger(message: 'called');

          return left(RemoteFailure.parse(message: 'LIST EMPTY'));
        }
      } else {
        // debugger(message: 'called');

        return left(RemoteFailure.parse(message: 'LIST EMPTY'));
      }
    } on RestApiException catch (e) {
      // debugger(message: 'called');

      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      // debugger(message: 'called');

      return left(RemoteFailure.noConnection());
    } on FormatException catch (error) {
      // debugger(message: 'called');

      return left(RemoteFailure.parse(message: error.message));
    }
  }

// SAVE CSU ITEMS IN STORAGE
  Future<Unit> _SAVECSUItems({required List<CSUItems> csuItemsParam}) async {
    final isNewFrameOK = csuItemsParam.isNotEmpty;

    if (isNewFrameOK) {
      final json = listCSUItemsToJsonSavable(csuItemsParam);

      await _storage.save(json);
    } else {
      throw FormatException(
          'new CSU ITEMS is Empty. In update_csu_repository _SAVECSUItems');
    }

    return unit;
  }

  Future<Either<LocalFailure, String?>> getStorageCondition() async {
    try {
      final storedCredentials = await _storage.read();

      if (storedCredentials == null) {
        return left(LocalFailure.empty());
      }

      // debugger(message: 'called');

      return right(storedCredentials);
    } on FormatException {
      return left(LocalFailure.format('Error while parsing'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }
}
