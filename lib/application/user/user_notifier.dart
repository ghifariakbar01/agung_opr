import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/auth_failure.dart';
import '../../domain/user_failure.dart';
import '../../infrastructure/auth_repository.dart';
import 'user_model.dart';
import 'user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(this._repository) : super(UserState.initial());

  final AuthRepository _repository;

  Future<String> getUserString() => _repository.getUserString();

  Future<void> getUser() async {
    Either<UserFailure, String?> failureOrSuccess;

    state = state.copyWith(
      isGetting: true,
      failureOrSuccessOption: none(),
    );

    failureOrSuccess = await _repository.getSignedInUser();

    state = state.copyWith(
      isGetting: false,
      failureOrSuccessOption: optionOf(failureOrSuccess),
    );
  }

  Either<UserFailure, UserModelWithPassword> parseUser(String? user) {
    try {
      return right(UserModelWithPassword.fromJson(jsonDecode(user ?? '')));
    } on FormatException {
      return left(UserFailure.errorParsing('Error while parse'));
    }
  }

  void setUser(UserModelWithPassword user) {
    state = state.copyWith(user: user);
  }

  void setUserInitial() {
    state = state.copyWith(user: UserModelWithPassword.initial());
  }

  Future<void> onUserParsed({
    required UserModelWithPassword user,
    required Function checkAndUpdateStatus,
    required Function initializeDioRequest,
    required Function initializeAndCheckData,
    required Function sortDataFrameInSPK,
  }) async {
    setUser(user);

    if (user.jobdesk == null) {
      await logout();
    }

    await checkAndUpdateStatus();
    await initializeDioRequest();
    await initializeAndCheckData();

    await sortDataFrameInSPK();
  }

  Future<void> logout() async {
    Either<AuthFailure, Unit?> failureOrSuccess;

    state =
        state.copyWith(isGetting: true, failureOrSuccessOptionUpdate: none());

    failureOrSuccess = await _repository.clearCredentialsStorage();

    state = state.copyWith(
        isGetting: false,
        failureOrSuccessOptionUpdate: optionOf(failureOrSuccess));
  }
}
