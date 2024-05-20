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
      final supirList = await _remoteService.getSupirList(page: page);

      await _add(supir: supirList);

      return right(supirList);
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

  Future<Either<RemoteFailure, List<Supir>>> searchSupirList(
      {required String search}) async {
    try {
      final supirList = await _remoteService.searchSupirList(search: search);

      await _add(supir: supirList);

      return right(supirList);
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

      // log('SUPIR STORAGE: $supirStorage');

      // HAS LIST
      if (supirStorage != null) {
        // final _getTotalPages = (supirList.length / itemsPerPage).ceil();

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

  /// ADD [Supir] FROM SEARCH
  ///
  Future<Unit> _add({required List<Supir> supir}) async {
    final spkStorage = await _storage.read();

    if (spkStorage != null) {
      final response = jsonDecode(spkStorage) as List<dynamic>;

      final responseSPK = Supir.SupirListFromJson(response);

      if (responseSPK.isNotEmpty) {
        final responseSPKTosave = [...responseSPK, ...supir].toSet().toList();

        final listResponseSPKToSave = Supir.SupirListToJson(responseSPKTosave);

        await _storage.save(listResponseSPKToSave);
      }
    } else {
      await _storage.save(Supir.SupirListToJson(supir));
    }

    log('returned unit');

    return unit;
  }

  /// SEARCH BY [ID], [NAMA], [PHONE], [ALAMAT], [KATEGORI]
  Future<Either<RemoteFailure, List<Supir>>> searchSupirListOFFLINE(
      {required String search}) async {
    try {
      final supirStorage = await _storage.read();

      final searchLowerCase = search.toLowerCase();

      // HAS LIST
      if (supirStorage != null) {
        final response = jsonDecode(supirStorage);

        List<Supir> supirList =
            (response as List).map((data) => Supir.fromJson(data)).toList();

        // debugger();

        final searchedList = supirList.where((supir) {
          if (supir.nama != null &&
              supir.phone != null &&
              supir.alamat != null &&
              supir.kategori != null) {
            return supir.id.toString() == searchLowerCase ||
                supir.nama!.toLowerCase().contains(searchLowerCase) ||
                supir.phone!.toLowerCase().contains(searchLowerCase) ||
                supir.alamat.toString().contains(searchLowerCase) ||
                supir.kategori.toString().contains(searchLowerCase);
          } else if (supir.phone != null &&
              supir.alamat != null &&
              supir.kategori != null) {
            return supir.id.toString() == searchLowerCase ||
                supir.phone!.toLowerCase().contains(searchLowerCase) ||
                supir.alamat.toString().contains(searchLowerCase) ||
                supir.kategori.toString().contains(searchLowerCase);
          } else if (supir.alamat != null && supir.kategori != null) {
            return supir.id.toString() == searchLowerCase ||
                supir.alamat.toString().contains(searchLowerCase) ||
                supir.kategori.toString().contains(searchLowerCase);
          } else if (supir.kategori != null) {
            return supir.id.toString() == searchLowerCase ||
                supir.kategori.toString().contains(searchLowerCase);
          }

          return supir.id.toString() == searchLowerCase;
        }).toList();
        // debugger();

        return right(searchedList);
      } else {
        // debugger();

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
