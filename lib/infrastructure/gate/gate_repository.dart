import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/infrastructure/gate/gate_remote_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/gate/csu_mst_gate.dart';
import '../../domain/local_failure.dart';
import '../../domain/remote_failure.dart';
import '../cache_storage/gate_default_storage.dart';
import '../cache_storage/gate_storage.dart';
import '../exceptions.dart';

/// [SAVED] MODEL => [
/* 
    List<CSUMSTGate>

    example:
    [
      {
            "id": 43,
            "nama": "NT MITSUBISHI MEDAN SATRIA"
      },
      {
            "id": 44,
            "nama": "ACT MEDAN"
      },
      {
            "id": 45,
            "nama": "NISSAN PWK"
      },
    ]
    
*/

class GateRepository {
  GateRepository(
    this._remoteService,
    this._storage,
    this._storageDefault,
  );

  final GateRemoteService _remoteService;
  final GateStorage _storage;
  final GateDefaultStorage _storageDefault;

  Future<bool> hasOfflineData() => getGatesOFFLINE()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  // SAVE GATE ITEMS IN STORAGE
  Future<Unit> saveDefaultGate(CSUMSTGate defaultGate) async {
    final _json = defaultGate.toJson();
    final _save = jsonEncode(_json);
    await _storageDefault.save(_save);

    return unit;
  }

  Future<CSUMSTGate> readDefaultGate() async {
    final _save = await _storageDefault.read();

    if (_save == null) {
      return CSUMSTGate.initial();
    }

    final _json = jsonDecode(_save);

    return CSUMSTGate.fromJson(_json);
  }

  Future<Either<RemoteFailure, List<CSUMSTGate>>> getCSUGates() async {
    try {
      // debugger(message: 'called');

      final listCSUMSTGate = await _remoteService.getCSUGates();

      await this._SAVEGateItems(gateParam: listCSUMSTGate);

      return right(listCSUMSTGate);
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

  Future<Either<RemoteFailure, List<CSUMSTGate>>> searchGatesList(
      {required String search}) async {
    try {
      // debugger(message: 'called');

      final listCSUMSTGate =
          await _remoteService.searchGatesList(search: search);

      // await this._SAVECSUItems(csuItemsParam: listCSUMSTGate);

      return right(listCSUMSTGate);
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

  // SAVE GATE ITEMS IN STORAGE
  Future<Unit> _SAVEGateItems({required List<CSUMSTGate> gateParam}) async {
    final isNewFrameOK = gateParam.isNotEmpty;

    if (isNewFrameOK) {
      final json = listCSUMSTGateToJsonSavable(gateParam);

      await _storage.save(json);
    } else {
      throw FormatException(
          'new Gate Items are Empty. In gate_repository _SAVEGateItems');
    }

    return unit;
  }

  /// SEARCH BY [ID] , [NAMA]
  Future<Either<RemoteFailure, List<CSUMSTGate>>> searchGatesListOFFLINE(
      {required String search}) async {
    try {
      final gateStorage = await _storage.read();

      final searchUpperCase = search.toUpperCase();

      log('CSUMSTGate STORAGE: $gateStorage');

      // HAS LIST
      if (gateStorage != null) {
        final response = jsonDecode(gateStorage);

        List<CSUMSTGate> gateList = (response as List)
            .map((data) => CSUMSTGate.fromJson(data))
            .toList();

        final searchedList = gateList.where((element) {
          if (element.nama != null) {
            return element.id.toString() == search ||
                element.nama!.toUpperCase().contains(searchUpperCase);
          } else {
            return element.id.toString() == search;
          }
        }).toList();

        return right(searchedList);
      } else {
        return right([]);
      }
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException {
      return left(RemoteFailure.parse());
    }
  }

  /// DATA: [CSUMSTGate] FROM STORAGE
  ///
  /// get [CSUMSTGate]
  Future<Either<RemoteFailure, List<CSUMSTGate>>> getGatesOFFLINE() async {
    try {
      final csuItemStorage = await _storage.read();

      // debugger(message: 'called');

      log('CSU ITEM STORAGE: $csuItemStorage');

      // HAS MAP
      if (csuItemStorage != null) {
        // debugger(message: 'called');

        final responsMap = jsonDecode(csuItemStorage) as List<dynamic>;

        final List<CSUMSTGate> response = listCSUMSTGateFromJson(responsMap);

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

  Future<Unit> clearGateStorage() async {
    final storedCredentials = await _storage.read();

    if (storedCredentials == null) {
      return unit;
    }

    await _storage.clear();

    return unit;
  }
}
