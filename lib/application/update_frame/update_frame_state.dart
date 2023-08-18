import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'update_frame_single_state.dart';

part 'update_frame_state.freezed.dart';

@freezed
class UpdateFrameState with _$UpdateFrameState {
  const factory UpdateFrameState({
    required int idSPK,
    required int index,
    required bool isProcessing,

    /// Hack for model value to change after tapping model
    required List<TextEditingController> modelTextController,
    required List<TextEditingController> frameTextController,
    required List<TextEditingController> sppdcTextController,
    required List<UpdateFrameStateSingle> updateFrameList,
    required List<Option<Either<LocalFailure, Unit>>> FOSOUpdateFrame,
  }) = _UpdateFrameState;

  factory UpdateFrameState.initial() => UpdateFrameState(
      idSPK: 0,
      index: 0,
      isProcessing: false,
      modelTextController: [],
      frameTextController: [],
      sppdcTextController: [],
      updateFrameList: [],
      FOSOUpdateFrame: []);
}
