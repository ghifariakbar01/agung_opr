import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../spk/spk.dart';
import 'update_spk_state.dart';

part 'update_spk_state.freezed.dart';

@freezed
class UpdateSPKState with _$UpdateSPKState {
  const factory UpdateSPKState({
    required SPK selectedSPK,
    required bool isProcessing,
    required Option<Either<LocalFailure, Unit>> FOSOUpdateSPK,
  }) = _UpdateCSState;

  factory UpdateSPKState.initial() => UpdateSPKState(
        selectedSPK: SPK.initial(),
        isProcessing: false,
        FOSOUpdateSPK: none(),
      );
}
