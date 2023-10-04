import 'dart:developer';

import 'package:agung_opr/application/history/history.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/infrastructure/frame/frame_repository.dart';
import 'package:agung_opr/infrastructure/update_frame/update_frame_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/history/history_repository.dart';
import '../../infrastructure/update_cs/update_cs_repository.dart';
import '../../infrastructure/update_csu/update_csu_repository.dart';
import '../check_sheet/shared/state/cs_id_query.dart';
import '../check_sheet/unit/state/csu_id_query.dart';
import 'auto_data_update_frame_state.dart';

class AutoDataUpdateFrameNotifier
    extends StateNotifier<AutoDataUpdateFrameState> {
  AutoDataUpdateFrameNotifier(
    this._frameRepository,
    this._historyRepository,
    this._updateCSRepository,
    this._updateFrameRepository,
    this._updateCSUFrameRepository,
  ) : super(AutoDataUpdateFrameState.initial());

  final HistoryRepository _historyRepository;
  final UpdateCSRepository _updateCSRepository;
  final UpdateCSUFrameRepository _updateCSUFrameRepository;
  final UpdateFrameRepository _updateFrameRepository;
  final FrameRepository _frameRepository;

  // TO EXECUTE UPDATE FRAME DUMMY
  // 1. Read saved query from UpdateFrameRepository
  // 2. Save idSPK from saved query [WILL NEED]
  // 3. Execute each query
  // 4. If query success after executed, clear query from UpdateFrameRepository
  // 5. Clear Frame from FrameRepository from saved idSPK
  bool isMapEmpty(Map<String, Map<String, String>> map) {
    final list = map.entries.toList();
    if (map.isEmpty) {
      return true;
    }

    bool isEmpty = false;

    for (final item in list) {
      if (item.value.isNotEmpty) {
        log('ITEM VALUE: ${item.value}');
        isEmpty = false;
      } else {
        isEmpty = true;
      }
    }

    log('list is $list');

    return isEmpty;
  }

  void resetAutoDataRemoteFOSO() {
    state = state.copyWith(FOSOAutoDataRemote: none());
  }

  bool isCSUQueryEmpty() => state.csuIdQueries.isEmpty;

  bool isCSQueryEmpty() => state.csIdQueries.isEmpty;

  bool isHistoriesEmpty() => state.histories.isEmpty;

  void changeSavedQuery(
      {required Map<String, Map<String, String>> idSPKMapidTIUnitMapQuery}) {
    state = state.copyWith(idSPKMapidTIUnitMapQuery: idSPKMapidTIUnitMapQuery);
  }

  void changeSavedCSUQuery({required List<CSUIDQuery> csuIdQueries}) {
    state = state.copyWith(csuIdQueries: csuIdQueries);
  }

  void changeSavedCSQuery({required List<CSIDQuery> csIdQueries}) {
    state = state.copyWith(csIdQueries: csIdQueries);
  }

  void changeSavedHistories({required List<History> histories}) {
    state = state.copyWith(histories: histories);
  }

  Future<void> getSavedHistoriesFromRepository() async {
    Either<LocalFailure, List<History>>? FOS;

    state = state.copyWith(isGetting: true, FOSOAutoDataLocalHistory: none());

    FOS = await _historyRepository.getHistoriesOFFLINE();

    state = state.copyWith(
        isGetting: false, FOSOAutoDataLocalHistory: optionOf(FOS));
  }

  // UPDATE FRAME
  Future<void> runSavedHistoriesFromRepository(
      {required List<History> histories}) async {
    Either<RemoteFailure, Unit>? FOS;

    state = state.copyWith(isGetting: true);

    FOS = await _historyRepository.insertHistories(histories: histories);

    state = state.copyWith(isGetting: false, FOSOAutoDataRemote: optionOf(FOS));
  }

  Future<void> getSavedQueryFromRepository() async {
    Either<LocalFailure, Map<String, Map<String, String>>>? FOS;

    state = state.copyWith(
        isGetting: true, FOSOSPKAutoDataLocalUpdateFrame: none());

    FOS = await _updateFrameRepository.getUpdateQueryListSPKOFFLINE();

    state = state.copyWith(
        isGetting: false, FOSOSPKAutoDataLocalUpdateFrame: optionOf(FOS));
  }

  // UPDATE FRAME
  Future<void> runSavedQueryFromRepository(
      {required Map<String, Map<String, String>>
          idSPKMapidTIUnitMapQuery}) async {
    Either<RemoteFailure, Unit>? FOS;

    state = state.copyWith(isGetting: true);

    FOS = await _updateFrameRepository.updateFrameByQuery(
        queryMap: idSPKMapidTIUnitMapQuery);

    state = state.copyWith(isGetting: false, FOSOAutoDataRemote: optionOf(FOS));
  }

  // 1.
  Future<void> getSavedCSUQueryFromRepository() async {
    Either<LocalFailure, List<CSUIDQuery>>? FOS;

    state = state.copyWith(
        isGetting: true, FOSOAutoDataLocalUpdateFrameCSU: none());

    // CONVERT ID_CS_NAs to appropriate values
    FOS = await _updateCSUFrameRepository.getUpdateCSUQueryListOFFLINE();

    state = state.copyWith(
        isGetting: false, FOSOAutoDataLocalUpdateFrameCSU: optionOf(FOS));
  }

  // 2.
  Future<void> runSavedCSUQueryFromRepository(
      {required List<CSUIDQuery> queryIds}) async {
    Either<RemoteFailure, Unit>? FOS;

    state = state.copyWith(isGetting: true);

    // CONVERT ID_CS_NAs to appropriate values
    FOS = await _updateCSUFrameRepository.updateCSUByQuery(queryIds: queryIds);

    state = state.copyWith(isGetting: false, FOSOAutoDataRemote: optionOf(FOS));
  }

  // 1.
  Future<void> getSavedCSQueryFromRepository() async {
    Either<LocalFailure, List<CSIDQuery>>? FOS;

    state =
        state.copyWith(isGetting: true, FOSOAutoDataLocalUpdateFrameCS: none());

    // CONVERT ID_CS_NAs to appropriate values
    FOS = await _updateCSRepository.getUpdateCSQueryListOFFLINE();

    state = state.copyWith(
        isGetting: false, FOSOAutoDataLocalUpdateFrameCS: optionOf(FOS));
  }

  // CHECK SHEET LOADING / UNLOADING / LOADING & UNLOADING.
  Future<void> runSavedCSQueryFromRepository(
      {required List<CSIDQuery> queryIds}) async {
    Either<RemoteFailure, Unit>? FOS;

    state = state.copyWith(isGetting: true);

    // CONVERT ID_CS_NAs to appropriate values
    FOS = await _updateCSRepository.updateCSByQuery(queryIds: queryIds);

    state = state.copyWith(isGetting: false, FOSOAutoDataRemote: optionOf(FOS));
  }
}
