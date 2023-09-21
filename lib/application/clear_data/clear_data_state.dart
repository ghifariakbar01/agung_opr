import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'clear_data_state.freezed.dart';

@freezed
class ClearDataState with _$ClearDataState {
  const factory ClearDataState({
    required bool isClearing,
    required Option<Either<LocalFailure, Unit>> FOSOSPKClearData,
  }) = _ClearDataState;

  factory ClearDataState.initial() =>
      ClearDataState(isClearing: false, FOSOSPKClearData: none());
}
