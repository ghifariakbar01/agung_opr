import 'package:agung_opr/application/check_sheet/shared/cs_jenis_offline_notifier.dart';
import 'package:agung_opr/application/check_sheet/shared/state/cs_jenis_offline_state.dart';
import 'package:agung_opr/infrastructure/cs/cs_repository.dart';
import 'package:agung_opr/infrastructure/update_cs/update_cs_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../infrastructure/cache_storage/cs/cs_item_storage.dart';
import '../../../../infrastructure/cache_storage/cs/cs_jenis_storage.dart';
import '../../../../infrastructure/cache_storage/queries/update_cs_storage.dart';
import '../../../../infrastructure/credentials_storage.dart';
import '../../../../infrastructure/cs/cs_items_repository.dart';
import '../../../../infrastructure/cs/cs_remote_service.dart';
import '../../../../infrastructure/update_cs/update_cs_remote_service.dart';
import '../../../../shared/providers.dart';
import '../../../update_cs/update_cs_notifier.dart';
import '../../../update_cs/update_cs_offline_notifier.dart';
import '../../loading/state/update_cs_offline_state.dart';
import '../../loading/state/update_cs_state.dart';
import '../cs_item_notifier.dart';
import '../cs_item_offline_notifier.dart';
import '../cs_jenis_notifier.dart';
import '../state/cs_item.dart';
import '../state/cs_item_offline_state.dart';
import '../state/cs_item_state.dart';
import '../state/cs_jenis_state.dart';

final csRemoteServiceProvider = Provider((ref) =>
    CSRemoteService(ref.watch(dioProvider), ref.watch(dioRequestProvider)));

// CS JENIS
final csJenisStorage = Provider<CredentialsStorage>(
  (ref) => CheckSheetJenisStorage(ref.watch(flutterSecureStorageProvider)),
);

final csJenisRepositoryProvider = Provider((ref) => CSRepository(
      ref.watch(csRemoteServiceProvider),
      ref.watch(csJenisStorage),
    ));

final csJenisNotifierProvider =
    StateNotifierProvider<CheckSheetJenisNotifier, CSJenisState>(
  (ref) => CheckSheetJenisNotifier(ref.watch(csJenisRepositoryProvider)),
);

final csJenisOfflineNotifierProvider =
    StateNotifierProvider<CSJenisOfflineNotifier, CSJenisOfflineState>(
        (ref) => CSJenisOfflineNotifier(ref.watch(csJenisRepositoryProvider)));

// CS ITEM
final csItemStorage = Provider<CredentialsStorage>(
  (ref) => CheckSheetItemStorage(ref.watch(flutterSecureStorageProvider)),
);

final csItemRepositoryProvider = Provider((ref) => CSItemsRepository(
      ref.watch(csRemoteServiceProvider),
      ref.watch(csItemStorage),
    ));

final csItemNotifierProvider =
    StateNotifierProvider<CheckSheetItemNotifier, CSItemState>(
  (ref) => CheckSheetItemNotifier(ref.watch(csItemRepositoryProvider)),
);

final csItemOfflineNotifierProvider =
    StateNotifierProvider<CSItemOfflineNotifier, CSItemOfflineState>(
        (ref) => CSItemOfflineNotifier(ref.watch(csItemRepositoryProvider)));

///  UPDATE CS
final updateCSStorage = Provider<CredentialsStorage>(
  (ref) => UpdateCSStorage(ref.watch(flutterSecureStorageProvider)),
);

final updateCSRemoteServiceProvider = Provider(
  (ref) => UpdateCSRemoteService(
      ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final updateCSRepositoryProvider = Provider((ref) => UpdateCSRepository(
      ref.watch(updateCSStorage),
      ref.watch(updateCSRemoteServiceProvider),
      ref.watch(
        userNotifierProvider.select((value) => value.user),
      ),
    ));

final updateCSNotifierProvider =
    StateNotifierProvider<UpdateCSNotifier, UpdateCSState>(
  (ref) => UpdateCSNotifier(
    ref.watch(updateCSRepositoryProvider),
    ref.watch(
      userNotifierProvider.select((value) => value.user),
    ),
  ),
);

final updateCSOfflineNotifierProvider =
    StateNotifierProvider<UpdateCSOfflineNotifier, UpdateCSOfflineState>(
        (ref) =>
            UpdateCSOfflineNotifier(ref.watch(updateCSRepositoryProvider)));

/* 
  FUTURE PROVIDERS
*/

final fillCSJenisFutureProvider = FutureProvider<void>((ref) async {
  final isOffline = ref.read(isOfflineStateProvider);
  if (isOffline) {
    return ref.read(csJenisNotifierProvider.notifier).getCSJenisOFFLINE();
  }

  await ref
      .read(csJenisOfflineNotifierProvider.notifier)
      .checkAndUpdateCSJenisOFFLINEStatus();

  final csJenisOfflineOrOnline = ref.read(csJenisOfflineNotifierProvider);
  await csJenisOfflineOrOnline.maybeWhen(
    hasOfflineStorage: () =>
        ref.read(csJenisNotifierProvider.notifier).getCSJenisOFFLINE(),
    orElse: () async {
      await ref.read(csJenisNotifierProvider.notifier).getCSJenis();
      await ref
          .read(csJenisOfflineNotifierProvider.notifier)
          .checkAndUpdateCSJenisOFFLINEStatus();
    },
  );
});

final fillCSItemsFutureProvider = FutureProvider<void>((ref) async {
  final isOffline = ref.read(isOfflineStateProvider);
  if (isOffline) {
    return ref.read(csItemNotifierProvider.notifier).getCSItemsOFFLINE();
  }

  await ref
      .read(csItemOfflineNotifierProvider.notifier)
      .checkAndUpdateCSItemOFFLINEStatus();

  final csItemsOfflineOrOnline = ref.read(csItemOfflineNotifierProvider);
  await csItemsOfflineOrOnline.maybeWhen(
    hasOfflineStorage: () =>
        ref.read(csItemNotifierProvider.notifier).getCSItemsOFFLINE(),
    orElse: () async {
      await ref.read(csItemNotifierProvider.notifier).getCSItems();
      await ref
          .read(csItemOfflineNotifierProvider.notifier)
          .checkAndUpdateCSItemOFFLINEStatus();
    },
  );
});

final fillCSItemsCombinedProvider = FutureProvider<void>((ref) async {
  Map<int, List<CSItem>> csItemMap = {};
  ref.read(csItemNotifierProvider.notifier).changeCSItemsByIDList(csItemMap);

  final int _csID = ref.read(csItemNotifierProvider).selectedId;

  final List<int> csId =
      ref.read(csItemNotifierProvider.notifier).getCSId(_csID);

  // fill csItemMap
  final csValuesUncombined = csId.map((id) {
    final List<CSItem> list =
        ref.read(csItemNotifierProvider.notifier).getCSItemById(id);

    csItemMap.addAll({
      id: [...list]
    });

    return list;
  }).toList();

  final List<CSItem> csValuesCombined =
      csValuesUncombined.fold([], (prev, next) => prev + next);

  /// RUN [changeFillEmptyList] TO UPDATE PLACEHOLDERS
  ref.read(updateCSNotifierProvider.notifier).changeFillEmptyList(
        isNGLength: csValuesCombined.length,
      );

  return;
});
