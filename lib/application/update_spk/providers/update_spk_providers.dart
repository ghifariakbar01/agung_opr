import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../infrastructure/credentials_storage.dart';

import '../../../../shared/providers.dart';
import '../../../infrastructure/cache_storage/queries/update_spk_storage.dart';

import '../../../infrastructure/update_spk/update_spk_remote_service.dart';
import '../../../infrastructure/update_spk/update_spk_repository.dart';
import '../state/update_spk_offline_state.dart';
import '../state/update_spk_state.dart';
import '../update_spk_notifier.dart';
import '../update_spk_offline_notifier.dart';

///  UPDATE SPK
final updateSPKStorage = Provider<CredentialsStorage>(
  (ref) => UpdateSPKStorage(ref.watch(flutterSecureStorageProvider)),
);

final updateSPKRemoteServiceProvider = Provider(
  (ref) => UpdateSPKRemoteService(
      ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final updateSPKRepositoryProvider = Provider((ref) => UpdateSPKRepository(
      ref.watch(updateSPKStorage),
      ref.watch(updateSPKRemoteServiceProvider),
      ref.watch(
        userNotifierProvider.select((value) => value.user),
      ),
    ));

final updateSPKNotifierProvider =
    StateNotifierProvider<UpdateSPKNotifier, UpdateSPKState>(
  (ref) => UpdateSPKNotifier(
    ref.watch(updateSPKRepositoryProvider),
  ),
);

final updateSPKOfflineNotifierProvider =
    StateNotifierProvider<UpdateSPKOfflineNotifier, UpdateSPKOfflineState>(
        (ref) =>
            UpdateSPKOfflineNotifier(ref.watch(updateSPKRepositoryProvider)));
