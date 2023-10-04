import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'clear_data_essential_state.freezed.dart';

@freezed
class ClearDataEssentialState with _$ClearDataEssentialState {
  const factory ClearDataEssentialState({
    required bool isClearing,
    required Option<Either<LocalFailure, Unit>> FOSOSPKClearDataEssential,
  }) = _ClearDataEssentialState;

  factory ClearDataEssentialState.initial() => ClearDataEssentialState(
      isClearing: false, FOSOSPKClearDataEssential: none());
}
