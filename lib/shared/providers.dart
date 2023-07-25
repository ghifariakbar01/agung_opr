import 'package:dio/dio.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../application/auth/auth_notifier.dart';
import '../application/mode/mode_state.dart';
import '../application/mode/mode_state_notifier.dart';
import '../application/routes/route_notifier.dart';
import '../application/sign_in_form/sign_in_form_notifier.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../application/user/user_notifier.dart';
import '../application/user/user_state.dart';
import '../infrastructure/auth_remote_service.dart';
import '../infrastructure/auth_repository.dart';
import '../infrastructure/credentials_storage.dart';
import '../infrastructure/credentials_storage/secure_credentials_storage.dart';

import '../utils/string_utils.dart';

// Networking & Router

final dioProvider = Provider((ref) => Dio());

final dioRequestProvider = Provider<Map<String, String>>(
  (ref) =>
      {"server": "gs_12", "kode": "${StringUtils.formatDate(DateTime.now())}"},
);

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    redirect: router.redirectLogic,
    refreshListenable: router,
    routes: router.routes,
  );
});

// Auth

final flutterSecureStorageProvider = Provider(
  (ref) => const FlutterSecureStorage(),
);

final credentialsStorageProvider = Provider<CredentialsStorage>(
  (ref) => SecureCredentialsStorage(ref.watch(flutterSecureStorageProvider)),
);

final authRemoteServiceProvider = Provider(
  (ref) =>
      AuthRemoteService(ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final authRepositoryProvider = Provider((ref) => AuthRepository(
      ref.watch(credentialsStorageProvider),
      ref.watch(authRemoteServiceProvider),
    ));

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(authRepositoryProvider)),
);

final userNotifierProvider = StateNotifierProvider<UserNotifier, UserState>(
    (ref) => UserNotifier(ref.watch(authRepositoryProvider)));

final signInFormNotifierProvider =
    StateNotifierProvider.autoDispose<SignInFormNotifier, SignInFormState>(
  (ref) => SignInFormNotifier(ref.watch(authRepositoryProvider)),
);

// Mode Aplikasi

final modeNotifierProvider =
    StateNotifierProvider<ModeNotifier, ModeState>((ref) => ModeNotifier());

// Misc

final isOfflineProvider = StateProvider((ref) => false);

final passwordVisibleProvider = StateProvider.autoDispose<bool>((ref) => false);
