import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/history/history.dart';
import '../../application/user/user_model.dart';
import '../../domain/remote_failure.dart';
import '../exceptions.dart';
import 'history_remote_service.dart';

/// [History]

class HistoryRepository {
  HistoryRepository(this._remoteService, this._userModelWithPassword);

  final HistoryRemoteService _remoteService;
  final UserModelWithPassword _userModelWithPassword;

  Future<Either<RemoteFailure, History>> getHistories({
    required String nopol,
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      final history = History.initial();

      final List<HistoryCheckSheet> historyCheckSheet =
          await _remoteService.getHistoryCheckSheet(
        cUser: _userModelWithPassword.nama!,
        nopol: nopol,
        start: start,
        end: end,
      );

      final List<HistoryCSUOk> historyCSUOk =
          await _remoteService.getHistoryCSUOk(
        cUser: _userModelWithPassword.fullname!,
        start: start,
        end: end,
      );

      final List<HistoryCSUNg> historyCSUNg =
          await _remoteService.getHistoryCSUNg(
        cUser: _userModelWithPassword.fullname!,
        start: start,
        end: end,
      );

      final _history = history.copyWith(
          historyCheckSheet: historyCheckSheet,
          historyCSUOk: historyCSUOk,
          historyCSUNg: historyCSUNg);

      return right(_history);
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
