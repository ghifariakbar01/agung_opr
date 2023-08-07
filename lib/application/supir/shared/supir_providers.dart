import 'package:agung_opr/application/supir/supir_offline_notifier.dart';
import 'package:agung_opr/application/supir/supir_offline_state.dart';
import 'package:agung_opr/application/supir/supir_search_state.dart';
import 'package:agung_opr/infrastructure/Supir/Supir_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure/cache_storage/supir_storage.dart';
import '../../../infrastructure/credentials_storage.dart';
import '../../../infrastructure/supir/supir_remote_service.dart';
import '../../../shared/providers.dart';
import '../supir_notifier.dart';
import '../supir_search_notifier.dart';
import '../supir_state.dart';

final supirStorage = Provider<CredentialsStorage>(
  (ref) => SupirStorage(ref.watch(flutterSecureStorageProvider)),
);

final supirRemoteServiceProvider = Provider(
  (ref) =>
      SupirRemoteService(ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final supirRepositoryProvider = Provider((ref) => SupirRepository(
    ref.watch(supirRemoteServiceProvider), ref.watch(supirStorage)));

final supirNotifierProvider = StateNotifierProvider<SupirNotifier, SupirState>(
  (ref) => SupirNotifier(ref.watch(supirRepositoryProvider)),
);

final supirOfflineNotifierProvider =
    StateNotifierProvider<SupirOfflineNotifier, SupirOfflineState>(
        (ref) => SupirOfflineNotifier(ref.watch(supirRepositoryProvider)));

final supirSearchNotifierProvider =
    StateNotifierProvider<SupirSearchNotifier, SupirSearchState>(
        (ref) => SupirSearchNotifier());
