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
    this._storage,
    this._remoteService,
    this._userModelWithPassword,
  );

  final CredentialsStorage _storage;
  final UpdateCSRemoteService _remoteService;
  final UserModelWithPassword _userModelWithPassword;

  Future<bool> hasOfflineData() => getStorageCondition()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, Unit>> updateCSByQuery(
      {required List<CSIDQuery> queryIds}) async {
    final isQueryOK = queryIds.isNotEmpty;

    // debugger(message: 'called');
    final List<CSIDQuery> processedList = queryIds.toSet().toList();

    if (isQueryOK) {
      for (int i = 0; i < processedList.length; i++) {
        final String query = processedList[i].query;
        final int idSPK = processedList[i].idSPK;

        log('INDEX $i');

        // GET ID_CS
        // debugger(message: 'called');

        log('STORAGE UPDATE CS QUERY: $query');

        try {
          await _remoteService.insertCSBYQuery(query: query);
          await _removeQueryCSFromSaved(idSPK: idSPK);
        } on RestApiException catch (e) {
          // debugger(message: 'called');

          await _removeQueryCSFromSaved(idSPK: idSPK);

          return left(RemoteFailure.server(e.errorCode, e.message));
        } on NoConnectionException {
          // debugger(message: 'called');

          // await _removeQueryCSFromSaved(idSPK: idSPK);

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

      // debugger(message: 'called');

      return right(unit);
    } else {
      //
      return right(unit);
    }
  }

  Future<Either<LocalFailure, Unit>> saveCSQuery({
    required String idUser,
    required String nama,
    required String gate,
    required CSIDQuery queryId,
  }) async {
    try {
      // Trigger for older devices
      await _storage.read();
      await _storage.read();
      await _storage.read();
      //

      final savedStrings = await _storage.read();
      final isQueryOK = queryId.query.isNotEmpty;
      final isStorageSaved = savedStrings != null;

      if (isQueryOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              final raw = jsonDecode(savedStrings!) as List<dynamic>;

              final List<CSIDQuery> response =
                  CSIDQuery.listCSIDQueryFromJson(raw);

              final int index = response
                  .indexWhere((element) => element.idSPK == queryId.idSPK);

              final bool indexNotFound = index == -1;

              if (indexNotFound) {
                if (response.isNotEmpty) {
                  final List<CSIDQuery> list =
                      [...response, queryId].toSet().toList();
                  await _storage
                      .save(CSIDQuery.listCSIDQueryToJsonSavable(list));

                  // debugger(message: 'called');
                  log('STORAGE UPDATE CS QUERY: ${CSIDQuery.listCSIDQueryToJsonSavable(list)}');

                  return;
                } else {
                  final _list = [queryId];
                  await _storage
                      .save(CSIDQuery.listCSIDQueryToJsonSavable(_list));

                  log('STORAGE SAVE CS QUERY: ${CSIDQuery.listCSIDQueryToJsonSavable(_list)}');
                  return;
                }
              } else {
                List<CSIDQuery> _list = [...response];

                _list[index] = queryId;
                await _storage.save(CSIDQuery.listCSIDQueryToJsonSavable(
                    _list.toSet().toList()));
                log('STORAGE INSERT CS QUERY: ${CSIDQuery.listCSIDQueryToJsonSavable(_list)}');

                return;
              }
            }();
            break;
          case false:
            () async {
              final _list = [queryId];
              await _storage.save(CSIDQuery.listCSIDQueryToJsonSavable(_list));

              log('STORAGE SAVE CS QUERY: ${CSIDQuery.listCSIDQueryToJsonSavable(_list)}');
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
    required Tipe tipe,
    required int idSPK,
    required Gate gate,
    required Nopol nopol,
    required OKorNG status,
    required Keterangan ket,
    required Supir1 supir1,
    required SupirSDR supir2,
    required JamLoad jamLoad,
  }) {
    // TEST
    const String dbName = 'pool_chk_kr';

    final nopolStr = nopol.getOrCrash();
    final gateStr = gate.getOrCrash();

    final ketStr = ket.getOrLeave('');
    final supir1Str = supir1.getOrLeave('');
    final supir2Str = supir2.getOrLeave('');
    final jamLoadStr = jamLoad.getOrLeave('');

    final tgl = DateFormat('yyyy-MM-dd')
        .parse(DateTime.now().toString())
        .toString()
        .substring(0, 10);

    final cAndUDate = DateTime.now()
        .toString()
        .substring(0, DateTime.now().toString().length - 3);

    final String insert = " INSERT INTO $dbName " +
        " (id_kr_chk, id_spk, nopol, driver1, driver2, tgl_berangkat, "
            " jamload, gate, status, tipe, ket, "
            " c_date, u_date, c_user, u_user) " +
        " VALUES " +
        " ( " +
        " (SELECT ISNULL(max(id_kr_chk), 0) + 1 FROM $dbName)," +
        "$idSPK, " +
        "'$nopolStr', " +
        "'$supir1Str', " +
        "'$supir2Str', " +
        "'$tgl', " +
        "'$jamLoadStr', " +
        "'$gateStr', " +
        "'${status.name}', " +
        "'${tipe.name}', " +
        "'$ketStr', " +
        "'$cAndUDate', " +
        "'$cAndUDate', " +
        "'${_userModelWithPassword.nama}', " +
        "'${_userModelWithPassword.nama}' " +
        " ) ";

    final CSIDQuery csIdQuery = CSIDQuery(idSPK: idSPK, query: insert);

    log('QUERY SAVE CS : ${csIdQuery.toJson()}');

    return csIdQuery;
  }

  CSIDQuery getNGSavableQuery({
    required int idSPK,
    required String frameName,
    required List<UpdateCSNGState> ngStates,
  }) {
    // TEST
    const String dbName = 'pool_chk_kr_dtl';
    const String dbNamechk = 'pool_chk_kr';

    final cAndUDate = DateTime.now()
        .toString()
        .substring(0, DateTime.now().toString().length - 3);

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
      final String insert = " INSERT INTO $dbName " +
          " (id_kr_chk_dtl, id_kr_chk, c_date, u_date, c_user, u_user, id_list_dtl, status, ket) " +
          " VALUES " +
          " ( " +
          " (SELECT ISNULL(MAX(id_kr_chk_dtl), 0) + 1 FROM $dbName), " +
          " (SELECT MAX(id_kr_chk) FROM $dbNamechk), " +
          " '$cAndUDate', " +
          " '$cAndUDate', " +
          " '${_userModelWithPassword.nama}', " +
          " '${_userModelWithPassword.nama}', " +
          "  ${idListDetail[i]}, " +
          " '${status[i]}', " +
          " '${keterangan[i]}' " +
          " ) ";

      queryMap.addAll({idListDetail[i]: insert});
    }

    // GET QUERY STRING
    String queryString = queryMap.isNotEmpty ? queryMap.values.join(' ') : '';
    CSIDQuery csIdQuery = CSIDQuery(idSPK: idSPK, query: queryString);

    log('QUERY SAVE CS NG: ${csIdQuery.toJson()}');

    return csIdQuery;
  }

  // REMOVE SAVED CS QUERY
  Future<Unit> _removeQueryCSFromSaved({required int? idSPK}) async {
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

                log('STORAGE UPDATE CS FRAME DELETE: ${jsonEncode(list)}');

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
      getUpdateCSQueryListOFFLINE() async {
    try {
      final savedStrings = await _storage.read();
      final isStorageSaved = savedStrings != null;

      if (isStorageSaved) {
        final parsedResponse = jsonDecode(savedStrings) as List<dynamic>;

        final response = CSIDQuery.listCSIDQueryFromJson(parsedResponse);

        return right(response);
      } else {
        // debugger(message: 'CALLED');
        log('isStorageSaved CS: NOT OK');

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
