import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/check_sheet/shared/state/cs_id_query.dart';
import '../../application/history/history.dart';
import '../../domain/remote_failure.dart';
import '../exceptions.dart';
import '../history/history_repository.dart';
import '../update_cs/update_cs_repository.dart';
import '../update_frame/update_frame_repository.dart';

class AutoDataRepository {
  final UpdateFrameRepository _updateFrameRepository;
  final UpdateCSRepository _updateCSRepository;

  AutoDataRepository(this._updateFrameRepository, this._updateCSRepository);

  Future<Either<RemoteFailure, Unit>> runAutoDataFromRepositories({
    required List<History> histories,
    required List<CSIDQuery> queryIds,
    required Map<String, Map<String, String>> queryMap,
  }) async {
    try {
      if (queryMap.isNotEmpty)
        await _updateFrameRepository.updateFrameByQuery(queryMap: queryMap);

      if (queryIds.isNotEmpty)
        await _updateCSRepository.updateCSByQuery(queryIds: queryIds);

      return right(unit);
    } on RestApiException catch (e) {
      debugger(message: 'called');

      return left(RemoteFailure.server(e.errorCode, e.message));
    } on NoConnectionException {
      debugger(message: 'called');

      // await _removeQueryCSFromSaved(idSPK: idSPK);

      return left(RemoteFailure.noConnection());
    } on RangeError catch (e) {
      debugger(message: 'called');
      return left(RemoteFailure.parse(message: e.message));
    } on FormatException catch (e) {
      return left(RemoteFailure.parse(message: e.message));
    } on JsonUnsupportedObjectError {
      return left(RemoteFailure.parse(message: 'JsonUnsupportedObjectError'));
    } on PlatformException {
      return left(RemoteFailure.storage());
    }
  }
}
