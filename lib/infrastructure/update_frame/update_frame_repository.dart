import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/utils/string_utils.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../application/history/history.dart';
import '../../application/update_frame/update_frame_single_state.dart';
import '../../domain/local_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import '../history/history_repository.dart';
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
    this._historyRepository,
  );

  final HistoryRepository _historyRepository;
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
        for (int j = 0; j < queryMap.values.length; j++) {
          final mapOfTIUnitQuery = queryMap.values.elementAtOrNull(j);

          if (mapOfTIUnitQuery != null) {
            for (int i = 0; i < mapOfTIUnitQuery.values.length; i++) {
              final query = mapOfTIUnitQuery.values.elementAtOrNull(i);

              if (query != null) {
                // RUN QUERY
                log('QUERY: ${query}');

                try {
                  await _remoteService.updateFrameByQuery(query: query);

                  // DELETE SAVED QUERY
                  await _removeQueryFromMap(query: query);
                } on RestApiException catch (e) {
                  debugger(message: 'called');

                  await _removeQueryFromMap(query: query);

                  String idSPK = queryMap.keys.first;

                  await _historyRepository.clearHistoryFromStorageByIdSPK(
                      idSPK: idSPK);

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
              // debugger(message: 'CALLED');
              final parsedResponse =
                  jsonDecode(savedStrings!) as Map<String, dynamic>;

              final parsedMap = convertToNestedMap(parsedResponse);

              parsedMap.removeWhere((key, value) =>
                  value.values.firstWhere((element) => element == query) ==
                  query);

              log('parsedMap $parsedMap');

              // debugger(message: 'called');

              await _storage.save(jsonEncode(parsedMap));

              // debugger(message: 'called');

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

  Future<Unit> _saveHistory({
    required String idSPK,
    required String sppdc,
    required String userId,
    required String nama,
    required String query,
    required String gate,
    required List<UpdateFrameStateSingle> updateFrameList,
  }) async {
    final tgl = StringUtils.trimmedDate(DateTime.now());

    final List<String> frame =
        updateFrameList.map((e) => e.frame.getOrLeave('')).toList();

    String frameString =
        frame.fold('', (previousValue, element) => '$element, $previousValue');

    final history = History(
        idUser: int.parse(userId),
        query: query,
        content:
            'Update Frame di Gate $gate dengan No. SPPDC $sppdc dan Frame $frameString dan id SPK $idSPK',
        cUser: nama,
        cDate: tgl,
        sDate: tgl);

    // SAVE To History
    await _historyRepository.saveHistoryInStorage(history: history);

    return unit;
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
      final Map<String, String> mapOfCommands = {};

      updateFrameList.forEach((UpdateFrameStateSingle element) {
        // TEST
        const String dbName = 'opr_trs_ti_unit';

        final idKendTypeStr = element.idKendType.getOrLeave('');
        final idKendTypeInt =
            idKendTypeStr.isNotEmpty ? int.parse(idKendTypeStr) : 0;

        final engineStr = element.engine.getOrLeave('');
        final warnaStr = element.warna.getOrLeave('');
        // MANDATORY
        final frameStr = element.frame.getOrCrash();
        final sppdcStr = sppdc;

        final idUnitStr = element.idUnit.getOrCrash();
        final idUnitInt = int.parse(idUnitStr);

        final command =
            "UPDATE $dbName SET frame = '$frameStr', no_invoice = '$sppdcStr', engine = '$engineStr', warna = '$warnaStr', id_kend_type = '$idKendTypeInt', u_user = '$nama' WHERE id_unit = $idUnitInt";

        final Map<String, String> newMapOfCommands = {idUnitStr: command};

        mapOfCommands.addAll(newMapOfCommands);
      });

      // THEN ADD mapOfCommands TO newMap by idSPK

      final Map<String, Map<String, String>> newMap = {idSPK: mapOfCommands};

      // debugger(message: 'called');

      await this._GETAndADDFrameSPKInMap(newFrameMap: newMap);

      await this._saveHistory(
          idSPK: idSPK,
          sppdc: sppdc,
          userId: userId,
          nama: nama,
          gate: gate,
          query: mapOfCommands.toString(),
          updateFrameList: updateFrameList);

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
              debugger(message: 'CALLED');
              final Map<String, Map<String, dynamic>> parsedMap =
                  convertToNestedMap(
                      jsonDecode(savedStrings!) as Map<String, dynamic>);

              // FIRST, CHECK IF EXISTING KEY [NO SPK] EXIST
              final idSpk = newFrameMap.keys.first;

              // VALUES ARE [MAP OF ID UNIT AND QUERY]
              final IdUnitQueryToInsert = newFrameMap.values.first;

              debugger();

              // EXISTING SECOND KEY [NO TI UNIT]
              final keyIdUnitQueryToInsert =
                  newFrameMap.values.first.keys.first;

              final valueIdUnitQueryToInsert =
                  newFrameMap.values.first.values.first;

              // VALUES ARE Map<String, dynamic> , CHECK BY keyIdUnitQueryToInsert
              final valuesParsedMap = parsedMap.values as Map<String, dynamic>;
              final IdUnitQueryToInsertExist = valuesParsedMap.entries
                      .firstWhereOrNull(
                          (element) => element.key == keyIdUnitQueryToInsert) !=
                  null;

              if (parsedMap.containsKey(idSpk)) {
                debugger();
                if (IdUnitQueryToInsertExist) {
                  debugger();

                  IdUnitQueryToInsert.update(keyIdUnitQueryToInsert,
                      (value) => valueIdUnitQueryToInsert);
                }

                // THEN UPDATE parsedMap

                debugger();

                // TI UNIT, QUERY VALUE
                parsedMap.update(
                    idSpk,
                    (value) =>
                        {keyIdUnitQueryToInsert: valueIdUnitQueryToInsert});
              }
              // IF EXISTING KEY NULL
              else {
                debugger();

                parsedMap.addAll({
                  idSpk: {keyIdUnitQueryToInsert: valueIdUnitQueryToInsert}
                });
              }

              // debugger(message: 'called');

              log('STORAGE UPDATE FRAME UPDATE: ${jsonEncode(parsedMap)}');

              await _storage.save(jsonEncode(parsedMap));

              return unit;
            }();
            break;
          case false:
            () async {
              // debugger(message: 'called');

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
