import 'package:agung_opr/application/check_sheet/unit/state/csu_trips.dart';
import 'package:agung_opr/application/update_frame/frame.dart';
import 'package:agung_opr/application/update_frame/update_frame_single_state.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/infrastructure/csu/csu_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state/csu_result.dart';
import 'state/csu_result_state.dart';

class CSUFrameResultNotifier extends StateNotifier<CSUResultState> {
  CSUFrameResultNotifier(this._repository) : super(CSUResultState.initial());

  final CSUFrameRepository _repository;

  Future<void> getCSUByFrameName({required String frameName}) async {
    final Either<RemoteFailure, List<CSUResult>> FOS;

    state = state.copyWith(isProcessing: true, FOSOCSUResult: none());

    FOS = await _repository.getCSUByFrameName(frameName: frameName);

    state = state.copyWith(isProcessing: false, FOSOCSUResult: optionOf(FOS));
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

    FOS = await _repository.getCSUFrameTripsOFFLINE(idUnit: idUnit);

    state =
        state.copyWith(isProcessing: false, FOSOCSUTripsResult: optionOf(FOS));
  }

  void changeCSUResultList(List<CSUResult> csuResultList) {
    state = state.copyWith(csuResultList: [...csuResultList]);
  }

  void changeCSUTripsResultList(List<CSUTrips> csuTripsResultList) {
    state = state.copyWith(csuTripsResultList: [...csuTripsResultList]);
  }

  void changeFrameName(String frameName) {
    state = state.copyWith(frameName: frameName);
  }

  void changeFrame(Frame frame) {
    state = state.copyWith(frame: frame);
  }

  // Future<void> saveFrameIndexedSPK(
  //     {required int idSPK,
  //     required int index,
  //     required UpdateFrameStateSingle newFrame}) async {
  //   final Either<LocalFailure, Unit> FOS;

  //   state = state.copyWith(isProcessing: true);

  //   this._changeFOSOSaveFrame(index: index, FOS: none());

  //   final idUnitStr = newFrame.idUnit.getOrCrash();
  //   final idUnitInt = int.parse(idUnitStr);
  //   final idKendTypeStr = newFrame.idKendType.getOrCrash();
  //   final idKendTypeInt = int.parse(idKendTypeStr);
  //   final frameStr = newFrame.frame.getOrCrash();
  //   final engineStr = newFrame.engine.getOrCrash();
  //   final warnaStr = newFrame.warna.getOrCrash();
  //   final noReffStr = newFrame.noReff.getOrCrash();

  //   final frame = Frame(
  //       idUnit: idUnitInt,
  //       frame: frameStr,
  //       engine: engineStr,
  //       warna: warnaStr,
  //       noReffExp: noReffStr,
  //       idKendType: idKendTypeInt);

  //   FOS = await _repository.saveFrameIndexedSPK(
  //       idSPK: idSPK, index: index, newFrame: frame);

  //   state = state.copyWith(isProcessing: false);

  //   this._changeFOSOSaveFrame(index: index, FOS: optionOf(FOS));
  // }

  // Future<void> getFrameListOFFLINE({required int idSPK}) async {
  //   final Either<RemoteFailure, List<Frame>> FOS;

  //   state = state.copyWith(isProcessing: true, FOSOFrame: none());

  //   FOS = await _repository.getFrameListOFFLINE(idSPK: idSPK);

  //   state = state.copyWith(isProcessing: false, FOSOFrame: optionOf(FOS));
  // }

  // void changeFillEmptyFOSOSaveFrameList({required int length}) {
  //   Either<LocalFailure, Unit>? FOS;

  //   final generateList = List.generate(length, (index) => optionOf(FOS));

  //   state = state.copyWith(FOSOSaveFrame: generateList);
  // }

  // void _changeFOSOSaveFrame(
  //     {required Option<Either<LocalFailure, Unit>> FOS, required int index}) {
  //   final list = [...state.FOSOSaveFrame]; // Create a copy of the list

  //   final Option<Either<LocalFailure, Unit>> updatedElement = FOS;

  //   // Update the element at the given index
  //   list[index] = updatedElement;

  //   // Update the state with the new list
  //   state = state.copyWith(FOSOSaveFrame: list);
  // }
}
