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
  HistoryRepository(
      this._remoteService, this._userModelWithPassword, this._storage);

  final CredentialsStorage _storage;
  final HistoryRemoteService _remoteService;
  final UserModelWithPassword _userModelWithPassword;

  Future<bool> hasOfflineData() => getStorageCondition()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  // Future<bool> hasOfflineData() => getGatesOFFLINE()
  //     .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<History>>> getHistories() async {
    try {
      // debugger(message: 'called');

      final histories = await _remoteService.getHistories(
          idUser: _userModelWithPassword.idUser!);

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

  Future<Either<RemoteFailure, Unit>> insertHistories(
      {required List<History> histories}) async {
    // debugger(message: 'called');

    final tgl = StringUtils.trimmedDate(DateTime.now());

    debugger();

    for (int i = 0; i < histories.length; i++) {
      try {
        await _remoteService.insertToHistory(
            idUser: histories[i].idUser,
            content: histories[i].content,
            query: histories[i].query,
            cUser: histories[i].cUser ?? '',
            cDate: histories[i].cDate ?? '',
            sDate: tgl);
        // debugger(message: 'called');

        await clearHistoryFromStorage(history: histories[i]);
      } on RestApiException catch (e) {
        // debugger(message: 'called');

        await clearHistoryFromStorage(history: histories[i]);

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

      // debugger(message: 'called');
    }

    // debugger(message: 'called');

    return right(unit);
  }

  // SAVE HISTORY IN STORAGE
  Future<Unit> saveHistoryInStorage({required History history}) async {
    final isStorageNotEmpty =
        await _storage.read().then((value) => value != null && value != '[]');

    if (isStorageNotEmpty) {
      final storageJson = (await _storage.read());

      final storage = History.HistoryListFromJson(
          jsonDecode(storageJson!) as List<dynamic>);

      final json = History.HistoryListToJson([...storage, history]);

      await _storage.save(json);
    } else {
      final json = History.HistoryListToJson([history]);

      await _storage.save(json);
    }

    return unit;
  }

  // CLEAR HISTORY FROM STORAGE
  Future<Unit> clearHistoryFromStorage({required History history}) async {
    final isStorageNotEmpty =
        await _storage.read().then((value) => value != null && value != '[]');

    if (isStorageNotEmpty) {
      final storageJson = await _storage.read();

      final storage = History.HistoryListFromJson(
          jsonDecode(storageJson!) as List<dynamic>);

      final json = History.HistoryListToJson(
          [...storage.where((element) => element != history)]);

      await _storage.save(json);
    }

    return unit;
  }

  Future<Unit> clearHistoryFromStorageByIdSPK({required String idSPK}) async {
    final isStorageNotEmpty =
        await _storage.read().then((value) => value != null && value != '[]');

    if (isStorageNotEmpty) {
      final storageJson = await _storage.read();

      final storage = History.HistoryListFromJson(
          jsonDecode(storageJson!) as List<dynamic>);

      final History? historyWithIdSPK = storage.firstWhereOrNull(
        (element) => element.content.contains(idSPK),
      );

      if (historyWithIdSPK != null) {
        final json = History.HistoryListToJson(
            [...storage.where((element) => element != historyWithIdSPK)]);

        await _storage.save(json);
      } else {
        return unit;
      }
    }

    return unit;
  }

  /// DATA: [History] FROM STORAGE
  ///
  Future<Either<LocalFailure, List<History>>> getHistoriesOFFLINE() async {
    try {
      final historiesStorage = await _storage.read();

      // debugger(message: 'called');

      log('HISTORIES STORAGE: $historiesStorage');

      // HAS MAP
      if (historiesStorage != null) {
        final responsMap = jsonDecode(historiesStorage) as List<dynamic>;

        final List<History> response =
            responsMap.map((e) => History.fromJson(e)).toList();

        log('HISTORIES STORAGE RESPONSE: $response');

        if (response.isNotEmpty) {
          return right(response);
        } else {
          // debugger(message: 'CALLED');
          log('historiesStorage : NOT OK');

          return right([]);
        }
      } else {
        return left(LocalFailure.format('LIST EMPTY'));
      }
    } on FormatException catch (error) {
      return left(LocalFailure.format(error.message));
    }
  }

  Future<Either<LocalFailure, String?>> getStorageCondition() async {
    try {
      final storedCredentials = await _storage.read();

      if (storedCredentials == null || storedCredentials == '[]') {
        return left(LocalFailure.empty());
      } else {
        // debugger(message: 'called');
        log('storedCredentials $storedCredentials');
      }

      return right(storedCredentials);
    } on FormatException {
      return left(LocalFailure.format('Error while parsing'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }
}
