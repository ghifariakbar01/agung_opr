import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/local_failure.dart';
import '../../infrastructure/password_expired/password_expired_repository.dart';
import 'password_expired_notifier_state.dart';

class PasswordExpiredNotifier
    extends StateNotifier<PasswordExpiredNotifierState> {
  PasswordExpiredNotifier(
    this._repository,
  ) : super(PasswordExpiredNotifierState.initial());

  final PasswordExpiredRepository _repository;

  Future<void> savePasswordExpired() async {
    Either<LocalFailure, Unit>? saveFailureOrSuccess;

    state = state.copyWith(failureOrSuccessOption: none());

    saveFailureOrSuccess = await _repository.passwordExpired();

    state =
        state.copyWith(failureOrSuccessOption: optionOf(saveFailureOrSuccess));
  }

  Future<void> clearPasswordExpired() async {
    Either<LocalFailure, Unit>? saveFailureOrSuccess;

    state = state.copyWith(failureOrSuccessOptionClear: none());

    saveFailureOrSuccess = await _repository.clearPasswordExpired();

    state = state.copyWith(
        failureOrSuccessOptionClear: optionOf(saveFailureOrSuccess));
  }
}
