import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';

import '../../application/check_sheet/unit/state/csu_ng_result.dart';
import '../../application/check_sheet/unit/state/csu_ng_result_by_id.dart';
import '../../domain/remote_failure.dart';
import '../cache_storage.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';

/// LIST OF [CSUNGResultByID]
/// [SAVED] MODEL => [
/* 
    List<CSUNGResultByID> 

*/

class CSUNGResultSavableRepository
    implements Cache<CSUNGResult, CSUNGResultByID> {
  final CredentialsStorage _storage;

  CSUNGResultSavableRepository({required CredentialsStorage storage})
      : _storage = storage;

  /// DATA: [CSUNGResultByID] FROM STORAGE
  ///
  /// process [idCS] and get LIST OF [CSUNGResult] FROM [CSUNGResultByID]
  @override
  Future<Either<RemoteFailure, List<CSUNGResult>>> getByKey(String key) async {
    try {
      final idCS = int.parse(key);

      final frameStorage = await _storage.read();

      // debugger(message: 'called');

      log('CSU NG RESULT STORAGE: $frameStorage');

      // HAS MAP
      if (frameStorage != null) {
        // debugger(message: 'called');

        final responsMap = jsonDecode(frameStorage) as List<dynamic>;

        final List<CSUNGResultByID> response =
            CSUNGResultByID.CSUNGResultListFromJson(responsMap);

        // debugger(message: 'called');

        log('CSU NG RESULT STORAGE RESPONSE: $response');

        // FIRST, CHECK IF EXISTING KEY [ID-SPK] EXIST
        final key =
            response.firstWhereOrNull((element) => element.idCS == idCS);

        if (key != null) {
          // debugger(message: 'called');
          final csuResults = key.csuNGResult;

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
  Future<Unit> setByKey(String idCS, CSUNGResultByID newCSUTrips) async {
    final savedStrings = await _storage.read();
    final isNewFrameOK = newCSUTrips.csuNGResult.isNotEmpty;
    final isStorageSaved = savedStrings != null;

    if (isNewFrameOK) {
      switch (isStorageSaved) {
        case true:
          () async {
            // debugger(message: 'CALLED');
            final parsed = jsonDecode(savedStrings!) as List<dynamic>;

            final List<CSUNGResultByID> parsedListCSUSNG =
                CSUNGResultByID.CSUNGResultListFromJson(parsed);

            // FIRST, CHECK IF EXISTING KEY [ID-CS] EXIST
            final key = parsedListCSUSNG
                .firstWhereOrNull((element) => element.idCS == idCS);

            if (key != null) {
              final indexIdCS = parsedListCSUSNG
                  .indexWhere((element) => element.idCS == idCS);

              final isIndexFound = indexIdCS != -1;

              // [FRAME-NAME]
              if (isIndexFound) {
                // LIST OF PARSED LIST CSU
                final list = [...parsedListCSUSNG];

                list[indexIdCS] = newCSUTrips;

                log('STORAGE CSU NG RESULT BY ID UPDATE: ${CSUNGResultByID.CSUNGResultListToJson(list)}');

                // SAVE LIST
                await _storage
                    .save(CSUNGResultByID.CSUNGResultListToJson(list));
              }

              // [FRAME-NAME] NEW
              else {
                final list = [...parsedListCSUSNG, newCSUTrips];

                await _storage
                    .save(CSUNGResultByID.CSUNGResultListToJson(list));

                log('STORAGE CSU NG RESULT BY IDE W/O ID-CS : ${CSUNGResultByID.CSUNGResultListToJson(list)}');
              }
            }
            // THEN, HANDLE WHERE [ID-CS] NOT EXIST,
            // PARAM IS LIST OF CSU NG AND INDEX [ID-CS]
            else {
              final list = [...parsedListCSUSNG, newCSUTrips];

              await _storage.save(CSUNGResultByID.CSUNGResultListToJson(list));

              log('STORAGE CSU NG RESULT BY ID CS W/O ID-CS : ${CSUNGResultByID.CSUNGResultListToJson(list)}');
            }

            // debugger(message: 'called');

            return unit;
          }();
          break;
        case false:
          () async {
            // SAVE LIST
            await _storage
                .save(CSUNGResultByID.CSUNGResultListToJson([newCSUTrips]));

            log('STORAGE CSU NG RESULT BY ID CS UPDATE NEW: ${CSUNGResultByID.CSUNGResultListToJson([
                  newCSUTrips
                ])}');

            return unit;
          }();
      }
    }

    return unit;
  }
}
