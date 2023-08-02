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

  Future<void> getFrameList({required int idSPK}) async {
    final Either<RemoteFailure, List<Frame>> FOS;

    state = state.copyWith(isProcessing: true, FOSOFrame: none());

    FOS = await _repository.getFrameList(idSPK: idSPK);

    state = state.copyWith(isProcessing: false, FOSOFrame: optionOf(FOS));
  }

  Future<void> saveFrameIndexedSPK(
      {required int idSPK,
      required int index,
      required UpdateFrameStateSingle newFrame}) async {
    final Either<LocalFailure, Unit> FOS;

    state = state.copyWith(isProcessing: true, FOSOSaveFrame: none());

    final idUnitStr = newFrame.idUnit.getOrCrash();
    final idUnitInt = int.parse(idUnitStr);
    final idKendTypeStr = newFrame.idKendType.getOrCrash();
    final idKendTypeInt = int.parse(idKendTypeStr);
    final frameStr = newFrame.frame.getOrCrash();
    final engineStr = newFrame.engine.getOrCrash();
    final warnaStr = newFrame.warna.getOrCrash();
    final noReffStr = newFrame.noReff.getOrCrash();

    final frame = Frame(
        idUnit: idUnitInt,
        frame: frameStr,
        engine: engineStr,
        warna: warnaStr,
        noReffExp: noReffStr,
        idKendType: idKendTypeInt);

    FOS = await _repository.saveFrameIndexedSPK(
        idSPK: idSPK, index: index, newFrame: frame);

    state = state.copyWith(isProcessing: false, FOSOSaveFrame: optionOf(FOS));
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
}
