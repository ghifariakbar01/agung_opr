import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/check_sheet/unit/state/csu_ng/csu_ng_result.dart';
import '../../application/check_sheet/unit/state/csu_ng/csu_ng_result_by_id.dart';
import '../../application/check_sheet/unit/state/csu_result.dart';

import '../../application/check_sheet/unit/state/csu_trips/csu_trips.dart';
import '../../application/check_sheet/unit/state/spk_csu_result.dart';
import '../../application/check_sheet/unit/state/unit_csu_trips.dart';
import '../../domain/local_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import 'csu_remote_service.dart';

/// LIST OF [FrameNameCSUResult]
/// [SAVED] MODEL => [
/* 
    List<FrameNameCSUResult> 

   [
    {
      "frameName": "DUMMY 324",
          "csuResult":  [
              {"frame": "DUMMY 324","gate": "TAM CCY CIBITUNG","inOut": false,"isDefect": 0,"updatedAt": "2019-10-09 09:39:34"},
              {"frame": "DUMMY 324","gate": "TAM CCY CIBITUNG","inOut": false,"isDefect": 0,"updatedAt": "2019-10-09 09:39:34"},
              {"frame": "DUMMY 324","gate": "TAM CCY CIBITUNG","inOut": false,"isDefect": 0,"updatedAt": "2019-10-09 09:39:34"}
            ],
    }, 
    {
      "frameName": "DUMMY 325",
          "csuResult":  [
              {"frame": "DUMMY 325","gate": "TAM CCY CIBITUNG","inOut": false,"isDefect": 0,"updatedAt": "2019-10-09 09:39:34"},
              {"frame": "DUMMY 325","gate": "TAM CCY CIBITUNG","inOut": false,"isDefect": 0,"updatedAt": "2019-10-09 09:39:34"},
              {"frame": "DUMMY 325","gate": "TAM CCY CIBITUNG","inOut": false,"isDefect": 0,"updatedAt": "2019-10-09 09:39:34"}
            ],
    }, 
    {
      "frameName": "DUMMY 326",
          "csuResult":  [
              {"frame": "DUMMY 326","gate": "TAM CCY CIBITUNG","inOut": false,"isDefect": 0,"updatedAt": "2019-10-09 09:39:34"},
              {"frame": "DUMMY 326","gate": "TAM CCY CIBITUNG","inOut": false,"isDefect": 0,"updatedAt": "2019-10-09 09:39:34"},
              {"frame": "DUMMY 326","gate": "TAM CCY CIBITUNG","inOut": false,"isDefect": 0,"updatedAt": "2019-10-09 09:39:34"}
            ],
    }, 
   ]


*/

/// LIST OF [UnitCSUTrips]
/// [SAVED] MODEL => [
/* 
    List<UnitCSUTrips> 

   [
    {
      "idUnit": 1238912,
          "csuResult":  [
                      {
                          "costanalis": "AGUNG RAYA CCR KARAWANG - PATIMBAN ",
                          "custnm": "AGUNG RAYA"
                      },
                      {
                          "costanalis": "AGUNG RAYA CCR KARAWANG - PATIMBAN ",
                          "custnm": "AGUNG RAYA"
                      },
                      {
                          "costanalis": "AGUNG RAYA CCR KARAWANG - PATIMBAN ",
                          "custnm": "AGUNG RAYA"
                      },
            ],
    }, 
    {
       "idUnit": 1238912,
          "csuResult":  [
                      {
                          "costanalis": "AGUNG RAYA CCR KARAWANG - PATIMBAN ",
                          "custnm": "AGUNG RAYA"
                      },
                      {
                          "costanalis": "AGUNG RAYA CCR KARAWANG - PATIMBAN ",
                          "custnm": "AGUNG RAYA"
                      },
                      {
                          "costanalis": "AGUNG RAYA CCR KARAWANG - PATIMBAN ",
                          "custnm": "AGUNG RAYA"
                      },
            ],
    }, 
    {
      "idUnit": 1238912,
          "csuResult":  [
                      {
                          "costanalis": "AGUNG RAYA CCR KARAWANG - PATIMBAN ",
                          "custnm": "AGUNG RAYA"
                      },
                      {
                          "costanalis": "AGUNG RAYA CCR KARAWANG - PATIMBAN ",
                          "custnm": "AGUNG RAYA"
                      },
                      {
                          "costanalis": "AGUNG RAYA CCR KARAWANG - PATIMBAN ",
                          "custnm": "AGUNG RAYA"
                      },
            ],
    }, 
   ]


*/

class CSUFrameRepository {
  CSUFrameRepository(
    this._storage,
    this._storageTrips,
    this._storageNG,
    this._remoteService,
  );

