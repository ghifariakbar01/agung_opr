import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/state/csu_id_query.dart';
import 'package:agung_opr/application/check_sheet/unit/state/csu_items.dart';
import 'package:agung_opr/application/check_sheet/unit/state/csu_jenis_penyebab_item.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../domain/local_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import 'update_csu_remote_service.dart';

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

class UpdateCSUFrameRepository {
  UpdateCSUFrameRepository(this._remoteService, this._storage);

  final UpdateCSUFrameRemoteService _remoteService;
  final CredentialsStorage _storage;

  Future<bool> hasOfflineData() => getCSUItemsOffline()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  /// FROM [getUpdateQueryListSPKOFFLINE] to [updateFrameByQuery]
  ///
  Future<Either<RemoteFailure, Unit>> updateCSUFrameByQuery(
      {required List<CSUIDQuery> queryIds}) async {
    try {
      final isQueryOK = queryIds.isNotEmpty;

      if (isQueryOK) {
        queryIds.forEach((queryId) async {
          final query = queryId.query;
          final idUnit = queryId.idUnit;

          // RUN QUERY
          log('QUERY: ${query.runtimeType}');

          await _remoteService.insertFrameCSUByQuery(query: query);

          // DELETE SAVED QUERY
          await this._removeQueryCSUFromSaved(idUnit: idUnit);
        });
      }

      return right(unit);
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on RangeError catch (e) {
      return left(RemoteFailure.parse(message: e.message));
    } on FormatException catch (e) {
      return left(RemoteFailure.parse(message: e.message));
    } on JsonUnsupportedObjectError {
      return left(RemoteFailure.parse(message: 'JsonUnsupportedObjectError'));
    } on PlatformException {
      return left(RemoteFailure.storage());
    }
  }

  // REMOVE SAVED CSU QUERY
  Future<Unit> _removeQueryCSUFromSaved({required int? idUnit}) async {
    try {
      final savedStrings = await _storage.read();
      final isQueryOK = idUnit != null;
      final isStorageSaved = savedStrings != null;

      if (isQueryOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              debugger(message: 'CALLED');
              final parsedResponse = jsonDecode(savedStrings!) as List<dynamic>;

              final response = listCSUIDQueryFromJson(parsedResponse);

              final index =
                  response.indexWhere((element) => element.idUnit == idUnit);

              if (index == -1) {
                throw RangeError('ITEM QUERY NOT FOUND');
              } else {
                final item = response[index];
                final list = [...response.where((element) => element != item)];

                await _storage.save(jsonEncode(list));

                debugger(message: 'called');

                log('STORAGE UPDATE CSU FRAME DELETE: ${jsonEncode(list)}');

                return unit;
              }
            }();
            break;
          case false:
            throw LocalFailure.empty();
        }
      } else {
        throw LocalFailure.empty();
      }

      return unit;
    } on RangeError catch (e) {
      throw RangeError(e);
    } on FormatException catch (e) {
      throw FormatException('${e.message}');
    } on JsonUnsupportedObjectError catch (e) {
      throw JsonUnsupportedObjectError(e);
    } on PlatformException {
      throw PlatformException;
    }
  }

  Future<Either<RemoteFailure, List<CSUItems>>> getCSUItems() async {
    try {
      debugger(message: 'called');

      final listCSUItems = await _remoteService.getCSUItems();

      // await this._SAVECSUItems(csuItemsParam: listCSUItems);

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

  Future<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
      getCSUJenisItems() async {
    try {
      debugger(message: 'called');

      final listCSUJenisItems = await _remoteService.getCSUJenisItems();

      // await this._SAVECSUJenisItems(csuJenisItemsParam: listCSUJenisItems);

      return right(listCSUJenisItems);
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

  Future<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
      getCSUPenyebabItems() async {
    try {
      debugger(message: 'called');

      final listCsuPenyebabItemsParam =
          await _remoteService.getCSUPenyebabItems();

      // await this._SAVECSUPenyebabItems(
      //     csuPenyebabItemsParam: listCsuPenyebabItemsParam);

      return right(listCsuPenyebabItemsParam);
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

  // SAVE CSU JENIS ITEM IN STORAGE
  Future<Unit> _SAVECSUJenisItems(
      {required List<CSUJenisPenyebabItem> csuJenisItemsParam}) async {
    final isNewFrameOK = csuJenisItemsParam.isNotEmpty;

    if (isNewFrameOK) {
      final json = listCSUJenisPenyebabItemToJsonSavable(csuJenisItemsParam);

      await _storage.save(json);
    } else {
      throw FormatException(
          'new CSU ITEMS is Empty. In update_csu_repository _SAVECSUItems');
    }

    return unit;
  }

  // SAVE CSU PENYEBAB ITEM IN STORAGE
  Future<Unit> _SAVECSUPenyebabItems(
      {required List<CSUJenisPenyebabItem> csuPenyebabItemsParam}) async {
    final isNewFrameOK = csuPenyebabItemsParam.isNotEmpty;

    if (isNewFrameOK) {
      final json = listCSUJenisPenyebabItemToJsonSavable(csuPenyebabItemsParam);

      await _storage.save(json);
    } else {
      throw FormatException(
          'new CSU ITEMS is Empty. In update_csu_repository _SAVECSUItems');
    }

    return unit;
  }

  /// DATA: [CSUItems] FROM STORAGE
  ///
  /// get [CSUItems]
  Future<Either<RemoteFailure, List<CSUItems>>> getCSUItemsOffline() async {
    try {
      final csuItemStorage = await _storage.read();

      // debugger(message: 'called');

      log('CSU ITEM STORAGE: $csuItemStorage');

      // HAS MAP
      if (csuItemStorage != null) {
        debugger(message: 'called');

        final responsMap =
            jsonDecode(csuItemStorage) as List<Map<String, dynamic>>;

        final List<CSUItems> response = listCSUItemsFromJson(responsMap);

        debugger(message: 'called');

        log('CSU STORAGE RESPONSE: $response');

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
