import 'package:agung_opr/application/model/model_offline_state.dart';
import 'package:agung_opr/application/model/model_search_notifier.dart';
import 'package:agung_opr/application/model/model_search_state.dart';
import 'package:agung_opr/application/model/model_state.dart';
import 'package:agung_opr/infrastructure/model/model_remote_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure/cache_storage/model_storage.dart';
import '../../../infrastructure/credentials_storage.dart';
import '../../../infrastructure/model/model_repository.dart';
import '../../../shared/providers.dart';
import '../model_notifier.dart';
import '../model_offline_notifier.dart';

final modelStorage = Provider<CredentialsStorage>(
  (ref) => ModelStorage(ref.watch(flutterSecureStorageProvider)),
);

final modelRemoteServiceProvider = Provider(
  (ref) =>
      ModelRemoteService(ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final modelRepositoryProvider = Provider((ref) => ModelRepository(
      ref.watch(modelRemoteServiceProvider),
      ref.watch(modelStorage),
    ));

final modelNotifierProvider = StateNotifierProvider<ModelNotifier, ModelState>(
  (ref) => ModelNotifier(ref.watch(modelRepositoryProvider)),
);

final modelOfflineNotifierProvider =
    StateNotifierProvider<ModelOfflineNotifier, ModelOfflineState>(
        (ref) => ModelOfflineNotifier(ref.watch(modelRepositoryProvider)));

final modelSearchNotifierProvider =
    StateNotifierProvider<ModelSearchNotifier, ModelSearchState>(
        (ref) => ModelSearchNotifier());
