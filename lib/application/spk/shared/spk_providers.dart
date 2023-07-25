import 'package:agung_opr/application/spk/spk_offline_notifier.dart';
import 'package:agung_opr/application/spk/spk_offline_state.dart';
import 'package:agung_opr/application/spk/spk_notifier.dart';
import 'package:agung_opr/application/spk/spk_search_notifier.dart';
import 'package:agung_opr/application/spk/spk_search_state.dart';
import 'package:agung_opr/application/spk/spk_state.dart';
import 'package:agung_opr/infrastructure/cache_storage/spk_storage.dart';
import 'package:agung_opr/infrastructure/spk/spk_remote_service.dart';
import 'package:agung_opr/infrastructure/spk/spk_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure/credentials_storage.dart';
import '../../../shared/providers.dart';

final spkStorage = Provider<CredentialsStorage>(
  (ref) => SPKStorage(ref.watch(flutterSecureStorageProvider)),
);

final spkRemoteServiceProvider = Provider(
  (ref) =>
      SPKRemoteService(ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final spkRepositoryProvider = Provider((ref) =>
    SPKRepository(ref.watch(spkRemoteServiceProvider), ref.watch(spkStorage)));

final spkNotifierProvider = StateNotifierProvider<SPKNotifier, SPKState>(
  (ref) => SPKNotifier(ref.watch(spkRepositoryProvider)),
);

final spkOfflineNotifierProvider =
    StateNotifierProvider<SPKOfflineNotifier, SPKOfflineState>(
        (ref) => SPKOfflineNotifier(ref.watch(spkRepositoryProvider)));

final spkSearchNotifierProvider =
    StateNotifierProvider<SPKSearchNotifier, SPKSearchState>(
        (ref) => SPKSearchNotifier());
