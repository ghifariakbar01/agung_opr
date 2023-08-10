import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/remote_failure.dart';
import '../../check_sheet/unit/state/csu_items.dart';
import 'update_csu_form_state.dart';

part 'update_csu_state.freezed.dart';

@freezed
class UpdateCSUState with _$UpdateCSUState {
  const factory UpdateCSUState({
    required int idUnit,
    required bool isProcessing,

    /// Hack for form value to change after tapping form
    required UpdateCSUFrameStateSingle updateFrameList,
    required List<CSUItems> csuItems,
    required Option<Either<LocalFailure, Unit>> FOSOUpdateCSU,
    required Option<Either<RemoteFailure, List<CSUItems>>> FOSOUpdateCSUItems,
  }) = _UpdateCSUState;

  factory UpdateCSUState.initial() => UpdateCSUState(
        idUnit: 0,
        isProcessing: false,
        updateFrameList: UpdateCSUFrameStateSingle.initial(),
        csuItems: [],
        FOSOUpdateCSU: none(),
        FOSOUpdateCSUItems: none(),
      );
}
