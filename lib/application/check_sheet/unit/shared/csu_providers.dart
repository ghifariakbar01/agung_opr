import 'package:agung_opr/application/update_csu/state/update_csu_frame_offline_state.dart';
import 'package:agung_opr/application/update_csu/update_csu_offline_notifier.dart';
import 'package:agung_opr/infrastructure/cache_storage/csu/csu_ng_by_id_frame_storage.dart';
import 'package:agung_opr/infrastructure/cache_storage/csu/csu_penyebab_storage.dart';
import 'package:agung_opr/infrastructure/csu/csu_jenis_penyebab_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../infrastructure/cache_storage/csu/csu_frame_storage.dart';
import '../../../../infrastructure/cache_storage/csu/csu_items_storage.dart';
import '../../../../infrastructure/cache_storage/csu/csu_jenis_storage.dart';
import '../../../../infrastructure/cache_storage/csu/csu_trips_frame_storage.dart';
import '../../../../infrastructure/cache_storage/queries/update_csu_storage.dart';
import '../../../../infrastructure/credentials_storage.dart';
import '../../../../infrastructure/csu/csu_items_repository.dart';
import '../../../../infrastructure/csu/csu_remote_service.dart';
import '../../../../infrastructure/csu/csu_repository.dart';
import '../../../../infrastructure/update_csu/update_csu_remote_service.dart';
import '../../../../infrastructure/update_csu/update_csu_repository.dart';
import '../../../../shared/providers.dart';
import '../../../update_csu/state/update_csu_state.dart';
import '../../../update_csu/update_csu_notifier.dart';
import '../../../update_frame/frame.dart';
import '../../csu_items_offline_notifier.dart';
import '../../csu_ng_by_id_offline_notifier.dart';

import '../../csu_result_offline_notifier.dart';
import '../../csu_trips_offline_notifier.dart';
import '../csu_item_notifier.dart';
import '../csu_jenis_penyebab_notifier.dart';
import '../csu_jenis_penyebab_offline_notifier.dart';
import '../csu_result_notifier.dart';
import '../state/csu_items/csu_items_offline_state.dart';
import '../state/csu_items/csu_items_state.dart';
import '../state/csu_jenis_penyebab/csu_jenis_penyebab_offline_state.dart';
import '../state/csu_jenis_penyebab/csu_jenis_penyebab_state.dart';
import '../state/csu_ng/csu_ng_by_id_offline_state.dart';
import '../state/csu_result_offline_state.dart';
import '../state/csu_result_state.dart';
import '../state/csu_trips_offline_state.dart';

final csuLastPageProvider = StateProvider<Frame>((ref) {
  return Frame.initial();
});

/* 
    --
    CSU RESULT ON FRAME PROVIDERS
    --
*/
final csuFrameStorage = Provider<CredentialsStorage>(
  (ref) => CSUFrameStorage(ref.watch(flutterSecureStorageProvider)),
);

final csuNGByIDFrameStorage = Provider<CredentialsStorage>(
  (ref) => CSUNGByIDFrameStorage(ref.watch(flutterSecureStorageProvider)),
);

