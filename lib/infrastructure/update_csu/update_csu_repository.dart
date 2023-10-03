import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/update_csu/state/update_csu_ng_state.dart';
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

  Future<bool> hasOfflineData() => getStorageCondition()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, Unit>> updateCSUByQuery(
      {required List<CSUIDQuery> queryIds}) async {
    final isQueryOK = queryIds.isNotEmpty;

    // debugger(message: 'called');

    if (isQueryOK) {
      for (int i = 0; i < queryIds.length; i++) {
        final query = queryIds[i].query;
        final idUnit = queryIds[i].idUnit;

        log('INDEX $i');

        // GET ID_CS
        // debugger(message: 'called');

        log('STORAGE UPDATE CSU QUERY: $query');

        try {
          await _remoteService.insertFrameCSUByQuery(query: query);

          await _removeQueryCSUFromSaved(idUnit: idUnit);
        } on RestApiException catch (e) {
          debugger(message: 'called');

          await _removeQueryCSUFromSaved(idUnit: idUnit);

          return left(RemoteFailure.server(e.errorCode, e.message));
        } on NoConnectionException {
          debugger(message: 'called');

          // await _removeQueryCSUFromSaved(idUnit: idUnit);

          return left(RemoteFailure.noConnection());
        } on RangeError catch (e) {
          debugger(message: 'called');
          return left(RemoteFailure.parse(message: e.message));
        } on FormatException catch (e) {
          return left(RemoteFailure.parse(message: e.message));
        } on JsonUnsupportedObjectError {
          return left(
              RemoteFailure.parse(message: 'JsonUnsupportedObjectError'));
        } on PlatformException {
          return left(RemoteFailure.storage());
        }

        // debugger(message: 'called');

        // // DELETE SAVED QUERY
      }
    }

    debugger(message: 'called');

    return right(unit);
  }

  Future<Either<LocalFailure, Unit>> saveCSUQueryNG(
      {required CSUIDQuery queryId}) async {
    try {
      final savedStrings = await _storage.read();
      final isQueryOK = queryId.query.isNotEmpty;
      final isStorageSaved = savedStrings != null;

      if (isQueryOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              // debugger(message: 'CALLED');
              final parsedResponse = jsonDecode(savedStrings!) as List<dynamic>;

              final response =
                  CSUIDQuery.listCSUIDQueryFromJson(parsedResponse);

              final index = response
                  .indexWhere((element) => element.idUnit == queryId.idUnit);

              if (index == -1) {
                final list = [...response, queryId];

                await _storage
                    .save(CSUIDQuery.listCSUIDQueryToJsonSavable(list));

                // debugger(message: 'called');

                log('STORAGE UPDATE CSU QUERY: ${CSUIDQuery.listCSUIDQueryToJsonSavable(list)}');
              } else {
                // if not NG, replace list
                final list = [...response];

                list[index] = queryId;

                await _storage
                    .save(CSUIDQuery.listCSUIDQueryToJsonSavable(list));

                // debugger(message: 'called');

                log('STORAGE UPDATE CSU QUERY: ${CSUIDQuery.listCSUIDQueryToJsonSavable(list)}');
              }
            }();
            break;
          case false:
            () async {
              final list = [queryId];

              log('STORAGE SAVE CSU QUERY: ${CSUIDQuery.listCSUIDQueryToJsonSavable(list)}');

              await _storage.save(CSUIDQuery.listCSUIDQueryToJsonSavable(list));
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
      {required CSUIDQuery queryId, bool isNG = false}) async {
    try {
      final savedStrings = await _storage.read();
      final isQueryOK = queryId.query.isNotEmpty;
      final isStorageSaved = savedStrings != null;

      if (isQueryOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              // debugger(message: 'CALLED');
              final parsedResponse = jsonDecode(savedStrings!) as List<dynamic>;

              final response =
                  CSUIDQuery.listCSUIDQueryFromJson(parsedResponse);

              final index = response
                  .indexWhere((element) => element.idUnit == queryId.idUnit);

              if (index == -1) {
                final list = [...response, queryId];

                await _storage
                    .save(CSUIDQuery.listCSUIDQueryToJsonSavable(list));

                // debugger(message: 'called');

                log('STORAGE UPDATE CSU QUERY: ${CSUIDQuery.listCSUIDQueryToJsonSavable(list)}');
              } else {
                if (!isNG) {
                  // if not NG, replace list
                  final list = [...response];

                  list[index] = queryId;

                  await _storage
                      .save(CSUIDQuery.listCSUIDQueryToJsonSavable(list));

                  // debugger(message: 'called');

                  log('STORAGE UPDATE CSU QUERY: ${CSUIDQuery.listCSUIDQueryToJsonSavable(list)}');
                } else {
                  // if NG, coancenate
                  final list = [...response, queryId];

                  await _storage
                      .save(CSUIDQuery.listCSUIDQueryToJsonSavable(list));

                  // debugger(message: 'called');

                  log('STORAGE UPDATE CSU QUERY: ${CSUIDQuery.listCSUIDQueryToJsonSavable(list)}');
                }
              }
            }();
            break;
          case false:
            () async {
              final list = [queryId];

              log('STORAGE SAVE CSU QUERY: ${CSUIDQuery.listCSUIDQueryToJsonSavable(list)}');

              await _storage.save(CSUIDQuery.listCSUIDQueryToJsonSavable(list));
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
    required int inOut,
    required String frameName,
    required Gate gate,
    required Deck posisi,
    // required Supir1 supir1,
    // required Supir2 supir2,
    required SupirSDR supirSDR,
    required TglKirim tglKirim,
    required TglTerima tglTerima,
    required Keterangan keterangan,
    String idCS = 'ID_CS_NA',
    int noDefect = 0,
  }) {
    // TEST
    const String dbName = 'cs_trs_cs';

    // supir1, supir2,

    final String insert =
        'INSERT INTO $dbName (id_cs, frame, inout, id_user, c_user, u_user, tgl, c_date, u_date, id_gate, posisi, no_defect, supir_sdr, tgl_kirim_unit, tgl_terima_unit, ket)';

    final idUser = _userModelWithPassword.idUser;
    final nameUser = _userModelWithPassword.nama;

    final gateStr = gate.getOrLeave('');
    final gateInt = gateStr.isNotEmpty ? int.parse(gateStr) : 0;

    final deckStr = posisi.getOrLeave('');
    // final supir1Str = supir1.getOrCrash();
    // final supir2Str = supir2.getOrLeave('');

    final supirSDRStr = supirSDR.getOrLeave('');

    final tglKirimStr = tglKirim.getOrLeave('');
    final tglTerimaStr = tglTerima.getOrLeave('');

    final keteranganStr = keterangan.getOrLeave('');

    final tgl = DateFormat('yyyy-MM-dd')
        .parse(DateTime.now().toString())
        .toString()
        .substring(0, 10);

    final cAndUDate = DateTime.now()
        .toString()
        .substring(0, DateTime.now().toString().length - 3);

    // '${supir1Str}', '${supir2Str}'

    final csuQuery =
        " ${gateInt},  '${deckStr}', ${noDefect}, '${supirSDRStr}', '${tglKirimStr}', '${tglTerimaStr}', '${keteranganStr}' ";

    final requiredQuery =
        " (SELECT ISNULL(max(id_cs), 0) + 1 FROM $dbName), '${frameName}', ${inOut}, ${idUser}, '${nameUser}', '${nameUser}', '${tgl}', '${cAndUDate}', '${cAndUDate}', ";

    final csuIdQuery = CSUIDQuery(
        idUnit: idUnit,
        query: insert + ' VALUES ' + '(${requiredQuery} ${csuQuery})');

    log('QUERY SAVE CSU : ${csuIdQuery.toJson()}');

    debugger();

    return csuIdQuery;
  }

  CSUIDQuery getNGSavableQuery({
    required int idUnit,
    required String frameName,
    required List<UpdateCSUNGState> ngStates,
    String idCS = 'ID_CS_NA',
  }) {
    // TEST
    const String dbName = 'cs_trs_cs_dtl';
    const String dbNameCS = 'cs_trs_cs';

    final String insert =
        'INSERT INTO $dbName (id_cs, frame, c_date, u_date, c_user,  u_user, id_item, id_jns_defect, id_p_defect)';

    final nameUser = _userModelWithPassword.nama;

    final cAndUDate = DateTime.now()
        .toString()
        .substring(0, DateTime.now().toString().length - 3);

    final requiredQuery =
        " (SELECT ISNULL(max(id_cs), 0) + 1 FROM $dbNameCS), '${frameName}','${cAndUDate}', '${cAndUDate}', '${nameUser}', '${nameUser}',  ";

    List<int> idCheckSheet = [];
    List<int> idJenisDefect = [];
    List<int> idPenyebabDefect = [];

    if (ngStates.isNotEmpty) {
      for (final NG in ngStates) {
        idCheckSheet.add(NG.idCs);
        idJenisDefect.add(NG.idJenis);
        idPenyebabDefect.add(NG.idPenyebab);
      }
    }

    // CONVERT TO MAP, TO ADD ALL STRING
    Map<int, String> queryMap = {};

    for (int i = 0; i < idCheckSheet.length; i++) {
      final csuQueryIndex =
          " ${idCheckSheet[i]},  ${idJenisDefect[i]},  ${idPenyebabDefect[i]}";

      final queryIndex =
          insert + ' VALUES ' + ' (${requiredQuery} ${csuQueryIndex}) ';

      queryMap.addAll({idCheckSheet[i]: queryIndex});
    }

    // GET QUERY STRING
    final String queryString =
        queryMap.isNotEmpty ? queryMap.values.join(' ') : '';

    final CSUIDQuery csuIdQuery =
        CSUIDQuery(idUnit: idUnit, query: queryString);

    log('QUERY SAVE CSU : ${csuIdQuery.toJson()}');

    debugger(message: 'called');

    return csuIdQuery;
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
              // debugger(message: 'CALLED');
              final parsedResponse = jsonDecode(savedStrings!) as List<dynamic>;

              final response =
                  CSUIDQuery.listCSUIDQueryFromJson(parsedResponse);

              final index =
                  response.indexWhere((element) => element.idUnit == idUnit);

              if (index == -1) {
                throw RangeError('ITEM QUERY NOT FOUND');
              } else {
                final item = response[index];
                final list = [...response.where((element) => element != item)];

                await _storage.save(jsonEncode(list));

                // debugger(message: 'called');

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

  /// DATA: LIST OF [CSUIDQuery]
  ///
  Future<Either<LocalFailure, List<CSUIDQuery>>>
      getUpdateCSUQueryListOFFLINE() async {
    try {
      final savedStrings = await _storage.read();
      final isStorageSaved = savedStrings != null;

      if (isStorageSaved) {
        final parsedResponse = jsonDecode(savedStrings!) as List<dynamic>;

        final response = CSUIDQuery.listCSUIDQueryFromJson(parsedResponse);

        return right(response);
      } else {
        // debugger(message: 'CALLED');

        return right([]);
      }
    } on FormatException catch (e) {
      return left(LocalFailure.format(e.toString()));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  Future<Either<LocalFailure, String?>> getStorageCondition() async {
    try {
      final storedCredentials = await _storage.read();

      if (storedCredentials == null || storedCredentials == '[]') {
        return left(LocalFailure.empty());
      } else {
        // debugger(message: 'called');
        log('storedCredentials $storedCredentials');
      }

      return right(storedCredentials);
    } on FormatException {
      return left(LocalFailure.format('Error while parsing'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }
}
