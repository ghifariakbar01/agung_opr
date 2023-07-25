import 'package:agung_opr/application/model/model_search_notifier.dart';
import 'package:agung_opr/application/model/model_search_state.dart';
import 'package:agung_opr/application/update_frame/frame_notifier.dart';
import 'package:agung_opr/application/update_frame/frame_offline_state.dart';
import 'package:agung_opr/application/update_frame/frame_state.dart';
import 'package:agung_opr/infrastructure/frame/frame_remote_service%20copy.dart';
import 'package:agung_opr/infrastructure/frame/frame_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure/cache_storage/update_frame_storage.dart';
import '../../../infrastructure/credentials_storage.dart';
import '../../../shared/providers.dart';
import '../frame_offline_notifier.dart';

final frameStorage = Provider<CredentialsStorage>(
  (ref) => UpdateFrameStorage(ref.watch(flutterSecureStorageProvider)),
);

final frameRemoteServiceProvider = Provider(
  (ref) =>
      FrameRemoteService(ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final frameRepositoryProvider = Provider((ref) => FrameRepository(
    ref.watch(frameRemoteServiceProvider), ref.watch(frameStorage)));

final frameNotifierProvider = StateNotifierProvider<FrameNotifier, FrameState>(
  (ref) => FrameNotifier(ref.watch(frameRepositoryProvider)),
);

final modelOfflineNotifierProvider =
    StateNotifierProvider<FrameOfflineNotifier, FrameOfflineState>(
        (ref) => FrameOfflineNotifier(ref.watch(frameRepositoryProvider)));

final modelSearchNotifierProvider =
    StateNotifierProvider<ModelSearchNotifier, ModelSearchState>(
        (ref) => ModelSearchNotifier());
