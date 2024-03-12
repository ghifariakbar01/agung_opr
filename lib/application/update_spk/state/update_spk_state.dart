import 'package:agung_opr/domain/local_failure.dart';
import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../spk/spk.dart';

part 'update_spk_state.freezed.dart';

@freezed
class UpdateSPKState with _$UpdateSPKState {
  const factory UpdateSPKState({
    required SPK selectedSPK,
    //
    required Keterangan keterangan,
    //
    required bool isProcessing,
    required Option<Either<LocalFailure, Unit>> FOSOUpdateSPK,
  }) = _UpdateCSState;

  factory UpdateSPKState.initial() => UpdateSPKState(
        selectedSPK: SPK.initial(),
        keterangan: Keterangan(''),
        isProcessing: false,
        FOSOUpdateSPK: none(),
      );
}
