import 'package:agung_opr/application/update_frame/frame_notifier.dart';
import 'package:agung_opr/application/update_frame/frame_offline_state.dart';
import 'package:agung_opr/application/update_frame/frame_state.dart';
import 'package:agung_opr/application/update_frame/update_frame_state.dart';
import 'package:agung_opr/infrastructure/frame/frame_remote_service.dart';
import 'package:agung_opr/infrastructure/frame/frame_repository.dart';
import 'package:agung_opr/infrastructure/cache_storage/queries/update_frame_storage.dart';
import 'package:agung_opr/infrastructure/update_frame/update_frame_remote_service.dart';
import 'package:agung_opr/infrastructure/update_frame/update_frame_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure/cache_storage/frame_storage.dart';
import '../../../infrastructure/credentials_storage.dart';
import '../../../shared/providers.dart';
import '../frame_offline_notifier.dart';
import '../update_frame_notifier.dart';
import '../update_frame_offline_notifier.dart';
import '../update_frame_offline_state.dart';

// UPDATE FRAME

final updateFrameStorage = Provider<CredentialsStorage>(
  (ref) => FrameSPKStorage(ref.watch(flutterSecureStorageProvider)),
);

final updateFrameRemoteServiceProvider = Provider(
  (ref) => UpdateFrameRemoteService(
      ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final updateFrameRepositoryProvider = Provider((ref) => UpdateFrameRepository(
    ref.watch(updateFrameRemoteServiceProvider),
    ref.watch(updateFrameStorage)));

final updateFrameNotifierProvider =
    StateNotifierProvider<UpdateFrameNotifier, UpdateFrameState>(
  (ref) => UpdateFrameNotifier(ref.watch(updateFrameRepositoryProvider)),
);

final updateFrameOfflineNotifierProvider = StateNotifierProvider<
        UpdateFrameOfflineNotifier, UpdateFrameOfflineState>(
    (ref) =>
        UpdateFrameOfflineNotifier(ref.watch(updateFrameRepositoryProvider)));

// FRAME

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

final frameOfflineNotifierProvider =
    StateNotifierProvider<FrameOfflineNotifier, FrameOfflineState>(
        (ref) => FrameOfflineNotifier(ref.watch(frameRepositoryProvider)));
