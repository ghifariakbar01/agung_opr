import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/update_frame/update_frame_single_state.dart';
import '../../constants/constants.dart';
import '../../domain/local_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import 'update_frame_remote_service.dart';

/// [updateFrameSPK] PROCESS LIST OF [Frame]
/// AND SAVE TO STORAGE
/// QUERY, BY TI_UNIT, BY SPK
/// [FrameSPKStorage]
///

/// [SAVED] MODEL => [
/* 
    Map<String, Map<String, String>>  

    example:

   {
      "15098321" : {
      "711815": "UPDATE opr_trs_ti_unit SET frame = 'new_frame_value', engine = 'new_engine_value', warna = 'new_warna_value', id_kend_type = 'new_id_kend_type_value' WHERE id_unit = 711815",
      "711816":"UPDATE opr_trs_ti_unit SET frame = 'new_frame_value', engine = 'new_engine_value', warna = 'new_warna_value', id_kend_type = 'new_id_kend_type_value' WHERE id_unit = 711816",
      "711817":"UPDATE opr_trs_ti_unit SET frame = 'new_frame_value', engine = 'new_engine_value', warna = 'new_warna_value', id_kend_type = 'new_id_kend_type_value' WHERE id_unit = 711817",
      "711818":"UPDATE opr_trs_ti_unit SET frame = 'new_frame_value', engine = 'new_engine_value', warna = 'new_warna_value', id_kend_type = 'new_id_kend_type_value' WHERE id_unit = 711818"
      }
    }
*/

class UpdateFrameRepository {
  UpdateFrameRepository(
    this._remoteService,
    this._storage,
  );

  final UpdateFrameRemoteService _remoteService;
  final CredentialsStorage _storage;

