import 'dart:developer';

import 'package:agung_opr/domain/local_failure.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/infrastructure/frame/frame_repository.dart';
import 'package:agung_opr/infrastructure/update_frame/update_frame_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/update_csu/update_csu_repository.dart';
import '../check_sheet/unit/state/csu_id_query.dart';
import 'auto_data_update_frame_state.dart';

class AutoDataUpdateFrameNotifier
    extends StateNotifier<AutoDataUpdateFrameState> {
  AutoDataUpdateFrameNotifier(
    this._updateCSUFrameRepository,
    this._updateFrameRepository,
    this._frameRepository,
  ) : super(AutoDataUpdateFrameState.initial());

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

  bool isCSUQueryEmpty() => state.csuIdQueries.isEmpty;

  void changeSavedQuery(
      {required Map<String, Map<String, String>> idSPKMapidTIUnitMapQuery}) {
    state = state.copyWith(idSPKMapidTIUnitMapQuery: idSPKMapidTIUnitMapQuery);
  }

  void changeSavedCSUQuery({required List<CSUIDQuery> csuIdQueries}) {
    state = state.copyWith(csuIdQueries: csuIdQueries);
  }

  Future<void> getSavedQueryFromRepository() async {
    Either<LocalFailure, Map<String, Map<String, String>>>? FOS;

    state = state.copyWith(
        isGetting: true, FOSOSPKAutoDataLocalUpdateFrame: none());

    FOS = await _updateFrameRepository.getUpdateQueryListSPKOFFLINE();

    state = state.copyWith(
        isGetting: false, FOSOSPKAutoDataLocalUpdateFrame: optionOf(FOS));
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

    state = state.copyWith(isGetting: true, FOSOAutoDataRemote: none());

    // CONVERT ID_CS_NAs to appropriate values
    FOS = await _updateCSUFrameRepository.updateCSUByQuery(queryIds: queryIds);

    state = state.copyWith(isGetting: false, FOSOAutoDataRemote: optionOf(FOS));
  }

  Future<void> runSavedQueryFromRepository(
      {required Map<String, Map<String, String>>
          idSPKMapidTIUnitMapQuery}) async {
    Either<RemoteFailure, Unit>? FOS;

    state = state.copyWith(isGetting: true, FOSOAutoDataRemote: none());

    FOS = await _updateFrameRepository.updateFrameByQuery(
        queryMap: idSPKMapidTIUnitMapQuery);

    state = state.copyWith(isGetting: false, FOSOAutoDataRemote: optionOf(FOS));
  }

  Future<void> clearSavedFrameFromRepository({required String idSPK}) async {
    Either<LocalFailure, Map<String, Map<String, String>>>? FOS;

    state = state.copyWith(
        isGetting: true, FOSOSPKAutoDataLocalUpdateFrame: none());

    FOS = await _frameRepository.removeSPKFromMap(idSPK: idSPK);

    state = state.copyWith(
        isGetting: false, FOSOSPKAutoDataLocalUpdateFrame: optionOf(FOS));
  }
}
