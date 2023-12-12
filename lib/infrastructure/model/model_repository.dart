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

      await _add(model: modelList);

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

  Future<Either<RemoteFailure, List<Model>>> searchModelList(
      {required String search, required bool includeParts}) async {
    try {
      final modelList = await _remoteService.searchModelList(
          search: search, includeParts: includeParts);

      await this._add(model: modelList);

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

  /// ADD [Model] FROM SEARCH
  ///
  Future<Unit> _add({required List<Model> model}) async {
    final modelStorage = await _storage.read();

    if (modelStorage != null) {
      final response = jsonDecode(modelStorage) as List<dynamic>;

      final responseModel = Model.ModelListFromJson(response);

      if (responseModel.isNotEmpty) {
        final responseModelTosave = [...responseModel, ...model].toList();

        final listResponseModelToSave =
            Model.ModelListToJson(responseModelTosave);

        await _storage.save(listResponseModelToSave);
      }
    } else {
      await _storage.save(Model.ModelListToJson(model));
    }

    return unit;
  }

  /// PAGINATE DATA LIST OF [Model] FROM STORAGE
  ///
  /// process [page] and divide LIST OF [Model]
  Future<Either<RemoteFailure, List<Model>>> getModelListOFFLINE(
      {int? page, bool? allModel}) async {
    try {
      final modelStorage = await _storage.read();

      // log('MODEL STORAGE: $modelStorage');

      // HAS LIST
      if (modelStorage != null) {
        // final _getTotalPages = (modelList.length / itemsPerPage).ceil();

        final response = jsonDecode(modelStorage);

        if (allModel != null && allModel == true) {
          List<Model> modelList =
              (response as List).map((data) => Model.fromJson(data)).toList();

          return right(modelList);
        }

        if (page != null) {
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
          return right([]);
        }
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
      {required String search, required bool includeParts}) async {
    try {
      final modelStorage = await _storage.read();

      final searchLowerCase = search.toLowerCase();

      // log('MODEL STORAGE: $modelStorage');

      // HAS LIST
      if (modelStorage != null) {
        final response = jsonDecode(modelStorage);

        List<Model> modelList = (response as List)
            .map((data) => Model.fromJson(data))
            .toSet()
            .toList();

        final searchedList = modelList
            .where((model) {
              if (model.merk != null &&
                  model.nama != null &&
                  model.category != null) {
                return model.id.toString() == searchLowerCase ||
                    model.merk!.toLowerCase().contains(searchLowerCase) ||
                    model.nama!.toLowerCase().contains(searchLowerCase) ||
                    model.category!.toLowerCase().contains(searchLowerCase);
              } else if (model.nama != null && model.category != null) {
                return model.id.toString() == searchLowerCase ||
                    model.nama!.toLowerCase().contains(searchLowerCase) ||
                    model.category!.toLowerCase().contains(searchLowerCase);
              } else if (model.category != null) {
                return model.id.toString() == searchLowerCase ||
                    model.category!.toLowerCase().contains(searchLowerCase);
              }

              return model.id.toString() == searchLowerCase ||
                  model.grossweight.toString().contains(searchLowerCase) ||
                  model.measurement.toString().contains(searchLowerCase);
            })
            .toSet()
            .toList();

        debugger();

        if (includeParts) {
          return right(searchedList);
        } else {
          final searchedListWithoutParts = searchedList
              .where((element) => element.nama!.contains('part') == false)
              .toList();

          return right(searchedListWithoutParts);
        }
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
