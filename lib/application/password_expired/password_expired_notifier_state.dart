import 'package:dartz/dartz.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/local_failure.dart';

part 'password_expired_notifier_state.freezed.dart';

@freezed
class PasswordExpiredNotifierState with _$PasswordExpiredNotifierState {
  const factory PasswordExpiredNotifierState({
    required bool isExpired,
    required Option<Either<LocalFailure, Unit>> failureOrSuccessOption,
    required Option<Either<LocalFailure, Unit>> failureOrSuccessOptionClear,
  }) = _PasswordExpiredNotifierState;

  factory PasswordExpiredNotifierState.initial() =>
      PasswordExpiredNotifierState(
          isExpired: false,
          failureOrSuccessOption: none(),
          failureOrSuccessOptionClear: none());
}
