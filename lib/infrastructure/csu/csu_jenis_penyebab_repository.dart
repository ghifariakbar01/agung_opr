import '../credentials_storage.dart';
import '../update_csu/update_csu_remote_service.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/state/csu_id_query.dart';
import 'package:agung_opr/application/check_sheet/unit/state/csu_items.dart';
import 'package:agung_opr/application/check_sheet/unit/state/csu_jenis_penyebab_item.dart';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../domain/local_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';

class CSUJenisPenyebabRepository {
  CSUJenisPenyebabRepository(
      this._remoteService, this._jenisStorage, this._penyebabStorage);

  final UpdateCSUFrameRemoteService _remoteService;
  final CredentialsStorage _jenisStorage;
  final CredentialsStorage _penyebabStorage;

  Future<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>
      getCSUJenisItems() async {
    try {
      debugger(message: 'called');

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
      debugger(message: 'called');

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
}
