import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/spk/spk.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/infrastructure/spk/spk_remote_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../domain/local_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';

class SPKRepository {
  SPKRepository(
    this._remoteService,
    this._storage,
  );

  final SPKRemoteService _remoteService;
  final CredentialsStorage _storage;

  Future<bool> hasOfflineData() => getStorageCondition()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<SPK>>> getSPKList(
      {required int page}) async {
    try {
      final spkList = await _remoteService.getSPKList(page: page);

      await _storage.save(jsonEncode(spkList));

      return right(spkList);
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException {
      return left(RemoteFailure.parse());
    } on PlatformException {
      return left(RemoteFailure.storage());
    }
  }

  Future<Either<RemoteFailure, List<SPK>>> searchSPKList(
      {required String search}) async {
    try {
      final spkList = await _remoteService.searchSPKList(search: search);

      await this._add(spk: spkList);

      return right(spkList);
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException {
      return left(RemoteFailure.parse());
    } on PlatformException {
      return left(RemoteFailure.storage());
    }
  }

  /// ADD [SPK] FROM SEARCH
  ///
  Future<Unit> _add({required List<SPK> spk}) async {
    final spkStorage = await _storage.read();

    if (spkStorage != null) {
      final response = jsonDecode(spkStorage) as List<dynamic>;

      final responseSPK = SPK.SPKListFromJson(response);

      if (responseSPK.isNotEmpty) {
        final responseSPKTosave = [...responseSPK, ...spk].toSet().toList();

        final listResponseSPKToSave = SPK.SPKListToJson(responseSPKTosave);

        await _storage.save(listResponseSPKToSave);
      }
    }

    log('returned unit');

    return unit;
  }

  /// PAGINATE DATA LIST OF [SPK] FROM STORAGE
  ///
  /// process [page] and divide LIST OF [SPK]
  Future<Either<RemoteFailure, List<SPK>>> getSPKListOFFLINE(
      {required int page}) async {
    try {
      final spkStorage = await _storage.read();

      log('SPK STORAGE: $spkStorage');

      // HAS LIST
      if (spkStorage != null) {
        // final _getTotalPages = (spkList.length / itemsPerPage).ceil();

        final response = jsonDecode(spkStorage);

        // START PAGINATION

        final int itemsPerPage = 10;

        int _startIndex = page * itemsPerPage;

        List<SPK> spkList =
            (response as List).map((data) => SPK.fromJson(data)).toList();

        final _endIndex = (_startIndex + itemsPerPage) <= spkList.length
            ? (_startIndex + itemsPerPage)
            : spkList.length;

        List<SPK> spkPage = spkList.sublist(_startIndex, _endIndex);

        // END PAGINATION

        log('spkPage $spkPage');

        return right(spkPage);
      } else {
        log('spkPage empty ');

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

  /// SEARCH BY [NO_SPK] , [NOPOL], [DRIVER]
  Future<Either<RemoteFailure, List<SPK>>> searchSPKListOFFLINE(
      {required String search}) async {
    try {
      final spkStorage = await _storage.read();

      final searchUpperCase = search.toUpperCase();

      log('SPK STORAGE: $spkStorage');

      // HAS LIST
      if (spkStorage != null) {
        final response = jsonDecode(spkStorage);

        List<SPK> spkList =
            (response as List).map((data) => SPK.fromJson(data)).toList();

        final searchedList = spkList.where((element) {
          if (element.supir1Nm != null && element.supir2Nm != null) {
            return element.spkNo.contains(search) ||
                element.nopol.contains(search) ||
                element.supir1Nm!.contains(searchUpperCase) ||
                element.supir2Nm!.contains(searchUpperCase);
          }

          if (element.supir1Nm != null) {
            return element.spkNo.contains(search) ||
                element.nopol.contains(search) ||
                element.supir1Nm!.contains(searchUpperCase);
          }

          if (element.supir2Nm != null) {
            return element.spkNo.contains(search) ||
                element.nopol.contains(search) ||
                element.supir2Nm!.contains(searchUpperCase);
          }
          return element.spkNo.contains(search) ||
              element.nopol.contains(search);
        }).toList();

        return right(searchedList);
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

  Future<Unit> clearSPKStorage() async {
    final storedCredentials = await _storage.read();

    if (storedCredentials == null) {
      return unit;
    }

    await _storage.clear();

    return unit;
  }
}
