import 'package:agung_opr/application/check_sheet/unit/csu_result_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../infrastructure/cache_storage/csu_frame_storage.dart';
import '../../../../infrastructure/cache_storage/csu_trips_frame_storage.dart';
import '../../../../infrastructure/credentials_storage.dart';
import '../../../../infrastructure/csu/csu_remote_service.dart';
import '../../../../infrastructure/csu/csu_repository.dart';
import '../../../../shared/providers.dart';
import '../../../update_frame/shared/update_frame_providers.dart';
import '../../../update_frame/update_frame_notifier.dart';
import '../../../update_frame/update_frame_state.dart';
import '../state/csu_result_state.dart';

// import '../../../infrastructure/cache_storage/update_frame_storage.dart';
// import '../../../infrastructure/credentials_storage.dart';
// import '../../../shared/providers.dart';
// import '../frame_offline_notifier.dart';
// import '../update_frame_notifier.dart';
// import '../update_frame_offline_notifier.dart';
// import '../update_frame_offline_state.dart';

final csuFrameStorage = Provider<CredentialsStorage>(
  (ref) => CSUFrameStorage(ref.watch(flutterSecureStorageProvider)),
);

final csuFrameTripsStorage = Provider<CredentialsStorage>(
  (ref) => CSUFTripsrameStorage(ref.watch(flutterSecureStorageProvider)),
);

final csuFrameRemoteServiceProvider = Provider(
  (ref) => CSUFrameRemoteService(
      ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final csuFrameRepositoryProvider = Provider((ref) => CSUFrameRepository(
    ref.watch(csuFrameRemoteServiceProvider),
    ref.watch(csuFrameStorage),
    ref.watch(csuFrameTripsStorage)));

final csuFrameNotifierProvider =
    StateNotifierProvider<CSUFrameResultNotifier, CSUResultState>(
  (ref) => CSUFrameResultNotifier(ref.watch(csuFrameRepositoryProvider)),
);

// final updateFrameOfflineNotifierProvider = StateNotifierProvider<
//         UpdateFrameOfflineNotifier, UpdateFrameOfflineState>(
//     (ref) =>
//         UpdateFrameOfflineNotifier(ref.watch(updateFrameRepositoryProvider)));