  Future<bool> hasOfflineData() => getStorageCondition()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  /// DATA: MAP OF [idSPK] AS KEY, {idUnit : <QUERY>} AS VALUE
  ///
  Future<Either<LocalFailure, Map<String, Map<String, String>>>>
      getUpdateQueryListOFFLINE() async {
    try {
      final savedStrings = await _storage.read();
      final isStorageSaved = savedStrings != null;

      if (isStorageSaved) {
        final parsedResponse = jsonDecode(savedStrings) as Map<String, dynamic>;
        final responseDynamic = convertToNestedMap(parsedResponse);
        final responseString = convertDynamicToString(responseDynamic);

        return right(responseString);
      } else {
        // debugger(message: 'CALLED');
        log('isStorageSaved: NOT OK');

        return right({});
      }
    } on FormatException catch (e) {
      return left(LocalFailure.format(e.toString()));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  /// FROM [getUpdateQueryListOFFLINE] to [updateFrameByQuery]
  ///
  Future<Either<RemoteFailure, Unit>> updateFrameByQuery({
    required Map<String, Map<String, String>> queryMap,
  }) async {
    try {
      final isQueryOK = queryMap.values.isNotEmpty;

      if (isQueryOK) {
        for (int j = 0; j < queryMap.values.length; j++) {
          final mapOfTIUnitQuery = queryMap.values.elementAtOrNull(j);

          if (mapOfTIUnitQuery != null) {
            for (int i = 0; i < mapOfTIUnitQuery.values.length; i++) {
              final query = mapOfTIUnitQuery.values.elementAtOrNull(i);

              if (query != null) {
                log('QUERY $i: ${query}');

                try {
                  await _remoteService.updateFrameByQuery(query: query);
                  await _removeQueryFromMap(query: query);
                } on RestApiException catch (e) {
                  await _removeQueryFromMap(query: query);

                  return left(RemoteFailure.server(e.errorCode, e.message));
                } on NoConnectionException {
                  // debugger(message: 'called');

                  //  await  _removeQueryFromMap(query: query);

                  return left(RemoteFailure.noConnection());
                } on RangeError catch (e) {
                  debugger(message: 'called');
                  return left(RemoteFailure.parse(message: e.message));
                } on FormatException catch (e) {
                  return left(RemoteFailure.parse(message: e.message));
                } on JsonUnsupportedObjectError {
                  return left(RemoteFailure.parse(
                      message: 'JsonUnsupportedObjectError'));
                }
              }
            }
          }
        }
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

  Future<Unit> _removeQueryFromMap({required String query}) async {
    try {
      final savedStrings = await _storage.read();
      final isQueryOK = query.isNotEmpty;
      final isStorageSaved = savedStrings != null;

      if (isQueryOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              final parsedMap = convertToNestedMap(
                jsonDecode(savedStrings!) as Map<String, dynamic>,
              );

              parsedMap.removeWhere((_, value) {
                final _val = value.values;
                return _val.firstWhere((e) => e == query) == query;
              });

              await _storage.save(jsonEncode(parsedMap));

              return unit;
            }();
            break;
          case false:
            return unit;
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

  Future<Either<LocalFailure, Unit>> updateFrameSPK({
    required List<UpdateFrameStateSingle> updateFrameList,
    required String idSPK,
    required String sppdc,
    required String userId,
    required String nama,
    required String gate,
  }) async {
    try {
      Map<String, String> mapOfCommands = {};

      updateFrameList.forEach((frame) {
        // TEST
        String dbName =
            Constants.isTesting ? 'opr_trs_ti_unit_test' : 'opr_trs_ti_unit';

        final idKendTypeStr = frame.idKendType.getOrLeave('');
        final idKendTypeInt =
            idKendTypeStr.isNotEmpty ? int.parse(idKendTypeStr) : 0;

        final engineStr = frame.engine.getOrLeave('');
        final warnaStr = frame.warna.getOrLeave('');
        // MANDATORY
        final frameStr = frame.frame.getOrCrash();
        final sppdcStr = sppdc;

        final idUnitStr = frame.idUnit.getOrCrash();
        final idUnitInt = int.parse(idUnitStr);

        final cAndUDate = DateTime.now()
            .toString()
            .substring(0, DateTime.now().toString().length - 3);

        final command =
            " UPDATE $dbName SET frame = '$frameStr', no_invoice = '$sppdcStr', engine = '$engineStr', " +
                " warna = '$warnaStr', id_kend_type = '$idKendTypeInt', " +
                " u_user = '$nama', u_date = '$cAndUDate' WHERE id_unit = $idUnitInt";

        mapOfCommands.addAll({
          idUnitStr: command,
        });
      });

      // THEN ADD mapOfCommands TO newMap by idSPK

      final Map<String, Map<String, String>> newMap = {
        idSPK: mapOfCommands,
      };
      // debugger(message: 'called');
      await this._GETAndADDFrameSPKInMap(
        newFrameMap: newMap,
      );

      return right(unit);
    } on FormatException catch (e) {
      return left(LocalFailure.format(e.message));
    } on JsonUnsupportedObjectError {
      return left(LocalFailure.format('JsonUnsupportedObjectError'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  // IF FRAME UPDATE LIST HAS SAVED DATA IN _storage
  Future<Either<LocalFailure, Unit>> _GETAndADDFrameSPKInMap(
      {required Map<String, Map<String, String>> newFrameMap}) async {
    try {
      final savedStrings = await _storage.read();
      final isNewFrameOK = newFrameMap.isNotEmpty;
      final isStorageSaved = savedStrings != null && savedStrings != '{}';

      log('isStorageSaved $isStorageSaved $savedStrings');

      if (isNewFrameOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              final json = jsonDecode(savedStrings!) as Map<String, dynamic>;
              Map<String, Map<String, dynamic>> parsedMap =
                  convertToNestedMap(json);

              // FIRST, CHECK IF EXISTING KEY [NO SPK] EXIST
              final idSpk = newFrameMap.keys.first;

              // VALUES ARE [MAP OF ID UNIT AND QUERY]
              final IdUnit = newFrameMap.values.first;

              // EXISTING SECOND KEY [NO TI UNIT] TO INSERT
              final val = newFrameMap.values.first;
              final IdUnitToInsert = val.keys.first;
              final ValueToInsert = val.values.first;

              // VALUES ARE Map<String, dynamic> , CHECK BY IdUnitToInsert
              final savedParsedMap = parsedMap.values as Map<String, dynamic>;
              final IdUnitQueryToInsertExist = savedParsedMap.entries
                      .firstWhereOrNull(
                          (element) => element.key == IdUnitToInsert) !=
                  null;

              if (parsedMap.containsKey(idSpk)) {
                if (IdUnitQueryToInsertExist) {
                  IdUnit.update(
                    IdUnitToInsert,
                    (_) => ValueToInsert,
                  );
                }

                // THEN UPDATE parsedMap TI UNIT, QUERY VALUE
                parsedMap.update(
                  idSpk,
                  (_) => {IdUnitToInsert: ValueToInsert},
                );
              }
              // IF EXISTING KEY NULL
              else {
                parsedMap.addAll({
                  idSpk: {IdUnitToInsert: ValueToInsert}
                });
              }

              // debugger(message: 'called');
              final _save = jsonEncode(parsedMap);
              log('STORAGE UPDATE FRAME UPDATE: ${_save}');

              try {
                await _storage.save(_save);

                return unit;
              } catch (err) {
                return left(LocalFailure.storage());
              }
            }();
            break;
          case false:
            () async {
              // debugger(message: 'called');
              final _save = jsonEncode(newFrameMap);
              log('STORAGE UPDATE FRAME SAVE: ${_save}');

              try {
                await _storage.save(_save);

                return unit;
              } catch (err) {
                return left(LocalFailure.storage());
              }
            }();
        }
      }

      return left(LocalFailure.empty());
    } on FormatException catch (e) {
      log('ERROR UPDATE FRAME $e');

      return left(LocalFailure.format(e.message));
    } on JsonUnsupportedObjectError {
      return left(LocalFailure.format('JsonUnsupportedObjectError'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  Future<Either<LocalFailure, String?>> getStorageCondition() async {
    try {
      final storedCredentials = await _storage.read();

      if (storedCredentials == null ||
          storedCredentials == '{}' ||
          storedCredentials == '[]') {
        return left(LocalFailure.empty());
      }

      return right(storedCredentials);
    } on FormatException {
      return left(LocalFailure.format('Error while parsing'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  Map<String, Map<String, String>> convertToNestedMap(
      Map<String, dynamic> map) {
    Map<String, Map<String, String>> nestedMap = {};

    map.entries.forEach((element) {
      final response = element.value as Map<String, dynamic>;

      final frameList = response.entries;

      final Map<String, String> frameMap = {};

      frameList.forEach((element) {
        frameMap.addAll({element.key: element.value});
      });

      nestedMap.addAll({element.key: frameMap});
    });

    return nestedMap;
  }

  Map<String, Map<String, String>> convertDynamicToString(
      Map<String, Map<String, dynamic>> map) {
    Map<String, Map<String, String>> newMap = {};

    map.forEach((outerKey, innerMap) {
      Map<String, String> newInnerMap = {};
      innerMap.forEach((innerKey, value) {
        if (value is String) {
          newInnerMap[innerKey] = value;
        } else {
          newInnerMap[innerKey] = value.toString();
        }
      });
      newMap[outerKey] = newInnerMap;
    });

    return newMap;
  }
}
