import 'package:agung_opr/infrastructure/csu/csu_jenis_penyebab_remote_service.dart';

import '../../application/check_sheet/unit/state/csu_jenis_penyebab/csu_jenis_penyebab_item.dart';
import '../../application/check_sheet/unit/state/csu_posisi/csu_posisi.dart';
import '../credentials_storage.dart';

import 'dart:convert';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../exceptions.dart';

class CSUJenisPenyebabRepository {
  CSUJenisPenyebabRepository(
    this._remoteService,
    this._jenisStorage,
    this._posisiStorage,
  );

  final CSUJenisPeneybabRemoteService _remoteService;

  final CredentialsStorage _jenisStorage;
  final CredentialsStorage _posisiStorage;

  Future<bool> hasOfflineDataJenis() => getJenisItemsOFFLINE()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<bool> hasOfflineDataPosisi() => getPosisiItemsOFFLINE()
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

  Future<Either<RemoteFailure, List<CSUPosisi>>> getCSUPosisiItems() async {
    try {
      final posisi = await _remoteService.getCSUPosisiItems();

      await this._SAVECSUPenyebabItems(csuPenyebabItemsParam: posisi);

      return right(posisi);
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
      final json = csuJenisItemsParam.map((e) => e.toJson()).toList();
      final _encode = jsonEncode(json);
      await _jenisStorage.save(_encode);
    } else {
      throw FormatException(
          'new CSU ITEMS is Empty. In update_csu_repository _SAVECSUItems');
    }

    return unit;
  }

// SAVE CSU PENYEBAB ITEM IN STORAGE
  Future<Unit> _SAVECSUPenyebabItems(
      {required List<CSUPosisi> csuPenyebabItemsParam}) async {
    final isNewFrameOK = csuPenyebabItemsParam.isNotEmpty;

    if (isNewFrameOK) {
      final json = csuPenyebabItemsParam.map((e) => e.toJson()).toList();
      final _encode = jsonEncode(json);
      await _jenisStorage.save(_encode);
    } else {
      throw FormatException(
          'new CSU ITEMS is Empty. In update_csu_repository _SAVECSUItems');
    }

    return unit;
  }

  /// DATA: [CSUPosisi] FROM STORAGE
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
  Future<Either<RemoteFailure, List<CSUPosisi>>> getPosisiItemsOFFLINE() async {
    try {
      final csPenyebabStorage = await _posisiStorage.read();

      if (csPenyebabStorage != null) {
        final List<CSUPosisi> response =
            (jsonDecode(csPenyebabStorage) as List<dynamic>)
                .map((e) => CSUPosisi.fromJson(e))
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
    final storedCredentials = await _posisiStorage.read();

    if (storedCredentials == null) {
      return unit;
    }

    await _posisiStorage.clear();
    return unit;
  }
}
