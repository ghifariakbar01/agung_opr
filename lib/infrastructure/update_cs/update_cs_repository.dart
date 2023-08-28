import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../application/check_sheet/loading/state/update_cs_ng_state.dart';
import '../../application/check_sheet/shared/state/cs_id_query.dart';
import '../../application/user/user_model.dart';
import '../../domain/local_failure.dart';
import '../../domain/remote_failure.dart';
import '../../domain/value_objects_copy.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import 'update_cs_remote_service.dart';

class UpdateCSRepository {
  UpdateCSRepository(
    this._remoteService,
    this._userModelWithPassword,
    this._storage,
  );

  final UpdateCSRemoteService _remoteService;
  final UserModelWithPassword _userModelWithPassword;
  final CredentialsStorage _storage;

  Future<bool> hasOfflineData() => getStorageCondition()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  final tgl = DateFormat('yyyy-MM-dd')
      .parse(DateTime.now().toString())
      .toString()
      .substring(0, 10);

  final cAndUDate = DateTime.now()
      .toString()
      .substring(0, DateTime.now().toString().length - 3);

  Future<Either<RemoteFailure, Unit>> updateCSByQuery(
      {required List<CSIDQuery> queryIds}) async {
    final isQueryOK = queryIds.isNotEmpty;

    // debugger(message: 'called');

    if (isQueryOK) {
      for (int i = 0; i < queryIds.length; i++) {
        final query = queryIds[i].query;
        final idSPK = queryIds[i].idSPK;

        log('INDEX $i');

        // GET ID_CS
        // debugger(message: 'called');

        log('STORAGE UPDATE CSU QUERY: $query');

        try {
          await _remoteService.insertCSBYQuery(query: query);

          await _removeQueryCSUFromSaved(idSPK: idSPK);
        } on RestApiException catch (e) {
          debugger(message: 'called');

          _removeQueryCSUFromSaved(idSPK: idSPK);

          return left(RemoteFailure.server(e.errorCode, e.message));
        } on NoConnectionException {
          debugger(message: 'called');

          _removeQueryCSUFromSaved(idSPK: idSPK);

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

    // debugger(message: 'called');

    return right(unit);
  }

  Future<Either<LocalFailure, Unit>> saveCSUQueryNG(
      {required CSIDQuery queryId}) async {
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

              final response = CSIDQuery.listCSIDQueryFromJson(parsedResponse);

              final index = response
                  .indexWhere((element) => element.idSPK == queryId.idSPK);

              if (index == -1) {
                final list = [...response, queryId];

                await _storage.save(CSIDQuery.listCSIDQueryToJsonSavable(list));

                // debugger(message: 'called');

                log('STORAGE UPDATE CSU QUERY: ${CSIDQuery.listCSIDQueryToJsonSavable(list)}');
              } else {
                // if not NG, replace list
                final list = [...response];

                list[index] = queryId;

                await _storage.save(CSIDQuery.listCSIDQueryToJsonSavable(list));

                // debugger(message: 'called');

                log('STORAGE UPDATE CSU QUERY: ${CSIDQuery.listCSIDQueryToJsonSavable(list)}');
              }
            }();
            break;
          case false:
            () async {
              final list = [queryId];

              log('STORAGE SAVE CSU QUERY: ${CSIDQuery.listCSIDQueryToJsonSavable(list)}');

              await _storage.save(CSIDQuery.listCSIDQueryToJsonSavable(list));
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
      {required CSIDQuery queryId, bool isNG = false}) async {
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

              final response = CSIDQuery.listCSIDQueryFromJson(parsedResponse);

              final index = response
                  .indexWhere((element) => element.idSPK == queryId.idSPK);

              if (index == -1) {
                final list = [...response, queryId];

                await _storage.save(CSIDQuery.listCSIDQueryToJsonSavable(list));

                // debugger(message: 'called');

                log('STORAGE UPDATE CSU QUERY: ${CSIDQuery.listCSIDQueryToJsonSavable(list)}');
              } else {
                if (!isNG) {
                  // if not NG, replace list
                  final list = [...response];

                  list[index] = queryId;

                  await _storage
                      .save(CSIDQuery.listCSIDQueryToJsonSavable(list));

                  // debugger(message: 'called');

                  log('STORAGE UPDATE CSU QUERY: ${CSIDQuery.listCSIDQueryToJsonSavable(list)}');
                } else {
                  // if NG, coancenate
                  final list = [...response, queryId];

                  await _storage
                      .save(CSIDQuery.listCSIDQueryToJsonSavable(list));

                  // debugger(message: 'called');

                  log('STORAGE UPDATE CSU QUERY: ${CSIDQuery.listCSIDQueryToJsonSavable(list)}');
                }
              }
            }();
            break;
          case false:
            () async {
              final list = [queryId];

              log('STORAGE SAVE CSU QUERY: ${CSIDQuery.listCSIDQueryToJsonSavable(list)}');

              await _storage.save(CSIDQuery.listCSIDQueryToJsonSavable(list));
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

  CSIDQuery getOKSavableQuery({
    required int idSPK,
    required Nopol nopol,
    required Supir1 supir1,
    required SupirSDR supir2,
    required JamLoad jamLoad,
    required Gate gate,
    required Keterangan ket,
    required OKorNG status,
    required Tipe tipe,
  }) {
    const String dbName = 'pool_chk_kr';

    final nopolStr = nopol.getOrCrash();
    final supir1Str = supir1.getOrLeave('');
    final supir2Str = supir2.getOrLeave('');
    final gateStr = gate.getOrCrash();
    final jamLoadStr = jamLoad.getOrLeave('');
    final ketStr = ket.getOrLeave('');

    final String insert =
        "INSERT INTO $dbName SET id_kr_chk = '(SELECT ISNULL(max(id_khr_ck), 0) + 1 FROM $dbName)', " +
            "id_spk = $idSPK, " +
            "nopol = '$nopolStr', " +
            "driver1 = '$supir1Str', " +
            "driver2 = '$supir2Str', " +
            "tgl_berangkat = '$tgl', " +
            "jamload = '$jamLoadStr', " +
            "gate = '$gateStr', " +
            "status = '${status.name}', " +
            "tipe = '${tipe.name}', " +
            "ket = '$ketStr', " +
            "c_date = '$cAndUDate', " +
            "u_date = '$cAndUDate', " +
            "c_user = '${_userModelWithPassword.nama}', " +
            "u_user = '${_userModelWithPassword.nama}' ";

    final CSIDQuery csIdQuery = CSIDQuery(idSPK: idSPK, query: insert);

    log('QUERY SAVE CS : ${csIdQuery.toJson()}');

    debugger();

    return csIdQuery;
  }

  CSIDQuery getNGSavableQuery({
    required int idSPK,
    required String frameName,
    required List<UpdateCSNGState> ngStates,
    String idCS = 'ID_CS_NA',
  }) {
    const String dbName = 'pool_chk_kr_dtl';
    const String dbNamechk = 'pool_chk_kr';

    List<int> idListDetail = [];
    List<String> status = [];
    List<String> keterangan = [];

    if (ngStates.isNotEmpty) {
      for (final NG in ngStates) {
        idListDetail.add(NG.id);
        status.add(NG.status.name);
        keterangan.add(NG.keterangan.getOrLeave(''));
      }
    }

    // CONVERT TO MAP, TO ADD ALL STRING
    Map<int, String> queryMap = {};

    // 4. insert checksheet to pool_chk_kr_dtl

    // id_kr_chk_dtl (auto increment), id_kr_chk, id_list_dtl, status, ket, c_date, c_user, u_date, u_user

    for (int i = 0; i < idListDetail.length; i++) {
      final String insert =
          "INSERT INTO $dbName SET id_kr_chk_dtl = '(SELECT ISNULL(max(id_kr_chk_dtl), 0) + 1 FROM $dbName)', " +
              " id_kr_chk = '(SELECT ISNULL(max(id_khr_ck), 0) + 1 FROM $dbNamechk)', " +
              " c_date = '$cAndUDate', " +
              " u_date = '$cAndUDate', " +
              " c_user = '${_userModelWithPassword.nama}', " +
              " u_user = '${_userModelWithPassword.nama}', " +
              " id_list_dtl = '${idListDetail[i]}', " +
              " status = '${status[i]}', " +
              " ket = '${keterangan[i]}' ";

      queryMap.addAll({idListDetail[i]: insert});
    }

    // GET QUERY STRING
    final String queryString =
        queryMap.isNotEmpty ? queryMap.values.join(' ') : '';

    final CSIDQuery csIdQuery = CSIDQuery(idSPK: idSPK, query: queryString);

    log('QUERY SAVE CS NG: ${csIdQuery.toJson()}');

    debugger(message: 'called');

    return csIdQuery;
  }

  // REMOVE SAVED CSU QUERY
  Future<Unit> _removeQueryCSUFromSaved({required int? idSPK}) async {
    try {
      final savedStrings = await _storage.read();
      final isQueryOK = idSPK != null;
      final isStorageSaved = savedStrings != null;

      if (isQueryOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              // debugger(message: 'CALLED');
              final parsedResponse = jsonDecode(savedStrings!) as List<dynamic>;

              final response = CSIDQuery.listCSIDQueryFromJson(parsedResponse);

              final index =
                  response.indexWhere((element) => element.idSPK == idSPK);

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

  /// DATA: LIST OF [CSIDQuery]
  ///
  Future<Either<LocalFailure, List<CSIDQuery>>>
      getUpdateCSUQueryListOFFLINE() async {
    try {
      final savedStrings = await _storage.read();
      final isStorageSaved = savedStrings != null;

      if (isStorageSaved) {
        final parsedResponse = jsonDecode(savedStrings!) as List<dynamic>;

        final response = CSIDQuery.listCSIDQueryFromJson(parsedResponse);

        return right(response);
      } else {
        // debugger(message: 'CALLED');
        log('isStorageSaved CSU: NOT OK');

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
