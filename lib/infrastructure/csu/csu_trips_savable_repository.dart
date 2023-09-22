import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';

import '../../application/check_sheet/unit/state/csu_trips.dart';
import '../../application/check_sheet/unit/state/unit_csu_trips.dart';
import '../../domain/remote_failure.dart';
import '../cache_storage.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';

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

class CSUTripsSavableRepository implements Cache<CSUTrips, UnitCSUTrips> {
  final CredentialsStorage _storage;

  CSUTripsSavableRepository({required CredentialsStorage storage})
      : _storage = storage;

  /// DATA: [UnitCSUTrips] FROM STORAGE
  ///
  /// process [idUnit] and get LIST OF [CSUTrips] FROM [UnitCSUTrips]
  @override
  Future<Either<RemoteFailure, List<CSUTrips>>> getByKey(String key) async {
    try {
      final idUnit = int.parse(key);

      final frameStorage = await _storage.read();

      // debugger(message: 'called');

      log('FRAME TRIPS STORAGE: $frameStorage');

      // HAS MAP
      if (frameStorage != null) {
        // debugger(message: 'called');

        final responsMap = jsonDecode(frameStorage) as List<dynamic>;

        final List<UnitCSUTrips> response =
            UnitCSUTrips.listCSUResultTripsFromJson(responsMap);

        // debugger(message: 'called');

        log('FRAME TRIPS STORAGE RESPONSE: $response');

        // FIRST, CHECK IF EXISTING KEY [ID-SPK] EXIST
        final key =
            response.firstWhereOrNull((element) => element.idUnit == idUnit);

        if (key != null) {
          // debugger(message: 'called');
          final csuResults = key.csuResult;

          if (csuResults.isNotEmpty) {
            // debugger(message: 'called');

            return right(csuResults);
          } else {
            // debugger(message: 'called');

            return right([]);
          }
        } else {
          // debugger(message: 'called');

          return left(RemoteFailure.parse(message: 'LIST EMPTY'));
        }
      } else {
        // debugger(message: 'called');

        return left(RemoteFailure.parse(message: 'LIST EMPTY'));
      }
    } on RestApiException catch (e) {
      // debugger(message: 'called');

      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      // debugger(message: 'called');

      return left(RemoteFailure.noConnection());
    } on FormatException catch (error) {
      // debugger(message: 'called');

      return left(RemoteFailure.parse(message: error.message));
    }
  }

  @override
  Future<Unit> setByKey(String key, UnitCSUTrips newCSUTrips) async {
    final savedStrings = await _storage.read();
    final isNewFrameOK = newCSUTrips.csuResult.isNotEmpty;
    final isStorageSaved = savedStrings != null;

    if (isNewFrameOK) {
      switch (isStorageSaved) {
        case true:
          () async {
            // debugger(message: 'CALLED');
            final parsed = jsonDecode(savedStrings!) as List<dynamic>;

            final List<UnitCSUTrips> parsedListCSUSPK =
                UnitCSUTrips.listCSUResultTripsFromJson(parsed);

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

                log('STORAGE CSU RESULT TRIP UPDATE: ${UnitCSUTrips.listCSUResultTripsToJson(list)}');

                // SAVE LIST
                await _storage
                    .save(UnitCSUTrips.listCSUResultTripsToJson(list));
              }

              // [FRAME-NAME] NEW
              else {
                final element = newCSUTrips;

                final list = [...parsedListCSUSPK, element];

                await _storage
                    .save(UnitCSUTrips.listCSUResultTripsToJson(list));

                log('STORAGE CSU RESULT TRIP UPDATE W/O ID-UNIT : ${UnitCSUTrips.listCSUResultTripsToJson(list)}');
              }
            }
            // THEN, HANDLE WHERE [ID-UNIT] NOT EXIST,
            // PARAM IS LIST OF CSU AND INDEX [ID-SPK]
            else {
              final element = newCSUTrips;

              final list = [...parsedListCSUSPK, element];

              // SAVE LIST
              await _storage.save(UnitCSUTrips.listCSUResultTripsToJson(list));

              log('STORAGE CSU RESULT TRIP UPDATE ID-UNIT N/A: ${UnitCSUTrips.listCSUResultTripsToJson(list)}');
            }

            // debugger(message: 'called');

            return unit;
          }();
          break;
        case false:
          () async {
            // debugger(message: 'called');

            // SAVE LIST
            await _storage
                .save(UnitCSUTrips.listCSUResultTripsToJson([newCSUTrips]));

            log('STORAGE CSU RESULT TRIP UPDATE NEW: ${UnitCSUTrips.listCSUResultTripsToJson([
                  newCSUTrips
                ])}');

            return unit;
          }();
      }
    }

    return unit;
  }
}
