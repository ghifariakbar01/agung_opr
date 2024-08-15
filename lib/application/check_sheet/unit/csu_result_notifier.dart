import 'package:agung_opr/application/update_frame/frame.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/infrastructure/csu/csu_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state/csu_ng/csu_ng_result.dart';
import 'state/csu_result.dart';
import 'state/csu_result_state.dart';
import 'state/csu_trips/csu_trips.dart';

class CSUFrameResultNotifier extends StateNotifier<CSUResultState> {
  CSUFrameResultNotifier(this._repository) : super(CSUResultState.initial());

  final CSUFrameRepository _repository;

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

    FOS = await _repository.getCSUNGResultByIDOFFLINE(idCS: idCS);

    state = state.copyWith(isProcessing: false, FOSOCSUNGResult: optionOf(FOS));
  }

  // Future<void> getCSUTripsByFrameId(
  //     {required int idUnit, required String frameName}) async {
  //   final Either<RemoteFailure, List<CSUTrips>> FOS;

  //   state = state.copyWith(isProcessing: true, FOSOCSUTripsResult: none());

  //   FOS = await _repository.getCSUFrameTripsByName(
  //       idUnit: idUnit, frameName: frameName);

  //   state =
  //       state.copyWith(isProcessing: false, FOSOCSUTripsResult: optionOf(FOS));
  // }

  // Future<void> getCSUTripsByFrameIdOFFLINE({required int idUnit}) async {
  //   final Either<RemoteFailure, List<CSUTrips>> FOS;

  //   state = state.copyWith(isProcessing: true, FOSOCSUTripsResult: none());

  //   FOS = await _repository.getCSUFrameTripsOFFLINE(idUnit: idUnit);

  //   state =
  //       state.copyWith(isProcessing: false, FOSOCSUTripsResult: optionOf(FOS));
  // }

  Future<void> getCSUResultByFrameNameOFFLINE({required String frame}) async {
    final Either<RemoteFailure, List<CSUResult>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCSUResult: none());

    FOS = await _repository.getSPKCSUOFFLINE(frameName: frame);

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