final csuFrameRemoteServiceProvider = Provider(
  (ref) => CSUFrameRemoteService(
      ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final csuFrameRepositoryProvider = Provider((ref) => CSUFrameRepository(
      ref.watch(csuFrameStorage),
      ref.watch(csuFrameTripsStorage),
      ref.watch(csuNGByIDFrameStorage),
      ref.watch(csuFrameRemoteServiceProvider),
    ));

final csuFrameNotifierProvider =
    StateNotifierProvider<CSUFrameResultNotifier, CSUResultState>(
  (ref) => CSUFrameResultNotifier(ref.watch(csuFrameRepositoryProvider)),
);

final csuResultOfflineNotifierProvider =
    StateNotifierProvider<CSUResultOfflineNotifier, CSUResultOfflineState>(
        (ref) =>
            CSUResultOfflineNotifier(ref.watch(csuFrameRepositoryProvider)));

final csuNGByIDOfflineNotifierProvider =
    StateNotifierProvider<CSUNGByIDOfflineNotifier, CSUNGByIDfflineState>(
        (ref) =>
            CSUNGByIDOfflineNotifier(ref.watch(csuFrameRepositoryProvider)));

/* 
    --
    UPDATE CSU PROVIDERS
    --
*/
final updateCSUFrameStorage = Provider<CredentialsStorage>(
  (ref) => UpdateCSUStorage(ref.watch(flutterSecureStorageProvider)),
);

final updateCSUFrameRemoteServiceProvider = Provider(
  (ref) => UpdateCSUFrameRemoteService(
      ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final updateCSUFrameRepositoryProvider =
    Provider((ref) => UpdateCSUFrameRepository(
          ref.watch(updateCSUFrameRemoteServiceProvider),
          ref.watch(updateCSUFrameStorage),
          ref.watch(userNotifierProvider.select((value) => value.user)),
        ));

final updateCSUFrameNotifierProvider =
    StateNotifierProvider<UpdateCSUNotifier, UpdateCSUState>(
  (ref) => UpdateCSUNotifier(ref.watch(updateCSUFrameRepositoryProvider)),
);

final updateCSUFrameOfflineNotifierProvider = StateNotifierProvider<
        UpdateCSUFrameOfflineNotifier, UpdateCSUFrameOfflineState>(
    (ref) => UpdateCSUFrameOfflineNotifier(
        ref.watch(updateCSUFrameRepositoryProvider)));

/* 
    --
    CSU TRIPS PROVIDERS
    --
*/
final csuFrameTripsStorage = Provider<CredentialsStorage>(
  (ref) => CSUFTripsFrameStorage(ref.watch(flutterSecureStorageProvider)),
);

final csuTripsOfflineNotifierProvider =
    StateNotifierProvider<CSUTripsOfflineNotifier, CSUTripsOfflineState>(
        (ref) =>
            CSUTripsOfflineNotifier(ref.watch(csuFrameRepositoryProvider)));

/* 
    --
    CSU ITEMS PROVIDERS
    --
*/
final csuItemsStorage = Provider<CredentialsStorage>(
  (ref) => CSUItemsStorage(ref.watch(flutterSecureStorageProvider)),
);

final csuItemsRepositoryProvider = Provider((ref) => CSUItemsRepository(
      ref.watch(updateCSUFrameRemoteServiceProvider),
      ref.watch(csuItemsStorage),
    ));

final csuItemsFrameNotifierProvider =
    StateNotifierProvider<CSUItemsNotifier, CSUItemsState>(
  (ref) => CSUItemsNotifier(ref.watch(csuItemsRepositoryProvider)),
);

final csuItemsOfflineNotifierProvider =
    StateNotifierProvider<CSUItemsOfflineNotifier, CSUItemsOfflineState>(
        (ref) =>
            CSUItemsOfflineNotifier(ref.watch(csuItemsRepositoryProvider)));

/* 
    --
    CSU JENIS PENYEBAB PROVIDERS
    --
*/
final jenisDefectStorage = Provider<CredentialsStorage>(
  (ref) => CSUJenisStorage(ref.watch(flutterSecureStorageProvider)),
);

final penyebabDefectStorage = Provider<CredentialsStorage>(
  (ref) => CSUPenyebabStorage(ref.watch(flutterSecureStorageProvider)),
);

final jenisPenyebabRepositoryProvider = Provider((ref) =>
    CSUJenisPenyebabRepository(ref.watch(updateCSUFrameRemoteServiceProvider),
        ref.watch(jenisDefectStorage), ref.watch(penyebabDefectStorage)));

final jenisPenyebabFrameNotifierProvider =
    StateNotifierProvider<CSUJenisPenyebabNotifier, CSUJenisPenyebabState>(
  (ref) => CSUJenisPenyebabNotifier(ref.watch(jenisPenyebabRepositoryProvider)),
);

final jenisPenyebabOfflineNotifierProvider = StateNotifierProvider<
    CSUJenisPenyebabOfflineNotifier, CSUJenisPenyebabOfflineState>(
  (ref) => CSUJenisPenyebabOfflineNotifier(
      ref.watch(jenisPenyebabRepositoryProvider)),
);
