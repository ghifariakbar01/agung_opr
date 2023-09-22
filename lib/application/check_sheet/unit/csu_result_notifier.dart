import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/remote_failure.dart';
import '../../../infrastructure/cache_storage.dart';
import '../../../infrastructure/csu/csu_repository.dart';
import '../../update_frame/frame.dart';
import 'state/csu_ng_result.dart';
import 'state/csu_ng_result_by_id.dart';
import 'state/csu_result.dart';
import 'state/csu_result_state.dart';
import 'state/csu_trips.dart';
import 'state/spk_csu_result.dart';
import 'state/unit_csu_trips.dart';

class CSUFrameResultNotifier extends StateNotifier<CSUResultState> {
  CSUFrameResultNotifier(this._repository, this.ngCacheRepository,
      this.resultCacheRepository, this.tripsSavableRepository)
      : super(CSUResultState.initial());

  final CSUFrameRepository _repository;
  //
  final Cache<CSUTrips, UnitCSUTrips> tripsSavableRepository;
  final Cache<CSUNGResult, CSUNGResultByID> ngCacheRepository;
  final Cache<CSUResult, FrameNameCSUResult> resultCacheRepository;

  Future<void> getCSUByFrameName({required String frameName}) async {
    final Either<RemoteFailure, List<CSUResult>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCSUResult: none());

    FOS = await _repository.getCSUByFrameName(frameName: frameName);

    state = state.copyWith(isProcessing: false, FOSOCSUResult: optionOf(FOS));
  }

  Future<void> getCSUNGByIdCS({required int idCS}) async {
    final Either<RemoteFailure, List<CSUNGResult>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCSUNGResult: none());

    FOS = await _repository.getCSUNGByIdCS(idCS: idCS);

    state = state.copyWith(isProcessing: false, FOSOCSUNGResult: optionOf(FOS));
  }

  Future<void> getCSUNGByIdCSOFFLINE({required int idCS}) async {
    final Either<RemoteFailure, List<CSUNGResult>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCSUNGResult: none());

    FOS = await ngCacheRepository.getByKey(idCS.toString());

    state = state.copyWith(isProcessing: false, FOSOCSUNGResult: optionOf(FOS));
  }

  Future<void> getCSUTripsByFrameId(
      {required int idUnit, required String frameName}) async {
    final Either<RemoteFailure, List<CSUTrips>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCSUTripsResult: none());

    FOS = await _repository.getCSUFrameTripsByName(
        idUnit: idUnit, frameName: frameName);

    state =
        state.copyWith(isProcessing: false, FOSOCSUTripsResult: optionOf(FOS));
  }

  Future<void> getCSUTripsByFrameIdOFFLINE({required int idUnit}) async {
    final Either<RemoteFailure, List<CSUTrips>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCSUTripsResult: none());

    FOS = await tripsSavableRepository.getByKey(idUnit.toString());

    state =
        state.copyWith(isProcessing: false, FOSOCSUTripsResult: optionOf(FOS));
  }

  Future<void> getCSUResultByFrameNameOFFLINE({required String frame}) async {
    final Either<RemoteFailure, List<CSUResult>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCSUResult: none());

    FOS = await resultCacheRepository.getByKey(frame);

    state = state.copyWith(isProcessing: false, FOSOCSUResult: optionOf(FOS));
  }

  void changeCSUResultList(List<CSUResult> csuResultList) {
    state = state.copyWith(csuResultList: [...csuResultList]);
  }

  void changeCSUNGResultList(List<CSUNGResult> csuNGResultList) {
    state = state.copyWith(csuNGResultList: [...csuNGResultList]);
  }

  void changeCSUTripsResultList(List<CSUTrips> csuTripsResultList) {
    if (csuTripsResultList.isNotEmpty) {
      state = state.copyWith(csuTripsResultList: [...csuTripsResultList]);
    }
  }

  void changeFrame(Frame frame) {
    state = state.copyWith(frame: frame);
  }
}
