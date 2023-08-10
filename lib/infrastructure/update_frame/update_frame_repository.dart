import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../domain/local_failure.dart';
import '../../domain/value_objects_copy.dart';
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
      getUpdateQueryListSPKOFFLINE() async {
    try {
      final savedStrings = await _storage.read();
      final isStorageSaved = savedStrings != null;

      if (isStorageSaved) {
        final parsedResponse =
            jsonDecode(savedStrings!) as Map<String, dynamic>;

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

  /// FROM [getUpdateQueryListSPKOFFLINE] to [updateFrameByQuery]
  ///
  Future<Either<RemoteFailure, Unit>> updateFrameByQuery(
      {required Map<String, Map<String, String>> queryMap}) async {
    try {
      final isQueryOK = queryMap.values.isNotEmpty;

      if (isQueryOK) {
        queryMap.values.forEach((mapOfTIUnitQuery) {
          mapOfTIUnitQuery.values.forEach((query) async {
            // RUN QUERY
            log('QUERY: ${query.runtimeType}');

            await _remoteService.updateFrameByQuery(query: query);

            // DELETE SAVED QUERY
            await this._removeQueryFromMap(query: query);
          });
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

  Future<Unit> _removeQueryFromMap({required String query}) async {
    try {
      final savedStrings = await _storage.read();
      final isQueryOK = query.isNotEmpty;
      final isStorageSaved = savedStrings != null;

      if (isQueryOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              debugger(message: 'CALLED');
              final parsedResponse =
                  jsonDecode(savedStrings!) as Map<String, dynamic>;

              final parsedMap = convertToNestedMap(parsedResponse);

              parsedMap.values.forEach((mapTIUnitQuery) {
                mapTIUnitQuery.removeWhere((key, value) => value == query);
              });

              await _storage.save(jsonEncode(parsedMap));

              debugger(message: 'called');

              log('STORAGE UPDATE FRAME DELETE: ${jsonEncode(parsedMap)}');

              return unit;
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

  Future<Either<LocalFailure, Unit>> updateFrameSPK(
      {required String idSPK,
      required IDUnit idUnit,
      required FrameUnit frame,
      required EngineUnit engine,
      required WarnaUnit warna,
      required NoReffEXP noReff,
      required SPPDC sppdc,
      required IDKendType idKendType}) async {
    try {
      const String dbName = 'opr_trs_ti_unit_test';

      final idUnitStr = idUnit.getOrCrash();
      final idUnitInt = int.parse(idUnitStr);

      final idKendTypeStr = idKendType.getOrCrash();
      final idKendTypeInt = int.parse(idKendTypeStr);

      final frameStr = frame.getOrCrash();
      final engineStr = engine.getOrCrash();
      final warnaStr = warna.getOrCrash();
      final noReffStr = noReff.getOrCrash();
      // final sppdcStr = sppdc.getOrCrash();

      // final frameResponse = await _remoteService.updateFrame(
      //     idUnit: idUnitInt,
      //     idKendType: idKendTypeInt,
      //     engine: engineStr,
      //     frame: frameStr,
      //     warna: warnaStr,
      //     noReffExp: noReffStr);

      final command =
          "UPDATE $dbName SET frame = '$frameStr', engine = '$engineStr', warna = '$warnaStr', no_reff_expor = '$noReffStr', id_kend_type = '$idKendTypeInt' WHERE id_unit = $idUnitInt";

      final frameSaveMap = {
        idSPK: {idUnitStr: command}
      };

      await this._GETAndADDFrameSPKInMap(newFrameMap: frameSaveMap);

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
      final isStorageSaved = savedStrings != null;

      if (isNewFrameOK) {
        switch (isStorageSaved) {
          case true:
            () async {
              debugger(message: 'CALLED');
              final parsedResponse =
                  jsonDecode(savedStrings!) as Map<String, dynamic>;

              final parsedMap = convertToNestedMap(parsedResponse);

              // FIRST, CHECK IF EXISTING KEY [NO SPK] EXIST
              final keyNoSPK = newFrameMap.keys.first;
              // VALUES ARE [FRAME LIST]
              final valuesNoTIUnit = newFrameMap.values.first;

              // EXISTING SECOND KEY [NO TI UNIT]
              final keyIdUnit = newFrameMap.values.first.keys.first;
              final valueIdUnitQuery = newFrameMap.values.first.values.first;

              if (parsedMap.containsKey(keyNoSPK)) {
                if (valuesNoTIUnit.containsKey(keyIdUnit)) {
                  valuesNoTIUnit.update(keyIdUnit, (value) => valueIdUnitQuery);
                }

                // TI UNIT, QUERY VALUE
                parsedMap.update(
                    keyNoSPK, (value) => {keyIdUnit: valueIdUnitQuery});
              }
              // IF EXISTING KEY NULL
              else {
                parsedMap.addAll({
                  keyNoSPK: {keyIdUnit: valueIdUnitQuery}
                });
              }

              debugger(message: 'called');

              log('STORAGE UPDATE FRAME UPDATE: ${jsonEncode(parsedMap)}');

              await _storage.save(jsonEncode(parsedMap));

              return unit;
            }();
            break;
          case false:
            () async {
              debugger(message: 'called');

              log('STORAGE UPDATE FRAME SAVE: ${jsonEncode(newFrameMap)}');

              await _storage.save(jsonEncode(newFrameMap));

              return unit;
            }();
        }
      }

      return left(LocalFailure.empty());
    } on FormatException catch (e) {
      debugger(message: 'called');

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

      if (storedCredentials == null) {
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
    // 1. map IS
    // {159103: {715723: UPDATE opr_trs_ti_unit_test SET frame = 'MK2NCXPANPJ001185', engine = 'BANDA', warna = 'warna coklat', no_reff_expor = 'asdfasdf', id_kend_type = '591' WHERE id_unit = 715723}}

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
