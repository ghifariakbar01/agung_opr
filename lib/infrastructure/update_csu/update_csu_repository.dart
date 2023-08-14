import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/user/user_model.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../application/check_sheet/unit/state/csu_id_query.dart';
import '../../domain/local_failure.dart';
import '../../domain/value_objects_copy.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import 'update_csu_remote_service.dart';

class UpdateCSUFrameRepository {
  UpdateCSUFrameRepository(
    this._remoteService,
    this._userModelWithPassword,
    this._storage,
  );

  final UpdateCSUFrameRemoteService _remoteService;
  final UserModelWithPassword _userModelWithPassword;
  final CredentialsStorage _storage;

  // Future<bool> hasOfflineData() => getCSUItemsOffline()
  //     .then((credentials) => credentials.fold((_) => false, (_) => true));
  final tgl = DateFormat('yyyy-MM-dd')
      .parse(DateTime.now().toString())
      .toString()
      .substring(0, 10);

  final cAndUDate = DateTime.now()
      .toString()
      .substring(0, DateTime.now().toString().length - 3);

  Future<Either<RemoteFailure, Unit>> getIdIncrementAndGetQueryableCSU(
      {required List<CSUIDQuery> queryIds}) async {
    try {
      final isQueryOK = queryIds.isNotEmpty;

      debugger(message: 'called');

      log('STORAGE GET INCREMENTAL ID_NA QUERY: ${listCSUIDQueryToJsonSavable(queryIds)}');

      if (isQueryOK) {
        queryIds.forEach((queryId) async {
          final query = queryId.query;
          // RUN QUERY
          log('QUERY: ${query.runtimeType}');

          // GET ID_CS
          final idCS = await _remoteService.getIdForIncrement() + 1;

          if (query.contains('ID_CS_NA')) {
            query.replaceAll('ID_CS_NA', '$idCS');
          }
        });

        await _storage.save(listCSUIDQueryToJsonSavable(queryIds));

        debugger(message: 'called');

        log('STORAGE GET INCREMENTAL ID QUERY: ${listCSUIDQueryToJsonSavable(queryIds)}');
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

  Future<Either<LocalFailure, Unit>> saveCSUQueryNG(
      {required List<CSUIDQuery> queryIds}) async {
    try {
      final savedStrings = await _storage.read();
      final isQueryOK = queryIds.isNotEmpty;
      final isStorageSaved = savedStrings != null;

      if (isQueryOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              debugger(message: 'CALLED');
              final parsedResponse = jsonDecode(savedStrings!) as List<dynamic>;

              final response = listCSUIDQueryFromJson(parsedResponse);

              for (final queryId in queryIds) {
                final index = response
                    .indexWhere((element) => element.idUnit == queryId.idUnit);

                if (index == -1) {
                  final list = [...response, queryId];

                  await _storage.save(listCSUIDQueryToJsonSavable(list));

                  debugger(message: 'called');

                  log('STORAGE UPDATE CSU QUERY: ${listCSUIDQueryToJsonSavable(list)}');
                } else {
                  final list = [...response];

                  list[index] = CSUIDQuery(
                      idUnit: queryId.idUnit,
                      query: response[index].query + ' ' + queryId.query);

                  await _storage.save(listCSUIDQueryToJsonSavable(list));

                  debugger(message: 'called');

                  log('STORAGE UPDATE CSU QUERY: ${listCSUIDQueryToJsonSavable(list)}');
                }
              }
            }();
            break;
          case false:
            () async {
              final list = [...queryIds];

              log('STORAGE SAVE CSU QUERY: ${listCSUIDQueryToJsonSavable(list)}');

              await _storage.save(listCSUIDQueryToJsonSavable(list));
            }();
        }
      } else {
        throw LocalFailure.empty();
      }

      return right(unit);
    } on RangeError catch (e) {
      return left(LocalFailure.format('RANGE ERROR: ' + e.message));
    } on FormatException catch (e) {
      return left(LocalFailure.format('FORMAT ERROR: ' + e.message));
    } on JsonUnsupportedObjectError {
      return left(LocalFailure.format('JsonUnsupportedObjectError'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  Future<Either<LocalFailure, Unit>> saveCSUQueryOK(
      {required CSUIDQuery queryId}) async {
    try {
      final savedStrings = await _storage.read();
      final isQueryOK = queryId.query.isNotEmpty;
      final isStorageSaved = savedStrings != null;

      if (isQueryOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              debugger(message: 'CALLED');
              final parsedResponse = jsonDecode(savedStrings!) as List<dynamic>;

              final response = listCSUIDQueryFromJson(parsedResponse);

              final index = response
                  .indexWhere((element) => element.idUnit == queryId.idUnit);

              if (index == -1) {
                final list = [...response, queryId];

                await _storage.save(listCSUIDQueryToJsonSavable(list));

                debugger(message: 'called');

                log('STORAGE UPDATE CSU QUERY: ${listCSUIDQueryToJsonSavable(list)}');
              } else {
                final list = [...response];

                list[index] = queryId;

                await _storage.save(listCSUIDQueryToJsonSavable(list));

                debugger(message: 'called');

                log('STORAGE UPDATE CSU QUERY: ${listCSUIDQueryToJsonSavable(list)}');
              }
            }();
            break;
          case false:
            () async {
              final list = [queryId];

              log('STORAGE SAVE CSU QUERY: ${listCSUIDQueryToJsonSavable(list)}');

              await _storage.save(listCSUIDQueryToJsonSavable(list));
            }();
        }
      } else {
        throw LocalFailure.empty();
      }

      return right(unit);
    } on RangeError catch (e) {
      return left(LocalFailure.format('RANGE ERROR: ' + e.message));
    } on FormatException catch (e) {
      return left(LocalFailure.format('FORMAT ERROR: ' + e.message));
    } on JsonUnsupportedObjectError {
      return left(LocalFailure.format('JsonUnsupportedObjectError'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  CSUIDQuery getOKSavableQuery({
    required int idUnit,
    required String frameName,
    required Gate gate,
    required Deck posisi,
    required Supir1 supir1,
    required Supir2 supir2,
    required SupirSDR supirSDR,
    required TglKirim tglKirim,
    required TglTerima tglTerima,
    String idCS = 'ID_CS_NA',
    int inOut = 0,
    int noDefect = 0,
  }) {
    const String dbName = 'cs_trs_cs_test';

    final String insert =
        'INSERT INTO $dbName (id_cs, frame, inout, id_user, c_user, u_user, tgl, c_date, u_date, id_gate, posisi, supir1, supir2, no_defect, supir_sdr, tgl_kirim_unit, tgl_terima_unit)';

    final idUser = _userModelWithPassword.idUser;
    final nameUser = _userModelWithPassword.nama;

    final gateStr = gate.getOrCrash();
    final deckStr = posisi.getOrCrash();
    final supir1Str = supir1.getOrCrash();
    final supir2Str = supir2.getOrLeave('');
    final supirSDRStr = supirSDR.getOrLeave('');
    final tglKirimStr = tglKirim.getOrLeave('');
    final tglTerimaStr = tglTerima.getOrLeave('');

    final csuQuery =
        " '${gateStr}',  '${deckStr}',  '${supir1Str}', '${supir2Str}', '${noDefect}', '${supirSDRStr}', '${tglKirimStr}', '${tglTerimaStr}' ";

    final requiredQuery =
        " '${idCS}', '${frameName}', '${inOut}', '${idUser}', '${nameUser}', '${nameUser}', '${tgl}', '${cAndUDate}', '${cAndUDate}', ";

    final csuIdQuery = CSUIDQuery(
        idUnit: idUnit,
        query: insert + ' VALUES ' + '(${requiredQuery} ${csuQuery})');

    log('QUERY SAVE CSU : ${csuIdQuery.toJson()}');

    debugger(message: 'called');

    return csuIdQuery;
  }

  CSUIDQuery getNotGoodSavableQuery({
    required int idUnit,
    required int idCheckSheet,
    required int idJenisDefect,
    required int idPenyebabDefect,
    required String frameName,
    String idCS = 'ID_CS_NA',
  }) {
    const String dbName = 'cs_trs_cs_dtl_test';

    final String insert =
        'INSERT INTO $dbName (id_cs, frame, c_date, u_date, c_user,  u_user, id_item, id_jns_defect, id_p_defect)';

    final nameUser = _userModelWithPassword.nama;

    final csuQuery =
        " '${idCheckSheet}',  '${idJenisDefect}',  '${idPenyebabDefect}'";

    final requiredQuery =
        " '${idCS}', '${frameName}','${cAndUDate}', '${cAndUDate}', '${nameUser}', '${nameUser}',  ";

    final csuIdQuery = CSUIDQuery(
        idUnit: idUnit,
        query: insert + ' VALUES ' + '(${requiredQuery} ${csuQuery})');

    log('QUERY SAVE CSU : ${csuIdQuery.toJson()}');

    debugger(message: 'called');

    return csuIdQuery;
  }

  /// FROM [getUpdateQueryListSPKOFFLINE] to [updateCSUFrameByQuery]
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
