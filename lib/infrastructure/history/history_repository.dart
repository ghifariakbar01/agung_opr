import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/history/history.dart';
import '../../application/user/user_model.dart';
import '../../domain/local_failure.dart';
import '../../domain/remote_failure.dart';
import '../../utils/string_utils.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import 'history_remote_service.dart';

/// [History]

class HistoryRepository {
  HistoryRepository(this._remoteService, this._userModelWithPassword);

  final HistoryRemoteService _remoteService;
  final UserModelWithPassword _userModelWithPassword;

  // Future<bool> hasOfflineData() => getStorageCondition()
  //     .then((credentials) => credentials.fold((_) => false, (_) => true));

  // Future<bool> hasOfflineData() => getGatesOFFLINE()
  //     .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<History>>> getHistories() async {
    try {
      // debugger(message: 'called');

      final histories = await _remoteService.getHistories(
        cUser: _userModelWithPassword.nama!,
      );

      return right(histories);
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
}