  final CredentialsStorage _storage;
  final CredentialsStorage _storageNG;
  final CredentialsStorage _storageTrips;
  final CSUFrameRemoteService _remoteService;

  Future<bool> hasOfflineCSUNGResultIndex(int idCS) =>
      getCSUNGResultByIDOFFLINE(idCS: idCS)
          .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<bool> hasOfflineCSUResultIndex(String frameName) =>
      getSPKCSUOFFLINE(frameName: frameName)
          .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<bool> hasOfflineTripsDataIndex(int idUnit) =>
      getCSUFrameTripsOFFLINE(idUnit: idUnit)
          .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<CSUResult>>> getCSUByFrameName(
      {required String frameName}) async {
    try {
      final listFrameNameCSUResult =
          await _remoteService.getCSUByFrameName(frameName: frameName);

      await this._GETAndREPLACECsuInList(
          frameName: frameName, newCSU: listFrameNameCSUResult);

      return right(listFrameNameCSUResult);
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

  Future<Either<RemoteFailure, List<CSUNGResult>>> getCSUNGByIdCS(
      {required int idCS}) async {
    try {
      final listFrameNameCSUNGResult =
          await _remoteService.getCSUNGByIdCS(idCS: idCS);

      await this._GETAndREPLACECsuNGSInList(
        idCS: idCS,
        newCSUNGList: listFrameNameCSUNGResult,
      );

      return right(listFrameNameCSUNGResult);
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

  Future<Either<RemoteFailure, List<CSUTrips>>> getCSUFrameTripsByName({
    required int idUnit,
    required String frameName,
  }) async {
    try {
      final listFrameNameCSUResult =
          await _remoteService.getCSUFrameTripsByName(
        frameName: frameName,
      );

      await this._GETAndREPLACECsuTRIPSInList(
          newCSUTrips: UnitCSUTrips(
        idUnit: idUnit,
        csuResult: listFrameNameCSUResult,
      ));

      return right(listFrameNameCSUResult);
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

  List<CSUNGResultByID> csuNgResultListFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((e) => CSUNGResultByID.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  String csuNgResultListToJson(List<CSUNGResultByID> resultList) {
    List<Map<String, dynamic>> jsonList =
        resultList.map((e) => e.toJson()).toList();

    return jsonEncode(jsonList);
  }

  // _GETAndREPLACECsuNGInList
  Future<Unit> _GETAndREPLACECsuNGSInList(
      {required int idCS, required List<CSUNGResult> newCSUNGList}) async {
    final savedStrings = await _storageNG.read();
    final isNewFrameOK = newCSUNGList.isNotEmpty;
    final isStorageSaved = savedStrings != null;

    if (isNewFrameOK) {
      switch (isStorageSaved) {
        case true:
          () async {
            final parsed = jsonDecode(savedStrings!) as List<dynamic>;

            final List<CSUNGResultByID> parsedListCSUSNG =
                CSUNGResultByID.CSUNGResultListFromJson(parsed);

            // FIRST, CHECK IF EXISTING KEY [ID-CS] EXIST
            final key = parsedListCSUSNG.firstWhereOrNull(
              (element) => element.idCS == idCS,
            );

            if (key != null) {
              final indexIdCS = parsedListCSUSNG.indexWhere(
                (element) => element.idCS == idCS,
              );

              final isIndexFound = indexIdCS != -1;

              // [FRAME-NAME]
              if (isIndexFound) {
                // LIST OF PARSED LIST CSU
                final list = [...parsedListCSUSNG];

                list[indexIdCS] =
                    CSUNGResultByID(idCS: idCS, csuNGResult: newCSUNGList);

                final _json = CSUNGResultByID.CSUNGResultListToJson(list);

                log('_json $_json');

                // SAVE LIST
                await _storageNG.save(_json);
              }

              // [FRAME-NAME] NEW
              else {
                final CSUNGResultByID newElement =
                    CSUNGResultByID(idCS: idCS, csuNGResult: newCSUNGList);

                final list = [...parsedListCSUSNG, newElement];

                final _json = CSUNGResultByID.CSUNGResultListToJson(list);

                await _storageNG.save(_json);
              }
            }
            // THEN, HANDLE WHERE [ID-CS] NOT EXIST,
            // PARAM IS LIST OF CSU NG AND INDEX [ID-CS]
            else {
              final CSUNGResultByID newElement = CSUNGResultByID(
                idCS: idCS,
                csuNGResult: newCSUNGList,
              );

              final list = [...parsedListCSUSNG, newElement];
              final _json = CSUNGResultByID.CSUNGResultListToJson(list);

              await _storageNG.save(_json);
            }

            return unit;
          }();
          break;
        case false:
          () async {
            final CSUNGResultByID newElement = CSUNGResultByID(
              idCS: idCS,
              csuNGResult: newCSUNGList,
            );

            final _json = CSUNGResultByID.CSUNGResultListToJson([newElement]);

            // SAVE LIST
            await _storageNG.save(_json);

            log('STORAGE CSU NG RESULT BY ID CS UPDATE NEW: ${_json}');

            return unit;
          }();
      }
    }

    return unit;
  }

  // SAVE CSU FRAME TRIPS IN STORAGE
  Future<Unit> _GETAndREPLACECsuTRIPSInList({
    required UnitCSUTrips newCSUTrips,
  }) async {
    final savedStrings = await _storageTrips.read();
    final isNewFrameOK = newCSUTrips.csuResult.isNotEmpty;
    final isStorageSaved = savedStrings != null;

    if (isNewFrameOK) {
      switch (isStorageSaved) {
        case true:
          () async {
            final parsed = jsonDecode(savedStrings!) as List<dynamic>;

            final List<UnitCSUTrips> parsedListCSUSPK =
                UnitCSUTrips.listCSUResultTripsFromJson(parsed);

            final idUnit = newCSUTrips.idUnit;

            // FIRST, CHECK IF EXISTING KEY [ID-UNIT] EXIST
            final key = parsedListCSUSPK.firstWhereOrNull(
              (element) => element.idUnit == idUnit,
            );

            if (key != null) {
              final indexIdUnit = parsedListCSUSPK.indexWhere(
                (element) => element.idUnit == idUnit,
              );

              final isIndexFound = indexIdUnit != -1;

              // [FRAME-NAME]
              if (isIndexFound) {
                final element = newCSUTrips;

                // LIST OF PARSED LIST CSU
                final list = [...parsedListCSUSPK];

                list[indexIdUnit] = element;

                // SAVE LIST
                await _storageTrips
                    .save(UnitCSUTrips.listCSUResultTripsToJson(list));
              }

              // [FRAME-NAME] NEW
              else {
                final element = newCSUTrips;

                final list = [
                  ...parsedListCSUSPK,
                  element,
                ];

                await _storageTrips
                    .save(UnitCSUTrips.listCSUResultTripsToJson(list));
              }
            }
            // THEN, HANDLE WHERE [ID-UNIT] NOT EXIST,
            // PARAM IS LIST OF CSU AND INDEX [ID-SPK]
            else {
              final element = newCSUTrips;

              final list = [
                ...parsedListCSUSPK,
                element,
              ];

              // SAVE LIST
              await _storageTrips
                  .save(UnitCSUTrips.listCSUResultTripsToJson(list));
            }

            return unit;
          }();
          break;
        case false:
          () async {
            // SAVE LIST
            await _storageTrips
                .save(UnitCSUTrips.listCSUResultTripsToJson([newCSUTrips]));

            return unit;
          }();
      }
    }

    return unit;
  }

  // SAVE CSU FRAME IN STORAGE
  Future<Unit> _GETAndREPLACECsuInList({
    required String frameName,
    required List<CSUResult> newCSU,
  }) async {
    final savedStrings = await _storage.read();
    final isNewFrameOK = newCSU.isNotEmpty;
    final isStorageSaved = savedStrings != null;

    if (isNewFrameOK) {
      switch (isStorageSaved) {
        case true:
          () async {
            final parsed = jsonDecode(savedStrings!) as List<dynamic>;

            final List<FrameNameCSUResult> parsedListCSUSPK =
                listFrameNameCSUResultFromJson(parsed);

            // FIRST, CHECK IF EXISTING KEY [ID-SPK] EXIST
            final key = parsedListCSUSPK.firstWhereOrNull(
              (element) => element.frameName == frameName,
            );

            if (key != null) {
              final indexIdUnit = parsedListCSUSPK.indexWhere(
                (element) => element.frameName == frameName,
              );

              final isIndexFound = indexIdUnit != -1;

              // [FRAME-NAME]
              if (isIndexFound) {
                final element = FrameNameCSUResult(
                  frameName: frameName,
                  csuResult: [...newCSU],
                );

                // LIST OF PARSED LIST CSU
                final list = [...parsedListCSUSPK];
                list[indexIdUnit] = element;
                final _list = listFrameNameCSUResultToJson(list);

                // SAVE LIST
                await _storage.save(_list);
              }

              // [FRAME-NAME] NEW
              else {
                final element = FrameNameCSUResult(
                  frameName: frameName,
                  csuResult: [...newCSU],
                );

                final list = [
                  ...parsedListCSUSPK,
                  element,
                ];

                await _storage.save(listFrameNameCSUResultToJson(list));
              }
            }
            // THEN, HANDLE WHERE [ID-SPK] NOT EXIST,
            // PARAM IS LIST OF CSU AND INDEX [ID-SPK]
            else {
              final element = FrameNameCSUResult(
                frameName: frameName,
                csuResult: newCSU,
              );

              final list = [
                ...parsedListCSUSPK,
                element,
              ];

              await _storage.save(listFrameNameCSUResultToJson(list));
            }

            return unit;
          }();
          break;
        case false:
          () async {
            final element = FrameNameCSUResult(
              frameName: frameName,
              csuResult: newCSU,
            );

            await _storage.save(listFrameNameCSUResultToJson([element]));
            return unit;
          }();
      }
    }

    return unit;
  }

  /// DATA: [CSUNGResultByID] FROM STORAGE
  ///
  /// process [idCS] and get [CSUNGResultByID]
  Future<Either<RemoteFailure, List<CSUNGResult>>> getCSUNGResultByIDOFFLINE(
      {required int idCS}) async {
    try {
      final frameStorage = await _storageNG.read();

      // HAS MAP
      if (frameStorage != null) {
        final responsMap = jsonDecode(frameStorage) as List<dynamic>;
        final response = CSUNGResultByID.CSUNGResultListFromJson(responsMap);

        // FIRST, CHECK IF EXISTING KEY [ID-SPK] EXIST
        final key = response.firstWhereOrNull(
          (element) => element.idCS == idCS,
        );

        if (key != null) {
          return right(key.csuNGResult);
        } else {
          return right([]);
        }
      } else {
        debugger(message: 'called');

        return left(RemoteFailure.parse(message: 'LIST EMPTY'));
      }
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException catch (error) {
      return left(RemoteFailure.parse(message: error.message));
    }
  }

  /// DATA: [FrameNameCSUResult] FROM STORAGE
  ///
  /// process [frameName] and get [FrameNameCSUResult]
  Future<Either<RemoteFailure, List<CSUResult>>> getSPKCSUOFFLINE(
      {required String frameName}) async {
    try {
      final frameStorage = await _storage.read();

      // HAS MAP
      if (frameStorage != null) {
        final responsMap = jsonDecode(frameStorage) as List<dynamic>;

        final List<FrameNameCSUResult> response =
            listFrameNameCSUResultFromJson(responsMap);

        // FIRST, CHECK IF EXISTING KEY [ID-SPK] EXIST
        final key = response
            .firstWhereOrNull((element) => element.frameName == frameName);

        if (key != null) {
          return right(key.csuResult);
        } else {
          return left(RemoteFailure.parse(message: 'LIST EMPTY'));
        }
      } else {
        return left(RemoteFailure.parse(message: 'LIST EMPTY'));
      }
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException catch (error) {
      return left(RemoteFailure.parse(message: error.message));
    }
  }

  /// DATA: [UnitCSUTrips] FROM STORAGE
  ///
  /// process [idUnit] and get LIST OF [CSUTrips] FROM [UnitCSUTrips]
  Future<Either<RemoteFailure, List<CSUTrips>>> getCSUFrameTripsOFFLINE(
      {required int idUnit}) async {
    try {
      final frameStorage = await _storageTrips.read();

      log('FRAME TRIPS STORAGE: $frameStorage');

      // HAS MAP
      if (frameStorage != null) {
        final responsMap = jsonDecode(frameStorage) as List<dynamic>;

        final List<UnitCSUTrips> response =
            UnitCSUTrips.listCSUResultTripsFromJson(responsMap);

        log('FRAME TRIPS STORAGE RESPONSE: $response');

        // FIRST, CHECK IF EXISTING KEY [ID-SPK] EXIST
        final key =
            response.firstWhereOrNull((element) => element.idUnit == idUnit);

        if (key != null) {
          final csuResults = key.csuResult;

          if (csuResults.isNotEmpty) {
            return right(csuResults);
          } else {
            return right([]);
          }
        } else {
          return left(RemoteFailure.parse(message: 'LIST EMPTY'));
        }
      } else {
        return left(RemoteFailure.parse(message: 'LIST EMPTY'));
      }
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException catch (error) {
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

  Future<Either<LocalFailure, String?>> getStorageConditionTrips() async {
    try {
      final storedCredentials = await _storageTrips.read();

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

  Future<Unit> clearNGStorage() async {
    final storedCredentials = await _storageNG.read();

    if (storedCredentials == null) {
      return unit;
    }

    debugger(message: 'called');

    await _storageNG.clear();

    return unit;
  }

  Future<Unit> clearTripsStorage() async {
    final storedCredentials = await _storageTrips.read();

    if (storedCredentials == null) {
      return unit;
    }

    debugger(message: 'called');

    await _storageTrips.clear();

    return unit;
  }

  Future<Unit> clearCSUResultStorage() async {
    final storedCredentials = await _storageTrips.read();

    if (storedCredentials == null) {
      return unit;
    }

    await _storageTrips.clear();

    return unit;
  }
}
