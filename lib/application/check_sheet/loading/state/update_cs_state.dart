import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'update_cs_form_state.dart';

part 'update_cs_state.freezed.dart';

@freezed
class UpdateCSState with _$UpdateCSState {
  const factory UpdateCSState({
    required int idCS,
    required int idSPK,
    required bool isProcessing,
    required bool showErrorMessages,
    required String frameName,
    required UpdateCSFormState updateCSForm,
    required Option<Either<LocalFailure, Unit>> FOSOUpdateCS,
  }) = _UpdateCSState;

  factory UpdateCSState.initial() => UpdateCSState(
        idCS: 0,
        idSPK: 0,
        isProcessing: false,
        showErrorMessages: false,
        frameName: '',
        updateCSForm: UpdateCSFormState.initial(),
        FOSOUpdateCS: none(),
      );
}
