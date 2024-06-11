import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/spk/application/spk_id_query.dart';
import '../../application/user/user_model.dart';
import '../../constants/constants.dart';
import '../../domain/local_failure.dart';
import '../../domain/remote_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import 'update_spk_remote_service.dart';

class UpdateSPKRepository {
  UpdateSPKRepository(
    this._storage,
    this._remoteService,
    this._userModelWithPassword,
  );

  final CredentialsStorage _storage;
  final UpdateSPKRemoteService _remoteService;
  final UserModelWithPassword _userModelWithPassword;

  Future<bool> hasOfflineData() => getStorageCondition()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, Unit>> updateSPKByQuery(
      {required List<SPKIdQuery> queryIds}) async {
    final isQueryOK = queryIds.isNotEmpty;

    //

    if (isQueryOK) {
      for (int i = 0; i < queryIds.length; i++) {
        final query = queryIds[i].query;
        final idSPK = queryIds[i].idSPK;

        log('INDEX $i');

        // GET ID_CS
        //

        log('STORAGE UPDATE SPK QUERY: $query');

        try {
          await _remoteService.updateSPKByQuery(query: query);

          await _removeQuerySPKFromSaved(idSPK: idSPK);
        } on RestApiException catch (e) {
          //

          await _removeQuerySPKFromSaved(idSPK: idSPK);

          return left(RemoteFailure.server(e.errorCode, e.message));
        } on NoConnectionException {
          //

          // await _removeQuerySPKFromSaved(idSPK: idSPK);

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

        //

        // // DELETE SAVED QUERY
      }
    }

    //

    return right(unit);
  }

  Future<Either<LocalFailure, Unit>> saveSPKQuery(
      {required SPKIdQuery queryId}) async {
    try {
      final savedStrings = await _storage.read();
      final isQueryOK = queryId.query.isNotEmpty;
      final isStorageSaved = savedStrings != null;

      if (isQueryOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              final parsedResponse = jsonDecode(savedStrings!) as List<dynamic>;

              final response =
                  SPKIdQuery.listSPKIdQueryFromJson(parsedResponse);

              final index = response.indexWhere(
                (element) => element.idSPK == queryId.idSPK,
              );

              if (index == -1) {
                final list = [...response, queryId];

                await _storage
                    .save(SPKIdQuery.listSPKIdQueryToJsonSavable(list));

                log('STORAGE UPDATE SPK QUERY: ${SPKIdQuery.listSPKIdQueryToJsonSavable(list)}');
                return;
              } else {
                // if not NG, replace list
                final list = [...response];

                list[index] = queryId;

                await _storage
                    .save(SPKIdQuery.listSPKIdQueryToJsonSavable(list));

                log('STORAGE UPDATE SPK QUERY: ${SPKIdQuery.listSPKIdQueryToJsonSavable(list)}');
                return;
              }
            }();
            break;
          case false:
            () async {
              final list = [queryId];

              log('STORAGE SAVE SPK QUERY: ${SPKIdQuery.listSPKIdQueryToJsonSavable(list)}');

              await _storage.save(SPKIdQuery.listSPKIdQueryToJsonSavable(list));
              return;
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

  SPKIdQuery getSPKSavableQuery({required int idSPK, required String ket}) {
    // TEST

    String dbName = Constants.isTesting ? 'opr_trs_spk_test' : 'opr_trs_spk';

    final cAndUDate = DateTime.now()
        .toString()
        .substring(0, DateTime.now().toString().length - 3);

    final String insert = "UPDATE $dbName " +
        " SET is_edit = 1, u_user = '${_userModelWithPassword.nama}', u_date = '$cAndUDate', ket = '$ket' " +
        " WHERE id_spk = $idSPK AND u_date < '$cAndUDate' ";

    final SPKIdQuery spkIdQuery = SPKIdQuery(idSPK: idSPK, query: insert);

    log('QUERY SAVE SPK : ${spkIdQuery.toJson()}');

    return spkIdQuery;
  }

  // REMOVE SAVED CS QUERY
  Future<Unit> _removeQuerySPKFromSaved({required int? idSPK}) async {
    try {
      final savedStrings = await _storage.read();
      final isQueryOK = idSPK != null;
      final isStorageSaved = savedStrings != null;

      if (isQueryOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              //
              final parsedResponse = jsonDecode(savedStrings!) as List<dynamic>;

              final response =
                  SPKIdQuery.listSPKIdQueryFromJson(parsedResponse);

              final index =
                  response.indexWhere((element) => element.idSPK == idSPK);

              if (index == -1) {
                // throw RangeError('ITEM QUERY NOT FOUND');
                return unit;
              } else {
                final item = response[index];
                final list = [...response.where((element) => element != item)];

                await _storage.save(jsonEncode(list));

                //

                log('STORAGE UPDATE SPK FRAME DELETE: ${jsonEncode(list)}');

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

  /// DATA: LIST OF [SPKIdQuery]
  ///
  Future<Either<LocalFailure, List<SPKIdQuery>>>
      getUpdateSPKQueryListOFFLINE() async {
    try {
      final savedStrings = await _storage.read();
      final isStorageSaved = savedStrings != null;

      if (isStorageSaved) {
        final parsedResponse = jsonDecode(savedStrings) as List<dynamic>;

        final response = SPKIdQuery.listSPKIdQueryFromJson(parsedResponse);

        return right(response);
      } else {
        //
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
        //
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
