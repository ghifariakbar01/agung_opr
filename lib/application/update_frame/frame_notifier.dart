import 'package:agung_opr/application/update_frame/frame.dart';
import 'package:agung_opr/application/update_frame/frame_state.dart';
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
