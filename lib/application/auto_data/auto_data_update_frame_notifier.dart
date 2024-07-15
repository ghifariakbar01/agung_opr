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

    state = state.copyWith(
      isGetting: false,
      idSPKMapidTIUnitMapQuery: _map,
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

    Either<RemoteFailure, Unit>? FOS;

    state = state.copyWith(
      FOSOAutoDataRemote: none(),
    );

    FOS = await _updateFrameRepository.updateFrameByQuery(
      queryMap: idSPKMapidTIUnitMapQuery,
    );

    state = state.copyWith(
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

    FOS = await _updateCSUFrameRepository.getUpdateCSUQueryListOFFLINE();

    final List<CSUIDQuery> _list = FOS.fold(
      (l) => [],
      (r) => r,
    );

    if (_list.isEmpty) {
      return;
    }

    state = state.copyWith(
      isGetting: false,
      csuIdQueries: _list,
      FOSOAutoDataLocalUpdateFrameCSU:
          _list.isNotEmpty ? optionOf(FOS) : none(),
    );
  }

  Future<void> runSavedCSUQueryFromRepository({
    required List<CSUIDQuery> queryIds,
  }) async {
    Either<RemoteFailure, Unit>? FOS;

    if (state.isGetting) {
      return;
    }

    if (queryIds.isEmpty) {
      return;
    }

    state = state.copyWith(
      FOSOAutoDataRemote: none(),
    );

    FOS = await _updateCSUFrameRepository.updateCSUByQuery(
      queryIds: queryIds,
    );

    state = state.copyWith(
      FOSOAutoDataRemote: optionOf(FOS),
    );
  }

  // 1.
  Future<void> getSavedCSQueryFromRepository() async {
    Either<LocalFailure, List<CSIDQuery>>? FOS;

    if (state.isGetting) {
      return;
    }

    state = state.copyWith(
      isGetting: true,
      FOSOAutoDataLocalUpdateFrameCS: none(),
    );

    // CONVERT ID_CS_NAs to appropriate values
    FOS = await _updateCSRepository.getUpdateCSQueryListOFFLINE();
    final List<CSIDQuery> _list = FOS.fold((l) => [], (r) => r);

    state = state.copyWith(
      isGetting: false,
      csIdQueries: _list,
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

    state = state.copyWith(
      FOSOAutoDataRemote: none(),
    );

    // CONVERT ID_CS_NAs to appropriate values
    FOS = await _updateCSRepository.updateCSByQuery(
      queryIds: queryIds,
    );

    state = state.copyWith(
      FOSOAutoDataRemote: optionOf(FOS),
    );
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

    state = state.copyWith(
      isGetting: false,
      spkIdQueries: _list,
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

    if (queryIds.isEmpty) {
      return;
    }

    state = state.copyWith(
      FOSOAutoDataRemote: none(),
    );

    // CONVERT ID_CS_NAs to appropriate values
    FOS = await _updateSPKRepository.updateSPKByQuery(queryIds: queryIds);

    state = state.copyWith(
      FOSOAutoDataRemote: optionOf(FOS),
    );
  }
}
