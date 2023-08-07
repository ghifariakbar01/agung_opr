import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/supir/supir.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../domain/local_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import '../supir/supir_remote_service.dart';

class SupirRepository {
  SupirRepository(
    this._remoteService,
    this._storage,
  );

  final SupirRemoteService _remoteService;
  final CredentialsStorage _storage;

  Future<bool> hasOfflineData() => getStorageCondition()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<Supir>>> getSupirList(
      {required int page}) async {
    try {
      final modelList = await _remoteService.getSupirList(page: page);

      await _storage.save(jsonEncode(modelList));

      return right(modelList);
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

  /// PAGINATE DATA LIST OF [Supir] FROM STORAGE
  ///
  /// process [page] and divide LIST OF [Supir]
  Future<Either<RemoteFailure, List<Supir>>> getSupirListOFFLINE(
      {required int page}) async {
    try {
      final supirStorage = await _storage.read();

      log('SUPIR STORAGE: $supirStorage');

      // HAS LIST
      if (supirStorage != null) {
        // final _getTotalPages = (modelList.length / itemsPerPage).ceil();

        final response = jsonDecode(supirStorage);

        // START PAGINATION

        final int itemsPerPage = 20;

        int _startIndex = page * itemsPerPage;

        List<Supir> supirList =
            (response as List).map((data) => Supir.fromJson(data)).toList();

        final _endIndex = (_startIndex + itemsPerPage) <= supirList.length
            ? (_startIndex + itemsPerPage)
            : supirList.length;

        List<Supir> supirPage = supirList.sublist(_startIndex, _endIndex);

        // END PAGINATION

        log('SUPIR PAGE: $supirPage');

        return right(supirPage);
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

  /// SEARCH BY [ID], [NAMA], [PHONE], [ALAMAT], [KATEGORI]
  Future<Either<RemoteFailure, List<Supir>>> searchSupirListOFFLINE(
      {required String search}) async {
    try {
      final supirStorage = await _storage.read();

      final searchLowerCase = search.toLowerCase();

      log('SUPIR STORAGE: $supirStorage');

      // HAS LIST
      if (supirStorage != null) {
        final response = jsonDecode(supirStorage);

        List<Supir> supirList =
            (response as List).map((data) => Supir.fromJson(data)).toList();

        final searchedList = supirList.where((supir) {
          return supir.id.toString() == searchLowerCase ||
              supir.nama?.toLowerCase() == searchLowerCase ||
              supir.phone?.toLowerCase() == searchLowerCase ||
              supir.alamat.toString() == searchLowerCase ||
              supir.kategori.toString() == searchLowerCase;
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
}
