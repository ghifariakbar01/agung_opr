import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/check_sheet/unit/state/csu_result.dart';
import '../../application/check_sheet/unit/state/csu_trips.dart';
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
  CSUFrameRepository(this._remoteService, this._storage, this._storageTrips);

  final CSUFrameRemoteService _remoteService;
  final CredentialsStorage _storage;
  final CredentialsStorage _storageTrips;

  Future<bool> hasOfflineDataIndex(String frameName) =>
      getSPKCSUOFFLINE(frameName: frameName)
          .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<bool> hasOfflineTripsDataIndex(int idUnit) =>
      getSPKCSUFrameTripsOFFLINE(idUnit: idUnit)
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

  Future<Either<RemoteFailure, List<CSUTrips>>> getCSUFrameTripsByName(
      {required int idUnit, required String frameName}) async {
    try {
      final listFrameNameCSUResult =
          await _remoteService.getCSUFrameTripsByName(frameName: frameName);

      await this._GETAndREPLACECsuTRIPSInList(
          newCSUTrips:
              UnitCSUTrips(idUnit: idUnit, csuResult: listFrameNameCSUResult));

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

  // SAVE CSU FRAME TRIPS IN STORAGE
  Future<Unit> _GETAndREPLACECsuTRIPSInList(
      {required UnitCSUTrips newCSUTrips}) async {
    final savedStrings = await _storageTrips.read();
    final isNewFrameOK = newCSUTrips.csuResult.isNotEmpty;
    final isStorageSaved = savedStrings != null;

    if (isNewFrameOK) {
      switch (isStorageSaved) {
        case true:
          () async {
            // debugger(message: 'CALLED');
            final parsed = jsonDecode(savedStrings!) as List<dynamic>;

            final List<UnitCSUTrips> parsedListCSUSPK =
                listCSUResultTripsFromJson(parsed);

            final idUnit = newCSUTrips.idUnit;

            // FIRST, CHECK IF EXISTING KEY [ID-UNIT] EXIST
            final key = parsedListCSUSPK
                .firstWhereOrNull((element) => element.idUnit == idUnit);

            if (key != null) {
              final indexIdUnit = parsedListCSUSPK
                  .indexWhere((element) => element.idUnit == idUnit);

              final isIndexFound = indexIdUnit != -1;

              // [FRAME-NAME]
              if (isIndexFound) {
                final element = newCSUTrips;

                // LIST OF PARSED LIST CSU
                final list = [...parsedListCSUSPK];

                list[indexIdUnit] = element;

                log('STORAGE CSU RESULT TRIP UPDATE: ${listCSUResultTripsToJson(list)}');

                // SAVE LIST
                await _storageTrips.save(listCSUResultTripsToJson(list));
              }

              // [FRAME-NAME] NEW
              else {
                final element = newCSUTrips;

                final list = [...parsedListCSUSPK, element];

                await _storageTrips.save(listCSUResultTripsToJson(list));

                log('STORAGE CSU RESULT TRIP UPDATE W/O ID-UNIT : ${listCSUResultTripsToJson(list)}');
              }
            }
            // THEN, HANDLE WHERE [ID-UNIT] NOT EXIST,
            // PARAM IS LIST OF CSU AND INDEX [ID-SPK]
            else {
              final element = newCSUTrips;

              final list = [...parsedListCSUSPK, element];

              // SAVE LIST
              await _storageTrips.save(listCSUResultTripsToJson(list));

              log('STORAGE CSU RESULT TRIP UPDATE ID-UNIT N/A: ${listCSUResultTripsToJson(list)}');
            }

            // debugger(message: 'called');

            return unit;
          }();
          break;
        case false:
          () async {
            debugger(message: 'called');

            // SAVE LIST
            await _storageTrips.save(listCSUResultTripsToJson([newCSUTrips]));

            log('STORAGE CSU RESULT TRIP UPDATE NEW: ${listCSUResultTripsToJson([
                  newCSUTrips
                ])}');

            return unit;
          }();
      }
    } else {
      throw FormatException(
          'new CSU RESULT TRIP is Empty. In csu_repository _GETAndADDFrameInMap');
    }

    return unit;
  }

  // SAVE CSU FRAME IN STORAGE
  Future<Unit> _GETAndREPLACECsuInList(
      {required String frameName, required List<CSUResult> newCSU}) async {
    final savedStrings = await _storage.read();
    final isNewFrameOK = newCSU.isNotEmpty;
    final isStorageSaved = savedStrings != null;

    if (isNewFrameOK) {
      switch (isStorageSaved) {
        case true:
          () async {
            debugger(message: 'CALLED');
            final parsed = jsonDecode(savedStrings!) as List<dynamic>;

            final List<FrameNameCSUResult> parsedListCSUSPK =
                listFrameNameCSUResultFromJson(parsed);

            // FIRST, CHECK IF EXISTING KEY [ID-SPK] EXIST
            final key = parsedListCSUSPK
                .firstWhereOrNull((element) => element.frameName == frameName);

            if (key != null) {
              final indexIdUnit = parsedListCSUSPK
                  .indexWhere((element) => element.frameName == frameName);

              final isIndexFound = indexIdUnit != -1;

              // [FRAME-NAME]
              if (isIndexFound) {
                final element = FrameNameCSUResult(
                    frameName: frameName, csuResult: [...newCSU]);

                // LIST OF PARSED LIST CSU
                final list = [...parsedListCSUSPK];

                list[indexIdUnit] = element;

                log('STORAGE CSU SPK UPDATE: ${listFrameNameCSUResultToJson(list)}');

                // SAVE LIST
                await _storage.save(listFrameNameCSUResultToJson(list));
              }

              // [FRAME-NAME] NEW
              else {
                final element = FrameNameCSUResult(
                    frameName: frameName, csuResult: [...newCSU]);

                final list = [...parsedListCSUSPK, element];

                await _storage.save(listFrameNameCSUResultToJson(list));

                log('STORAGE CSU SPK UPDATE W/ ID-SPK : ${listFrameNameCSUResultToJson(list)}');
              }
            }
            // THEN, HANDLE WHERE [ID-SPK] NOT EXIST,
            // PARAM IS LIST OF CSU AND INDEX [ID-SPK]
            else {
              final element =
                  FrameNameCSUResult(frameName: frameName, csuResult: newCSU);

              final list = [...parsedListCSUSPK, element];

              // SAVE LIST
              await _storage.save(listFrameNameCSUResultToJson(list));

              log('STORAGE CSU SPK UPDATE ID-SPK N/A: ${listFrameNameCSUResultToJson(list)}');
            }

            debugger(message: 'called');

            return unit;
          }();
          break;
        case false:
          () async {
            debugger(message: 'called');

            final element =
                FrameNameCSUResult(frameName: frameName, csuResult: newCSU);

            // SAVE LIST
            await _storage.save(listFrameNameCSUResultToJson([element]));

            log('STORAGE CSU SPK UPDATE NEW: ${listFrameNameCSUResultToJson([
                  element
                ])}');

            return unit;
          }();
      }
    } else {
      throw FormatException(
          'new CSU RESULT TRIP is Empty. . In csu_repository _GETAndADDFrameInMap');
    }

    return unit;
  }

  /// DATA: [FrameNameCSUResult] FROM STORAGE
  ///
  /// process [frameName] and get [FrameNameCSUResult]
  Future<Either<RemoteFailure, FrameNameCSUResult>> getSPKCSUOFFLINE(
      {required String frameName}) async {
    try {
      final frameStorage = await _storage.read();

      // debugger(message: 'called');

      log('FRAME STORAGE: $frameStorage');

      // HAS MAP
      if (frameStorage != null) {
        debugger(message: 'called');

        final responsMap =
            jsonDecode(frameStorage) as List<Map<String, dynamic>>;

        final List<FrameNameCSUResult> response =
            listFrameNameCSUResultFromJson(responsMap);

        debugger(message: 'called');

        log('FRAME STORAGE RESPONSE: $response');

        // FIRST, CHECK IF EXISTING KEY [ID-SPK] EXIST
        final key = response
            .firstWhereOrNull((element) => element.frameName == frameName);

        if (key != null) {
          debugger(message: 'called');

          return right(key);
        } else {
          debugger(message: 'called');

          return left(RemoteFailure.parse(message: 'LIST EMPTY'));
        }
      } else {
        debugger(message: 'called');

        return left(RemoteFailure.parse(message: 'LIST EMPTY'));
      }
    } on RestApiException catch (e) {
      debugger(message: 'called');

      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      debugger(message: 'called');

      return left(RemoteFailure.noConnection());
    } on FormatException catch (error) {
      debugger(message: 'called');

      return left(RemoteFailure.parse(message: error.message));
    }
  }

  /// DATA: [UnitCSUTrips] FROM STORAGE
  ///
  /// process [idUnit] and get [UnitCSUTrips]
  Future<Either<RemoteFailure, UnitCSUTrips>> getSPKCSUFrameTripsOFFLINE(
      {required int idUnit}) async {
    try {
      final frameStorage = await _storageTrips.read();

      // debugger(message: 'called');

      log('FRAME TRIPS STORAGE: $frameStorage');

      // HAS MAP
      if (frameStorage != null) {
        debugger(message: 'called');

        final responsMap = jsonDecode(frameStorage) as List<dynamic>;

        final List<UnitCSUTrips> response =
            listCSUResultTripsFromJson(responsMap);

        debugger(message: 'called');

        log('FRAME TRIPS STORAGE RESPONSE: $response');

        // FIRST, CHECK IF EXISTING KEY [ID-SPK] EXIST
        final key =
            response.firstWhereOrNull((element) => element.idUnit == idUnit);

        if (key != null) {
          debugger(message: 'called');

          return right(key);
        } else {
          debugger(message: 'called');

          return left(RemoteFailure.parse(message: 'LIST EMPTY'));
        }
      } else {
        debugger(message: 'called');

        return left(RemoteFailure.parse(message: 'LIST EMPTY'));
      }
    } on RestApiException catch (e) {
      debugger(message: 'called');

      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      debugger(message: 'called');

      return left(RemoteFailure.noConnection());
    } on FormatException catch (error) {
      debugger(message: 'called');

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
}
