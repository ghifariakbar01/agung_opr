import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/auth_failure.dart';
import '../../domain/user_failure.dart';
import '../../domain/value_objects_copy.dart';
import '../../infrastructure/auth_repository.dart';
import '../spk/spk.dart';
import 'user_model.dart';
import 'user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(this._repository) : super(UserState.initial());

  final AuthRepository _repository;

  Future<String> getUserString() => _repository.getUserString();

  Future<void> getUser() async {
    Either<UserFailure, String?> failureOrSuccess;

    state = state.copyWith(isGetting: true, failureOrSuccessOption: none());

    failureOrSuccess = await _repository.getSignedInUser();

    state = state.copyWith(
        isGetting: false, failureOrSuccessOption: optionOf(failureOrSuccess));
  }

  Future<void> saveUserAfterUpdate({
    required IdKaryawan idKaryawan,
    required UserId userId,
    required Password password,
  }) async {
    Either<AuthFailure, Unit?> failureOrSuccess;

    state =
        state.copyWith(isGetting: true, failureOrSuccessOptionUpdate: none());

    failureOrSuccess = await _repository.saveUserAfterUpdate(
        idKaryawan: idKaryawan, password: password, userId: userId);

    state = state.copyWith(
        isGetting: false,
        failureOrSuccessOptionUpdate: optionOf(failureOrSuccess));
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
    required Function initializeDioRequest,
    required Function initializeAndCheckData,
    required Function initializeAutoData,
    required Function checkAndUpdateStatus,
    required Function redirectIfFromSPK,
  }) async {
    setUser(user);
    await initializeDioRequest();
    await initializeAndCheckData();
    await initializeAutoData();
    await checkAndUpdateStatus();
    await redirectIfFromSPK();
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
