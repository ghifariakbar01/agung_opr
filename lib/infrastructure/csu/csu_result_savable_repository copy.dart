import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/state/csu_result.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';

import '../../application/check_sheet/unit/state/spk_csu_result.dart';
import '../../domain/remote_failure.dart';
import '../cache_storage.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';

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

class CSUResultSavableRepository
    implements Cache<CSUResult, FrameNameCSUResult> {
  final CredentialsStorage _storage;

  CSUResultSavableRepository({required CredentialsStorage storage})
      : _storage = storage;

  /// DATA: [FrameNameCSUResult] FROM STORAGE
  ///
  /// process [frameName] and get [FrameNameCSUResult]

  @override
  Future<Either<RemoteFailure, List<CSUResult>>> getByKey(
      String frameName) async {
    try {
      final frameStorage = await _storage.read();

      // debugger(message: 'called');

      log('FRAME STORAGE: $frameStorage');

      // HAS MAP
      if (frameStorage != null) {
        // debugger(message: 'called');

        final responsMap = jsonDecode(frameStorage) as List<dynamic>;

        final List<FrameNameCSUResult> response =
            listFrameNameCSUResultFromJson(responsMap);

        // debugger(message: 'called');

        log('FRAME STORAGE RESPONSE: $response');

        // FIRST, CHECK IF EXISTING KEY [ID-SPK] EXIST
        final key = response
            .firstWhereOrNull((element) => element.frameName == frameName);

        if (key != null) {
          // debugger(message: 'called');

          return right(key.csuResult);
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
  Future<Unit> setByKey(
      String frameName, FrameNameCSUResult newCSUResult) async {
    final savedStrings = await _storage.read();
    final isNewFrameOK = newCSUResult.csuResult.isNotEmpty;
    final isStorageSaved = savedStrings != null;

    if (isNewFrameOK) {
      switch (isStorageSaved) {
        case true:
          () async {
            // debugger(message: 'CALLED');
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
                final element = newCSUResult;

                // LIST OF PARSED LIST CSU
                final list = [...parsedListCSUSPK];

                list[indexIdUnit] = element;

                log('STORAGE CSU SPK UPDATE: ${listFrameNameCSUResultToJson(list)}');

                debugger();

                // SAVE LIST
                await _storage.save(listFrameNameCSUResultToJson(list));
              }

              // [FRAME-NAME] NEW
              else {
                final element = newCSUResult;

                final list = [...parsedListCSUSPK, element];

                await _storage.save(listFrameNameCSUResultToJson(list));

                log('STORAGE CSU SPK UPDATE W/ ID-SPK : ${listFrameNameCSUResultToJson(list)}');

                debugger();
              }
            }
            // THEN, HANDLE WHERE [ID-SPK] NOT EXIST,
            // PARAM IS LIST OF CSU AND INDEX [ID-SPK]
            else {
              final element = newCSUResult;

              final list = [...parsedListCSUSPK, element];

              // SAVE LIST
              await _storage.save(listFrameNameCSUResultToJson(list));

              log('STORAGE CSU SPK UPDATE ID-SPK N/A: ${listFrameNameCSUResultToJson(list)}');

              debugger();
            }

            // debugger(message: 'called');

            return unit;
          }();
          break;
        case false:
          () async {
            // debugger(message: 'called');

            final element = newCSUResult;

            // SAVE LIST
            await _storage.save(listFrameNameCSUResultToJson([element]));

            log('STORAGE CSU SPK UPDATE NEW: ${listFrameNameCSUResultToJson([
                  element
                ])}');

            return unit;
          }();
      }
    }

    return unit;
  }
}
