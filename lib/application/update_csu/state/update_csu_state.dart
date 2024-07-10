import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'update_csu_form_state.dart';

part 'update_csu_state.freezed.dart';

@freezed
class UpdateCSUState with _$UpdateCSUState {
  const factory UpdateCSUState({
    required int idCS,
    required int idUnit,
    required bool isProcessing,
    required bool showErrorMessages,
    required String frameName,
    required UpdateCSUFrameStateSingle updateFrameList,
    
    required Option<Either<LocalFailure, Unit>> FOSOUpdateCSU,
  }) = _UpdateCSUState;

  factory UpdateCSUState.initial() => UpdateCSUState(
        idCS: 0,
        idUnit: 0,
        isProcessing: false,
        showErrorMessages: false,
        frameName: '',
        FOSOUpdateCSU: none(),
        updateFrameList: UpdateCSUFrameStateSingle.initial(),
      );
}
