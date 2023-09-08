import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/auth_failure.dart';

import '../../domain/local_failure.dart';
import '../../infrastructure/auth_repository.dart';
import '../../shared/providers.dart';
import '../user/user_notifier.dart';

part 'auth_notifier.freezed.dart';
part 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._repository, this._ref) : super(const AuthState.initial()) {
    // PASSWORD EXPIRED
    _ref.listen<Option<Either<LocalFailure, Unit>>>(
        passwordExpiredNotifierProvider
            .select((value) => value.failureOrSuccessOption),
        (__, failureOrSuccess) => failureOrSuccess.fold(() {}, (_) async {
              UserNotifier userNotifier =
                  _ref.read(userNotifierProvider.notifier);

              userNotifier.setUserInitial();
              await userNotifier.logout();
              await checkAndUpdateAuthStatus();
            }));
  }

  final AuthRepository _repository;
  final Ref _ref;

  Future<void> checkAndUpdateAuthStatus() async {
    final isSignedIn = await _repository.isSignedIn();

    if (isSignedIn) {
      state = const AuthState.authenticated();
    } else {
      state = const AuthState.unauthenticated();
    }
  }
}
