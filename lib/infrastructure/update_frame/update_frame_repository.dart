import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/update_frame/frame.dart';
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
/// QUERY, BY TI_UNIT
/// [FrameSPKStorage]
///

/// [SAVED] MODEL => [
/* 
    Map<String, String> 

    example:

   {
      "711815": "UPDATE opr_trs_ti_unit SET frame = 'new_frame_value', engine = 'new_engine_value', warna = 'new_warna_value', id_kend_type = 'new_id_kend_type_value' WHERE id_unit = 711815",
      "711816":"UPDATE opr_trs_ti_unit SET frame = 'new_frame_value', engine = 'new_engine_value', warna = 'new_warna_value', id_kend_type = 'new_id_kend_type_value' WHERE id_unit = 711816",
      "711817":"UPDATE opr_trs_ti_unit SET frame = 'new_frame_value', engine = 'new_engine_value', warna = 'new_warna_value', id_kend_type = 'new_id_kend_type_value' WHERE id_unit = 711817",
      "711818":"UPDATE opr_trs_ti_unit SET frame = 'new_frame_value', engine = 'new_engine_value', warna = 'new_warna_value', id_kend_type = 'new_id_kend_type_value' WHERE id_unit = 711818"
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

  Future<Either<RemoteFailure, Unit>> updateFrameSPK(
      {required IDUnit idUnit,
      required FrameUnit frame,
      required EngineUnit engine,
      required WarnaUnit warna,
      required NoReffEXP noReff,
      required SPPDC sppdc,
      required IDKendType idKendType}) async {
    try {
      final idUnitStr = idUnit.getOrCrash();
      final idUnitInt = int.parse(idUnitStr);

      final idKendTypeStr = idKendType.getOrCrash();
      final frameStr = frame.getOrCrash();
      final engineStr = engine.getOrCrash();
      final warnaStr = warna.getOrCrash();
      final noReffStr = noReff.getOrCrash();
      // final sppdcStr = sppdc.getOrCrash();

      final frameResponse = await _remoteService.updateFrame(
          idUnit: idUnitInt,
          idKendType: int.parse(idKendTypeStr),
          engine: engineStr,
          frame: frameStr,
          warna: warnaStr,
          noReffExp: noReffStr);

      await getAndAddFrameSPK(newFrame: [frameResponse]);

      return right(unit);
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException {
      return left(RemoteFailure.parse());
    } on JsonUnsupportedObjectError {
      return left(RemoteFailure.parse());
    } on PlatformException {
      return left(RemoteFailure.storage());
    }
  }

  // IF FRAME UPDATE LIST HAS SAVED DATA IN _storage
  Future<void> getAndAddFrameSPK({required List<Frame> newFrame}) async {
    final savedStrings = await _storage.read();
    final isNewFrameOK = newFrame.isNotEmpty;
    final isStorageSaved = savedStrings != null;

    if (isNewFrameOK) {
      switch (isStorageSaved) {
        case true:
          () async {
            debugger(message: 'CALLED');
            final parsedMap = jsonDecode(savedStrings!) as List<Frame>;

            parsedMap.addAll(newFrame);

            debugger(message: 'called');

            log('STORAGE UPDATE FRAME UPDATE: ${jsonEncode(parsedMap)}');

            await _storage.save(jsonEncode(parsedMap));
          }();
          break;
        case false:
          () async {
            debugger(message: 'called');

            log('STORAGE UPDATE FRAME SAVE: ${jsonEncode(newFrame)}');

            await _storage.save(jsonEncode(newFrame));
          }();
      }
    }
  }

  /// DATA: LIST OF [Frame] FROM STORAGE
  ///
  /// process [idUnit] and get LIST OF [Frame]
  Future<Either<RemoteFailure, List<Frame>>> getFrameListSPKOFFLINE() async {
    try {
      final frameStorage = await _storage.read();

      log('UPDATE FRAME STORAGE: $frameStorage');

      // HAS MAP
      if (frameStorage != null) {
        debugger(message: 'CALLED');
        final response = jsonDecode(frameStorage) as List<Frame>;

        log('UPDATE FRAME STORAGE DECODED: $response');

        if (response.isNotEmpty) {
          return right(response);
        } else {
          return right([]);
        }
      } else {
        return right([]);
      }
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException {
      return left(RemoteFailure.parse());
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
}
