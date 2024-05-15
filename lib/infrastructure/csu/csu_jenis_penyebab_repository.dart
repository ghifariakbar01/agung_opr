import '../../application/check_sheet/unit/state/csu_jenis_penyebab/csu_jenis_penyebab_item.dart';
import '../credentials_storage.dart';
import '../update_csu/update_csu_remote_service.dart';

import 'dart:convert';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../exceptions.dart';

class CSUJenisPenyebabRepository {
  CSUJenisPenyebabRepository(
      this._remoteService, this._jenisStorage, this._penyebabStorage);

  final UpdateCSUFrameRemoteService _remoteService;
  final CredentialsStorage _jenisStorage;
  final CredentialsStorage _penyebabStorage;

  Future<bool> hasOfflineDataJenis() => getJenisItemsOFFLINE()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<bool> hasOfflineDataPenyebab() => getPenyebabItemsOFFLINE()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
      getCSUJenisItems() async {
    try {
      final listCSUJenisItems = await _remoteService.getCSUJenisItems();

      await this._SAVECSUJenisItems(csuJenisItemsParam: listCSUJenisItems);

      return right(listCSUJenisItems);
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

  Future<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
      getCSUPenyebabItems() async {
    try {
      final listCsuPenyebabItemsParam =
          await _remoteService.getCSUPenyebabItems();

      await this._SAVECSUPenyebabItems(
          csuPenyebabItemsParam: listCsuPenyebabItemsParam);

      return right(listCsuPenyebabItemsParam);
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

// SAVE CSU JENIS ITEM IN STORAGE
  Future<Unit> _SAVECSUJenisItems(
      {required List<CSUJenisPenyebabItem> csuJenisItemsParam}) async {
    final isNewFrameOK = csuJenisItemsParam.isNotEmpty;

    if (isNewFrameOK) {
      final json = listCSUJenisPenyebabItemToJsonSavable(csuJenisItemsParam);

      await _jenisStorage.save(json);
    } else {
      throw FormatException(
          'new CSU ITEMS is Empty. In update_csu_repository _SAVECSUItems');
    }

    return unit;
  }

// SAVE CSU PENYEBAB ITEM IN STORAGE
  Future<Unit> _SAVECSUPenyebabItems(
      {required List<CSUJenisPenyebabItem> csuPenyebabItemsParam}) async {
    final isNewFrameOK = csuPenyebabItemsParam.isNotEmpty;

    if (isNewFrameOK) {
      final json = listCSUJenisPenyebabItemToJsonSavable(csuPenyebabItemsParam);

      await _penyebabStorage.save(json);
    } else {
      throw FormatException(
          'new CSU ITEMS is Empty. In update_csu_repository _SAVECSUItems');
    }

    return unit;
  }

  /// DATA: [CSUJenisPenyebabItem] FROM STORAGE
  ///
  Future<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
      getJenisItemsOFFLINE() async {
    try {
      final csJenisStorage = await _jenisStorage.read();

      if (csJenisStorage != null) {
        final List<CSUJenisPenyebabItem> response =
            (jsonDecode(csJenisStorage) as List<dynamic>)
                .map((e) => CSUJenisPenyebabItem.fromJson(e))
                .toList();

        if (response.isNotEmpty) {
          return right(response);
        } else {
          return left(RemoteFailure.parse(message: 'LIST EMPTY'));
        }
      } else {
        return left(RemoteFailure.parse(message: 'LIST EMPTY'));
      }
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException catch (error) {
      return left(RemoteFailure.parse(message: error.message));
    }
  }

  /// DATA: [CSUJenisPenyebabItem] FROM STORAGE
  ///
  Future<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
      getPenyebabItemsOFFLINE() async {
    try {
      final csPenyebabStorage = await _penyebabStorage.read();

      if (csPenyebabStorage != null) {
        final List<CSUJenisPenyebabItem> response =
            (jsonDecode(csPenyebabStorage) as List<dynamic>)
                .map((e) => CSUJenisPenyebabItem.fromJson(e))
                .toList();

        if (response.isNotEmpty) {
          return right(response);
        } else {
          return left(RemoteFailure.parse(message: 'LIST EMPTY'));
        }
      } else {
        return left(RemoteFailure.parse(message: 'LIST EMPTY'));
      }
    } on RestApiException catch (e) {
      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      return left(RemoteFailure.noConnection());
    } on FormatException catch (error) {
      return left(RemoteFailure.parse(message: error.message));
    }
  }

  Future<Unit> clearJenisStorage() async {
    final storedCredentials = await _jenisStorage.read();

    if (storedCredentials == null) {
      return unit;
    }

    await _jenisStorage.clear();
    return unit;
  }

  Future<Unit> clearPenyebabStorage() async {
    final storedCredentials = await _penyebabStorage.read();

    if (storedCredentials == null) {
      return unit;
    }

    await _penyebabStorage.clear();
    return unit;
  }
}
