import 'package:dio/dio.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../application/auth/auth_notifier.dart';
import '../application/mode/mode_state.dart';
import '../application/mode/mode_state_notifier.dart';

import '../application/routes/route_notifier.dart';
import '../application/sign_in_form/sign_in_form_notifier.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../application/sort_data/sort_data_notifier.dart';
import '../application/sort_data/sort_data_state.dart';
import '../application/spk/shared/spk_providers.dart';
import '../application/spk/spk.dart';
import '../application/update_frame/shared/update_frame_providers.dart';
import '../application/user/user_notifier.dart';
import '../application/user/user_state.dart';
import '../infrastructure/auth_interceptor.dart';
import '../infrastructure/auth_remote_service.dart';
import '../infrastructure/auth_repository.dart';
import '../infrastructure/credentials_storage.dart';
import '../infrastructure/credentials_storage/secure_credentials_storage.dart';

import '../infrastructure/sort_data/sort_data_repository.dart';
import '../utils/string_utils.dart';

// NETWORKING & ROUTER
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

// AUTH
final flutterSecureStorageProvider = Provider((ref) => FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ));

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

final authInterceptorProvider = Provider(
  (ref) => AuthInterceptor(ref),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(authRepositoryProvider)),
);

final userNotifierProvider = StateNotifierProvider<UserNotifier, UserState>(
    (ref) => UserNotifier(ref.watch(authRepositoryProvider)));

final signInFormNotifierProvider =
    StateNotifierProvider.autoDispose<SignInFormNotifier, SignInFormState>(
  (ref) => SignInFormNotifier(ref.watch(authRepositoryProvider)),
);

// MODE APLIKASI
final modeNotifierProvider =
    StateNotifierProvider<ModeNotifier, ModeState>((ref) => ModeNotifier());

// MISC
final isOfflineStateProvider = StateProvider((ref) => false);

final passwordVisibleProvider = StateProvider.autoDispose<bool>((ref) => false);

// SELECTED SPK
final selectedSPKStateProvider = StateProvider((ref) => SPK.initial());

final getBuildProvider =
    FutureProvider<PackageInfo>((ref) => PackageInfo.fromPlatform());

// SORT DATA

final sortDataRepositoryProvider = Provider((ref) => SortDataRepository(
      ref.watch(spkRepositoryProvider),
      ref.watch(frameRepositoryProvider),
    ));

final sortDataFormNotifierProvider =
    StateNotifierProvider.autoDispose<SortDataNotifier, SortDataState>(
  (ref) => SortDataNotifier(ref.watch(sortDataRepositoryProvider)),
);
