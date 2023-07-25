import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/update_frame/frame.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/model/model.dart';
import '../../domain/local_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import 'frame_remote_service copy.dart';

class FrameRepository {
  FrameRepository(
    this._remoteService,
    this._storage,
  );

  final FrameRemoteService _remoteService;
  final CredentialsStorage _storage;

  Future<bool> hasOfflineData() => getStorageCondition()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<Frame>>> getFrameList(
      {required int idSPK}) async {
    try {
      final modelList = await _remoteService.getFrameList(idSPK: idSPK);

      await getAndAddFrame(newFrame: modelList);

      if (modelList[idSPK] != null) {
        return right(modelList[idSPK] as List<Frame>);
      } else {
        return right([]);
      }
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

  // IF FRAME LIST HAS SAVED DATA IN _storage
  Future<void> getAndAddFrame({required Map<int, List<Frame>> newFrame}) async {
    final savedStrings = await _storage.read();
    final isNewFrameOK = newFrame.values.isNotEmpty;
    final isStorageSaved = savedStrings != null;

    if (isNewFrameOK) {
      switch (isStorageSaved) {
        case true:
          () async {
            final parsedMap =
                jsonDecode(savedStrings!) as Map<int, List<Frame>>;

            parsedMap.addAll(newFrame);

            debugger(message: 'called');

            log('STORAGE FRAME UPDATE: ${jsonEncode(parsedMap)}');

            await _storage.save(jsonEncode(parsedMap));
          }();
          break;
        case false:
          () async {
            debugger(message: 'called');

            log('STORAGE FRAME SAVE: ${jsonEncode(newFrame)}');

            await _storage.save(jsonEncode(newFrame));
          }();
      }
    }
  }

  /// PAGINATE DATA LIST OF [Model] FROM STORAGE
  ///
  /// process [idSPK] and get LIST OF [Model]
  Future<Either<RemoteFailure, List<Frame>>> getFrameListOFFLINE(
      {required int idSPK}) async {
    try {
      final frameStorage = await _storage.read();

      log('FRAME STORAGE: $frameStorage');

      // HAS MAP
      if (frameStorage != null) {
        final response = jsonDecode(frameStorage) as Map<int, List<Frame>>;

        log('framePage $response');

        if (response.containsValue(idSPK)) {
          return right(response[idSPK] as List<Frame>);
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
