import 'package:agung_opr/shared/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure/cache_storage/history_storage.dart';
import '../../../infrastructure/credentials_storage.dart';
import '../../../infrastructure/history/history_remote_service.dart';
import '../../../infrastructure/history/history_repository.dart';
import '../history_notifier.dart';
import '../history_state.dart';

///  HISTORY
final historyStorage = Provider<CredentialsStorage>(
  (ref) => HistoryStorage(ref.watch(flutterSecureStorageProvider)),
);

final historyRemoteServiceProvider = Provider(
  (ref) => HistoryRemoteService(
      ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final historyRepositoryProvider = Provider((ref) => HistoryRepository(
      ref.watch(historyRemoteServiceProvider),
      ref.watch(userNotifierProvider.select((value) => value.user)),
      ref.watch(historyStorage),
    ));

final historyNotifierProvider =
    StateNotifierProvider<HistoryNotifier, HistoryState>(
  (ref) => HistoryNotifier(ref.watch(historyRepositoryProvider)),
);

// final historyOfflineNotifierProvider =
//     StateNotifierProvider<historyOfflineNotifier, historyOfflineState>(
//         (ref) => historyOfflineNotifier(ref.watch(historyRepositoryProvider)));
