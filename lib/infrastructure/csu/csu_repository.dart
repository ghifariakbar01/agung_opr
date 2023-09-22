import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../application/check_sheet/unit/state/csu_ng_result.dart';
import '../../application/check_sheet/unit/state/csu_ng_result_by_id.dart';
import '../../application/check_sheet/unit/state/csu_result.dart';
import '../../application/check_sheet/unit/state/csu_trips.dart';
import '../../application/check_sheet/unit/state/spk_csu_result.dart';
import '../../application/check_sheet/unit/state/unit_csu_trips.dart';
import '../../domain/local_failure.dart';
import '../../domain/remote_failure.dart';
import '../cache_storage.dart';
import '../credentials_storage.dart';
import '../exceptions.dart';
import 'csu_remote_service.dart';

class CSUFrameRepository {
  CSUFrameRepository({
    required this.storage,
    required this.storageNG,
    required this.storageTrips,
    required this.remoteService,
    required this.ngCacheRepository,
    required this.tripsCacheRepository,
    required this.resultCacheRepository,
  });

  final CSUFrameRemoteService remoteService;
  //
  final CredentialsStorage storage;
  final CredentialsStorage storageNG;
  final CredentialsStorage storageTrips;
  //
  final Cache<CSUTrips, UnitCSUTrips> tripsCacheRepository;
  final Cache<CSUNGResult, CSUNGResultByID> ngCacheRepository;
  final Cache<CSUResult, FrameNameCSUResult> resultCacheRepository;

  Future<bool> hasOfflineCSUNGResultIndex(int idCS) => ngCacheRepository
      .getByKey(idCS.toString())
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<bool> hasOfflineCSUResultIndex(String frameName) =>
      resultCacheRepository
          .getByKey(frameName)
          .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<bool> hasOfflineTripsDataIndex(int idUnit) => tripsCacheRepository
      .getByKey(idUnit.toString())
      .then((credentials) => credentials.fold((_) => false, (_) => true));

  Future<Either<RemoteFailure, List<CSUResult>>> getCSUByFrameName(
      {required String frameName}) async {
    try {
      final listFrameNameCSUResult =
          await remoteService.getCSUByFrameName(frameName: frameName);

      final FrameNameCSUResult frameCSUResult = FrameNameCSUResult(
          frameName: frameName, csuResult: listFrameNameCSUResult);

      await this.resultCacheRepository.setByKey(frameName, frameCSUResult);

      return right(listFrameNameCSUResult);
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

  Future<Either<RemoteFailure, List<CSUNGResult>>> getCSUNGByIdCS(
      {required int idCS}) async {
    try {
      final listFrameNameCSUNGResult =
          await remoteService.getCSUNGByIdCS(idCS: idCS);

      debugger();

      final csuNGResult =
          CSUNGResultByID(idCS: idCS, csuNGResult: listFrameNameCSUNGResult);

      await ngCacheRepository.setByKey(idCS.toString(), csuNGResult);

      return right(listFrameNameCSUNGResult);
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

  Future<Either<RemoteFailure, List<CSUTrips>>> getCSUFrameTripsByName(
      {required int idUnit, required String frameName}) async {
    try {
      final listFrameNameCSUResult =
          await remoteService.getCSUFrameTripsByName(frameName: frameName);

      await this.tripsCacheRepository.setByKey(idUnit.toString(),
          UnitCSUTrips(idUnit: idUnit, csuResult: listFrameNameCSUResult));

      return right(listFrameNameCSUResult);
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

  Future<Either<LocalFailure, String?>> getStorageCondition() async {
    try {
      final storedCredentials = await storage.read();

      if (storedCredentials == null) {
        return left(LocalFailure.empty());
      }

      debugger(message: 'called');

      return right(storedCredentials);
    } on FormatException {
      return left(LocalFailure.format('Error while parsing'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  Future<Either<LocalFailure, String?>> getStorageConditionTrips() async {
    try {
      final storedCredentials = await storageTrips.read();

      if (storedCredentials == null) {
        return left(LocalFailure.empty());
      }

      debugger(message: 'called');

      return right(storedCredentials);
    } on FormatException {
      return left(LocalFailure.format('Error while parsing'));
    } on PlatformException {
      return left(LocalFailure.storage());
    }
  }

  Future<Unit> clearNGStorage() async {
    final storedCredentials = await storageNG.read();

    if (storedCredentials == null) {
      return unit;
    }

    debugger(message: 'called');

    await storageNG.clear();

    return unit;
  }

  Future<Unit> clearTripsStorage() async {
    final storedCredentials = await storageTrips.read();

    if (storedCredentials == null) {
      return unit;
    }

    debugger(message: 'called');

    await storageTrips.clear();

    return unit;
  }

  Future<Unit> clearCSUResultStorage() async {
    final storedCredentials = await storageTrips.read();

    if (storedCredentials == null) {
      return unit;
    }

    debugger(message: 'called');

    await storageTrips.clear();

    return unit;
  }
}
