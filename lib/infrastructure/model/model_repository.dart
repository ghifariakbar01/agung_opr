import 'dart:convert';
import 'dart:developer';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/infrastructure/model/model_remote_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/model/model.dart';
import '../../domain/local_failure.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';

class ModelRepository {
  ModelRepository(
    this._remoteService,
    this._storage,
  );

  final ModelRemoteService _remoteService;
  final CredentialsStorage _storage;

  Future<bool> hasOfflineData() => getStorageCondition()
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<Model>>> getModelList(
      {required int page}) async {
    try {
      final modelList = await _remoteService.getModelList(page: page);

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

  /// PAGINATE DATA LIST OF [Model] FROM STORAGE
  ///
  /// process [page] and divide LIST OF [Model]
  Future<Either<RemoteFailure, List<Model>>> getModelListOFFLINE(
      {required int page}) async {
    try {
      final modelStorage = await _storage.read();

      log('MODEL STORAGE: $modelStorage');

      // HAS LIST
      if (modelStorage != null) {
        // final _getTotalPages = (modelList.length / itemsPerPage).ceil();

        final response = jsonDecode(modelStorage);

        // START PAGINATION

        final int itemsPerPage = 20;

        int _startIndex = page * itemsPerPage;

        List<Model> modelList =
            (response as List).map((data) => Model.fromJson(data)).toList();

        final _endIndex = (_startIndex + itemsPerPage) <= modelList.length
            ? (_startIndex + itemsPerPage)
            : modelList.length;

        List<Model> modelPage = modelList.sublist(_startIndex, _endIndex);

        // END PAGINATION

        log('modelPage $modelPage');

        return right(modelPage);
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

  /// SEARCH BY [ID] , [MERK], [NAMA], [CATEGORY], [GROSSWEIGHT], [MEASUREMENT]
  Future<Either<RemoteFailure, List<Model>>> searchModelListOFFLINE(
      {required String search}) async {
    try {
      final modelStorage = await _storage.read();

      final searchLowerCase = search.toLowerCase();

      log('MODEL STORAGE: $modelStorage');

      // HAS LIST
      if (modelStorage != null) {
        final response = jsonDecode(modelStorage);

        List<Model> modelList =
            (response as List).map((data) => Model.fromJson(data)).toList();

        final searchedList = modelList.where((model) {
          return model.id.toString() == searchLowerCase ||
              model.merk?.toLowerCase() == searchLowerCase ||
              model.nama?.toLowerCase() == searchLowerCase ||
              model.category?.toLowerCase() == searchLowerCase ||
              model.grossweight.toString() == searchLowerCase ||
              model.measurement.toString() == searchLowerCase;
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
