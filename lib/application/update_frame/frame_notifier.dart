import 'dart:developer';

import 'package:agung_opr/application/update_frame/frame.dart';
import 'package:agung_opr/application/update_frame/frame_state.dart';
import 'package:agung_opr/application/update_frame/update_frame_single_state.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/frame/frame_repository.dart';

class FrameNotifier extends StateNotifier<FrameState> {
  FrameNotifier(this._repository) : super(FrameState.initial());

  final FrameRepository _repository;

  void changeFillInitial() {
    state = FrameState.initial();
  }

  Future<void> getFrameList({required int idSPK}) async {
    final Either<RemoteFailure, List<Frame>> FOS;

    state = state.copyWith(isProcessing: true, FOSOFrame: none());

    FOS = await _repository.getFrameList(idSPK: idSPK);

    state = state.copyWith(isProcessing: false, FOSOFrame: optionOf(FOS));
  }

  Future<void> getFrameListWithoutSPK({required int page}) async {
    final Either<RemoteFailure, List<Frame>> FOS;

    state = state.copyWith(isProcessing: true, FOSOFrame: none());

    FOS = await _repository.getFrameListWithoutSPK(page: page);

    state = state.copyWith(isProcessing: false, FOSOFrame: optionOf(FOS));
  }

  Future<void> searchFrameListWithoutSPK({required String frame}) async {
    final Either<RemoteFailure, List<Frame>> FOS;

    state = state.copyWith(isProcessing: true, FOSOFrame: none());

    FOS = await _repository.searchFrameListWithoutSPK(search: frame);

    state = state.copyWith(isProcessing: false, FOSOFrame: optionOf(FOS));
  }

  Future<void> searchFrameListOFFLINE(
      {required String idSPK, required String frame}) async {
    final Either<RemoteFailure, List<Frame>> FOS;

    state = state.copyWith(isProcessing: true, FOSOFrame: none());

    FOS = await _repository.searchFrameListOFFLINE(idSPK: idSPK, search: frame);

    state = state.copyWith(isProcessing: false, FOSOFrame: optionOf(FOS));
  }

  Future<void> saveFrameIndexedSPK(
      {required int idSPK,
      required int index,
      required String custnm,
      required String tglDibuat,
      required UpdateFrameStateSingle newFrame}) async {
    final Either<LocalFailure, Unit> FOS;

    state = state.copyWith(isProcessing: true);

    this._changeFOSOSaveFrame(index: index, FOS: none());

    //
    final engineStr = newFrame.engine.getOrLeave('');
    final warnaStr = newFrame.warna.getOrLeave('');
    //
    // MANDATORY
    final frameStr = newFrame.frame.getOrCrash();

    final idUnitStr = newFrame.idUnit.getOrCrash();
    final idUnitInt = int.parse(idUnitStr);
    //
    final idKendTypeStr = newFrame.idKendType.getOrCrash();
    final idKendTypeInt = int.parse(idKendTypeStr);
    //
    final sppdcStr = newFrame.sppdc.getOrCrash();

    final frame = Frame(
        idUnit: idUnitInt,
        frame: frameStr,
        engine: engineStr,
        warna: warnaStr,
        idKendType: idKendTypeInt,
        sppdc: sppdcStr,
        custnm: custnm,
        tglDibuat: tglDibuat);

    FOS = await _repository.saveFrameIndexedSPK(
        idSPK: idSPK, index: index, newFrame: frame);

    state = state.copyWith(isProcessing: false);

    this._changeFOSOSaveFrame(index: index, FOS: optionOf(FOS));
  }

  Future<void> getFrameListOFFLINE({required int idSPK}) async {
    final Either<RemoteFailure, List<Frame>> FOS;

    state = state.copyWith(isProcessing: true, FOSOFrame: none());

    FOS = await _repository.getFrameListOFFLINE(idSPK: idSPK);

    state = state.copyWith(isProcessing: false, FOSOFrame: optionOf(FOS));
  }

  void changeFrameList(List<Frame> frameList) {
    state = state.copyWith(frameList: [...frameList]);
  }

  void changeFillEmptyFOSOSaveFrameList({required int length}) {
    Either<LocalFailure, Unit>? FOS;

    final generateList = List.generate(length, (index) => optionOf(FOS));

    state = state.copyWith(FOSOSaveFrame: generateList);
  }

  void _changeFOSOSaveFrame(
      {required Option<Either<LocalFailure, Unit>> FOS, required int index}) {
    final list = [...state.FOSOSaveFrame]; // Create a copy of the list

    final Option<Either<LocalFailure, Unit>> updatedElement = FOS;

    // Update the element at the given index
    list[index] = updatedElement;

    // Update the state with the new list
    state = state.copyWith(FOSOSaveFrame: list);
  }

  void resetFOSOSaveFrame() {
    state = state.copyWith(FOSOSaveFrame: []);
  }

  List<Option<Either<LocalFailure, Unit>>> isFOSONotOK() {
    List<Option<Either<LocalFailure, Unit>>> list = [
      ...state.FOSOSaveFrame
    ]; // Create a copy of the list

    List<Option<Either<LocalFailure, Unit>>> NotOKFOSO = [];

    list.forEach((element) {
      element.fold(() => NotOKFOSO.add(element),
          (either) => either.fold((_) => NotOKFOSO.add(element), (_) {}));
    });

    return NotOKFOSO;
  }

  bool isLastFOSO({required int index}) {
    List<Option<Either<LocalFailure, Unit>>> list = [
      ...state.FOSOSaveFrame
    ]; // Create a copy of the list

    int lastIndex = list.length - 1;

    if (index == lastIndex) return true;

    return false;
  }
}
