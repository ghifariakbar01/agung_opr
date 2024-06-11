import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/local_failure.dart';
import '../../domain/remote_failure.dart';
import '../../infrastructure/update_cs/update_cs_repository.dart';
import '../../infrastructure/update_csu/update_csu_repository.dart';
import '../../infrastructure/update_frame/update_frame_repository.dart';
import '../../infrastructure/update_spk/update_spk_repository.dart';
import '../check_sheet/shared/state/cs_id_query.dart';
import '../check_sheet/unit/state/csu_id_query.dart';
import '../spk/application/spk_id_query.dart';
import 'auto_data_update_frame_state.dart';

class AutoDataUpdateFrameNotifier
    extends StateNotifier<AutoDataUpdateFrameState> {
  AutoDataUpdateFrameNotifier(
    this._updateCSRepository,
    this._updateSPKRepository,
    this._updateFrameRepository,
    this._updateCSUFrameRepository,
  ) : super(AutoDataUpdateFrameState.initial());

  final UpdateCSRepository _updateCSRepository;
  final UpdateSPKRepository _updateSPKRepository;
  final UpdateFrameRepository _updateFrameRepository;
  final UpdateCSUFrameRepository _updateCSUFrameRepository;

  // TO EXECUTE UPDATE FRAME DUMMY
  // 1. Read saved query from UpdateFrameRepository
  // 2. Save idSPK from saved query [WILL NEED]
  // 3. Execute each query
  // 4. If query success after executed, clear query from UpdateFrameRepository
  // 5. Clear Frame from FrameRepository from saved idSPK
  bool isMapEmpty(Map<String, Map<String, String>> map) {
    final _cond1 = map.entries.toList().isEmpty && map.keys.toList().isEmpty;
    log('_cond1 ${_cond1}');
    return _cond1;
  }

  void resetAutoDataRemoteFOSO() {
    state = state.copyWith(FOSOAutoDataRemote: none());
  }

  bool isSPKQueryEmpty() => state.spkIdQueries.isEmpty;

  bool isCSUQueryEmpty() => state.csuIdQueries.isEmpty;

  bool isCSQueryEmpty() => state.csIdQueries.isEmpty;

  void changeSavedQuery(
      {required Map<String, Map<String, String>> idSPKMapidTIUnitMapQuery}) {
    state = state.copyWith(idSPKMapidTIUnitMapQuery: idSPKMapidTIUnitMapQuery);
  }

  void changeSavedSPKQuery({required List<SPKIdQuery> spkIdQueries}) {
    state = state.copyWith(spkIdQueries: spkIdQueries);
  }

  void changeSavedCSUQuery({required List<CSUIDQuery> csuIdQueries}) {
    state = state.copyWith(csuIdQueries: csuIdQueries);
  }

  void changeSavedCSQuery({required List<CSIDQuery> csIdQueries}) {
    state = state.copyWith(csIdQueries: csIdQueries);
  }

  Future<void> getSavedQueryFromRepository() async {
    Either<LocalFailure, Map<String, Map<String, String>>>? FOS;

    if (state.isGetting) {
      return;
    }

    state = state.copyWith(
      isGetting: true,
      FOSOSPKAutoDataLocalUpdateFrame: none(),
    );

    FOS = await _updateFrameRepository.getUpdateQueryListOFFLINE();

    final Map<String, Map<String, String>> _map = FOS.fold((l) => {}, (r) => r);

    changeSavedQuery(idSPKMapidTIUnitMapQuery: _map);

    state = state.copyWith(
      isGetting: false,
      FOSOSPKAutoDataLocalUpdateFrame: _map.isNotEmpty ? optionOf(FOS) : none(),
    );
  }

  // UPDATE FRAME
  Future<void> runSavedQueryFromRepository({
    required Map<String, Map<String, String>> idSPKMapidTIUnitMapQuery,
  }) async {
    if (state.isGetting) {
      return;
    }

    if (isMapEmpty(idSPKMapidTIUnitMapQuery) == true) {
      return;
    }

    Either<RemoteFailure, Unit>? FOS;

    state = state.copyWith(
      isGetting: true,
      FOSOAutoDataRemote: none(),
    );

    FOS = await _updateFrameRepository.updateFrameByQuery(
      queryMap: idSPKMapidTIUnitMapQuery,
    );

    state = state.copyWith(
      isGetting: false,
      FOSOAutoDataRemote:
          idSPKMapidTIUnitMapQuery.isNotEmpty ? optionOf(FOS) : none(),
    );
  }

  Future<void> getSavedCSUQueryFromRepository() async {
    Either<LocalFailure, List<CSUIDQuery>>? FOS;

    state = state.copyWith(
      isGetting: true,
      FOSOAutoDataLocalUpdateFrameCSU: none(),
    );

    // CONVERT ID_CS_NAs to appropriate values
    FOS = await _updateCSUFrameRepository.getUpdateCSUQueryListOFFLINE();
    final List<CSUIDQuery> _list = FOS.fold((l) => [], (r) => r);
    changeSavedCSUQuery(csuIdQueries: _list);

    state = state.copyWith(
      isGetting: false,
      FOSOAutoDataLocalUpdateFrameCSU:
          _list.isNotEmpty ? optionOf(FOS) : none(),
    );
  }

  Future<void> runSavedCSUQueryFromRepository(
      {required List<CSUIDQuery> queryIds}) async {
    Either<RemoteFailure, Unit>? FOS;

    if (state.isGetting) {
      return;
    }

    if (queryIds.isEmpty) {
      return;
    }

    state = state.copyWith(isGetting: true);

    // CONVERT ID_CS_NAs to appropriate values
    FOS = await _updateCSUFrameRepository.updateCSUByQuery(queryIds: queryIds);

    state = state.copyWith(isGetting: false, FOSOAutoDataRemote: optionOf(FOS));
  }

  // 1.
  Future<void> getSavedCSQueryFromRepository() async {
    Either<LocalFailure, List<CSIDQuery>>? FOS;

    if (state.isGetting) {
      return;
    }

    log('getSavedCSQueryFromRepository --');

    state = state.copyWith(
      isGetting: true,
      FOSOAutoDataLocalUpdateFrameCS: none(),
    );

    // CONVERT ID_CS_NAs to appropriate values
    FOS = await _updateCSRepository.getUpdateCSQueryListOFFLINE();
    final List<CSIDQuery> _list = FOS.fold((l) => [], (r) => r);
    changeSavedCSQuery(csIdQueries: _list);

    state = state.copyWith(
      isGetting: false,
      FOSOAutoDataLocalUpdateFrameCS: _list.isNotEmpty ? optionOf(FOS) : none(),
    );
  }

  // CHECK SHEET LOADING / UNLOADING / LOADING & UNLOADING.
  Future<void> runSavedCSQueryFromRepository(
      {required List<CSIDQuery> queryIds}) async {
    Either<RemoteFailure, Unit>? FOS;

    if (state.isGetting) {
      return;
    }

    if (queryIds.isEmpty) {
      return;
    }

    if (queryIds.isNotEmpty) {
      state = state.copyWith(
        isGetting: true,
        FOSOAutoDataRemote: none(),
      );

      // CONVERT ID_CS_NAs to appropriate values
      FOS = await _updateCSRepository.updateCSByQuery(queryIds: queryIds);

      state = state.copyWith(
        isGetting: false,
        FOSOAutoDataRemote: optionOf(FOS),
      );
    }
  }

  // 1.
  Future<void> getSavedSPKQueryFromRepository() async {
    Either<LocalFailure, List<SPKIdQuery>>? FOS;

    state = state.copyWith(
      isGetting: true,
      FOSOAutoDataLocalUpdateFrameSPK: none(),
    );

    // CONVERT ID_CS_NAs to appropriate values
    FOS = await _updateSPKRepository.getUpdateSPKQueryListOFFLINE();
    final List<SPKIdQuery> _list = FOS.fold((l) => [], (r) => r);
    changeSavedSPKQuery(spkIdQueries: _list);

    state = state.copyWith(
      isGetting: false,
      FOSOAutoDataLocalUpdateFrameSPK:
          _list.isNotEmpty ? optionOf(FOS) : none(),
    );
  }

  // UPDATE SPK TO IS_EDIT
  Future<void> runSavedSPKQueryFromRepository(
      {required List<SPKIdQuery> queryIds}) async {
    Either<RemoteFailure, Unit>? FOS;
    if (state.isGetting) {
      return;
    }

    if (isSPKQueryEmpty()) {
      return;
    }

    if (queryIds.isNotEmpty) {
      state = state.copyWith(
        isGetting: true,
        FOSOAutoDataRemote: none(),
      );

      // CONVERT ID_CS_NAs to appropriate values
      FOS = await _updateSPKRepository.updateSPKByQuery(queryIds: queryIds);

      state = state.copyWith(
        isGetting: false,
        FOSOAutoDataRemote: optionOf(FOS),
      );
    }
  }
}
