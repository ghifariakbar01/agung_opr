import 'package:agung_opr/application/update_frame/frame.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/remote_failure.dart';

part 'frame_state.freezed.dart';

@freezed
class FrameState with _$FrameState {
  const factory FrameState({
    required List<Frame> frameList,
    required int selectedId,
    required bool isProcessing,
    required Option<Either<RemoteFailure, List<Frame>>> FOSOFrame,
    required Option<Either<LocalFailure, Unit>> FOSOSaveFrame,
  }) = _FrameState;

  factory FrameState.initial() => FrameState(
      frameList: [],
      selectedId: 0,
      isProcessing: false,
      FOSOFrame: none(),
      FOSOSaveFrame: none());
}
