import 'package:agung_opr/domain/local_failure.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/infrastructure/frame/frame_repository.dart';
import 'package:agung_opr/infrastructure/update_frame/update_frame_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auto_data_update_frame_state.dart';

class AutoDataUpdateFrameNotifier
    extends StateNotifier<AutoDataUpdateFrameState> {
  AutoDataUpdateFrameNotifier(
      this._updateFrameRepository, this._frameRepository)
      : super(AutoDataUpdateFrameState.initial());

  final UpdateFrameRepository _updateFrameRepository;
  final FrameRepository _frameRepository;

  // TO EXECUTE UPDATE FRAME DUMMY
  // 1. Read saved query from UpdateFrameRepository
  // 2. Save idSPK from saved query [WILL NEED]
  // 3. Execute each query
  // 4. If query success after executed, clear query from UpdateFrameRepository
  // 5. Clear Frame from FrameRepository from saved idSPK

  void changeSavedQuery(
      {required Map<String, Map<String, String>> idSPKMapidTIUnitMapQuery}) {
    state = state.copyWith(idSPKMapidTIUnitMapQuery: idSPKMapidTIUnitMapQuery);
  }

  Future<void> getSavedQueryFromRepository() async {
    Either<LocalFailure, Map<String, Map<String, String>>>? FOS;

    state = state.copyWith(isGetting: true, FOSOSPKAutoDataUpdateFrame: none());

    FOS = await _updateFrameRepository.getUpdateQueryListSPKOFFLINE();

    state = state.copyWith(
        isGetting: false, FOSOSPKAutoDataGetSavedUpdateFrame: optionOf(FOS));
  }

  Future<void> runSavedQueryFromRepository(
      {required Map<String, Map<String, String>>
          idSPKMapidTIUnitMapQuery}) async {
    Either<RemoteFailure, Unit>? FOS;

    state = state.copyWith(isGetting: true, FOSOSPKAutoDataUpdateFrame: none());

    FOS = await _updateFrameRepository.updateFrameByQuery(
        queryMap: idSPKMapidTIUnitMapQuery);

    state = state.copyWith(
        isGetting: false, FOSOSPKAutoDataUpdateFrame: optionOf(FOS));
  }

  Future<void> clearSavedFrameFromRepository({required String idSPK}) async {
    Either<LocalFailure, Map<String, Map<String, String>>>? FOS;

    state = state.copyWith(isGetting: true, FOSOSPKAutoDataUpdateFrame: none());

    FOS = await _frameRepository.removeSPKFromMap(idSPK: idSPK);

    state = state.copyWith(
        isGetting: false, FOSOSPKAutoDataGetSavedUpdateFrame: optionOf(FOS));
  }
}
