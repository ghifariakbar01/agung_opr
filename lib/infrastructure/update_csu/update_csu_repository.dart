import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/update_csu/state/update_csu_ng_state.dart';
import 'package:agung_opr/application/user/user_model.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../application/check_sheet/unit/state/csu_id_query.dart';
import '../../constants/constants.dart';
import '../../domain/local_failure.dart';
import '../../domain/value_objects_copy.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import 'update_csu_remote_service.dart';

class UpdateCSUFrameRepository {
  UpdateCSUFrameRepository(
    this._remoteService,
    this._storage,
    this._userModelWithPassword,
  );

  final CredentialsStorage _storage;
  final UpdateCSUFrameRemoteService _remoteService;
  final UserModelWithPassword _userModelWithPassword;

  Future<bool> hasOfflineData() => getStorageCondition()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, Unit>> updateCSUByQuery(
      {required List<CSUIDQuery> queryIds}) async {
    if (queryIds.isNotEmpty) {
      for (int i = 0; i < queryIds.length; i++) {
        final query = queryIds[i].query;
        final idUnit = queryIds[i].idUnit;

        try {
          await _remoteService.insertFrameCSUByQuery(query: query);

          await _removeQueryCSUFromSaved(idUnit: idUnit);
        } on RestApiException catch (e) {
          await _removeQueryCSUFromSaved(idUnit: idUnit);

          return left(RemoteFailure.server(e.errorCode, e.message));
        } on NoConnectionException {
          return left(RemoteFailure.noConnection());
        } on RangeError catch (e) {
          return left(RemoteFailure.parse(message: e.message));
        } on FormatException catch (e) {
          return left(RemoteFailure.parse(message: e.message));
        } on JsonUnsupportedObjectError {
          return left(
              RemoteFailure.parse(message: 'JsonUnsupportedObjectError'));
        } on PlatformException {
          return left(RemoteFailure.storage());
        }
      }
    } else {
      log('updateCSUByQuery : querId empty');
    }

    return right(unit);
  }

  Future<Either<LocalFailure, Unit>> saveCSUQuery(
      {required CSUIDQuery queryId, bool isNG = false}) async {
    try {
      final savedStrings = await _storage.read();
      final isQueryOK = queryId.query.isNotEmpty;
      final isStorageSaved = savedStrings != null;

      if (isQueryOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              final parsedResponse = jsonDecode(savedStrings!) as List<dynamic>;

              final List<CSUIDQuery> response =
                  CSUIDQuery.listCSUIDQueryFromJson(parsedResponse);

              final int index = response
                  .indexWhere((element) => element.idUnit == queryId.idUnit);

              final bool indexNotFound = index == -1;

              if (indexNotFound) {
                if (response.isNotEmpty) {
                  final List<CSUIDQuery> list =
                      [...response, queryId].toSet().toList();

                  final _list = CSUIDQuery.listCSUIDQueryToJsonSavable(list);
                  await _storage.save(_list);

                  // debugger(message: 'called');
                  log('saveCSUQuery : STORAGE UPDATE CSU QUERY: ${_list}');

                  return;
                } else {
                  final _list = [queryId];
                  final _finalized =
                      CSUIDQuery.listCSUIDQueryToJsonSavable(_list);

                  await _storage.save(_finalized);

                  log('STORAGE SAVE CSU QUERY: ${_finalized}');
                }
              } else {
                List<CSUIDQuery> _list = [...response];

                _list[index] = queryId;
                final _res = _list.toSet().toList();
                final _finalized = CSUIDQuery.listCSUIDQueryToJsonSavable(_res);
                await _storage.save(_finalized);
                log('STORAGE INSERT CSU QUERY: ${_finalized}');

                return;
              }
            }();
            break;
          case false:
            () async {
              final list = [queryId];
              await _storage.save(CSUIDQuery.listCSUIDQueryToJsonSavable(list));

              log('STORAGE SAVE CSU QUERY: ${CSUIDQuery.listCSUIDQueryToJsonSavable(list)}');
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
    required int noDefect,
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
  }) {
    // TEST
    String dbName = Constants.isTesting ? 'cs_trs_cs_test' : 'cs_trs_cs';

    // supir1, supir2,

    final String insert = 'INSERT INTO $dbName '
        '(id_cs, frame, inout, id_user, c_user, u_user,'
        'tgl, c_date, u_date, id_gate, posisi, no_defect, '
        'supir_sdr, tgl_kirim_unit, tgl_terima_unit, ket)';

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

    log('QUERY SAVE CSU OK : ${csuIdQuery.toJson()}');

    return csuIdQuery;
  }

  CSUIDQuery getNGSavableQuery({
    required int idUnit,
    required String frameName,
    required List<UpdateCSUNGState> ngStates,
    String idCS = 'ID_CS_NA',
  }) {
    // TEST
    String dbName =
        Constants.isTesting ? 'cs_trs_cs_dtl_test' : 'cs_trs_cs_dtl';
    String dbNameCS = Constants.isTesting ? 'cs_trs_cs_test' : 'cs_trs_cs';

    final String insert = ' INSERT INTO $dbName '
        '(id_cs, frame, c_date, u_date, c_user, '
        ' u_user, id_item, id_jns_defect, id_p_defect)';

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

    log('QUERY SAVE CS NG : ${csuIdQuery.toJson()}');

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
        final parsedResponse = jsonDecode(savedStrings) as List<dynamic>;

        final response = CSUIDQuery.listCSUIDQueryFromJson(parsedResponse);

        return right(response);
      } else {
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
