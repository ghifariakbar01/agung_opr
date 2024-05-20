import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/validator.dart';
import '../../domain/auth_failure.dart';
import '../../domain/value_objects_copy.dart';
import '../../infrastructure/auth_repository.dart';
import '../remember_me/remember_me_state.dart';

part 'sign_in_form_notifier.freezed.dart';
part 'sign_in_form_state.dart';

class SignInFormNotifier extends StateNotifier<SignInFormState> {
  SignInFormNotifier(this._repository) : super(SignInFormState.initial());

  final AuthRepository _repository;

  void changeAllData({
    required String idKaryawanStr,
    required String userStr,
    required String passwordStr,
    required String jobdeskStr,
  }) {
    state = state.copyWith(
      userId: UserId(userStr),
      jobdesk: Jobdesk(jobdeskStr),
      password: Password(passwordStr),
      idKaryawan: IdKaryawan(idKaryawanStr),
      failureOrSuccessOption: none(),
    );
  }

  void changeIdKaryawan(String idKaryawanStr) {
    state = state.copyWith(
      idKaryawan: IdKaryawan(idKaryawanStr),
      failureOrSuccessOption: none(),
    );
  }

  void changeEmail(String emailStr) {
    state = state.copyWith(
      email: Email(emailStr),
      failureOrSuccessOption: none(),
    );
  }

  void changeUserId(String userStr) {
    state = state.copyWith(
      userId: UserId(userStr),
      failureOrSuccessOption: none(),
    );
  }

  void changePassword(String passwordStr) {
    state = state.copyWith(
      password: Password(passwordStr),
      failureOrSuccessOption: none(),
    );
  }

  void changeJobdesk(String jobdeskStr) {
    state = state.copyWith(
      jobdesk: Jobdesk(jobdeskStr),
      failureOrSuccessOption: none(),
    );
  }

  Future<void> initializeAndRedirect({
    required Function startAutoData,
    required Function redirect,
  }) async {
    await startAutoData();
    await redirect();
  }

  Future<void> signInAndRemember({
    required Function signIn,
    required Function remember,
  }) async {
    await signIn();
    await remember();
  }

  void changeRemember(bool isChecked) {
    state = state.copyWith(isChecked: isChecked);
  }

  Future<void> rememberInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'remember_me',
        jsonEncode(RememberMeState(
          nama: state.userId.getOrLeave(''),
          nik: state.idKaryawan.getOrLeave(''),
          jobdesk: state.jobdesk.getOrLeave(''),
          password: state.password.getOrLeave(''),
        )));
  }

  Future<void> signInWithUserIdEmailAndPassword() async {
    Either<AuthFailure, Unit>? signInFailureOrSuccess;

    if (isValid) {
      state = state.copyWith(
        isSubmitting: true,
        failureOrSuccessOption: none(),
      );

      signInFailureOrSuccess = await _repository.signInWithUsernameAndPassword(
        jobdesk: state.jobdesk,
        userId: state.userId,
        password: state.password,
      );
    }

    state = state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      failureOrSuccessOption: optionOf(signInFailureOrSuccess),
    );
  }

  bool get isValid {
    final values = [
      state.userId,
      state.jobdesk,
      state.password,
    ];

    return Validator.validate(values);
  }
}
