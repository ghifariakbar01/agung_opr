import 'package:agung_opr/application/gate/csu_gate_state.dart';
import 'package:agung_opr/application/gate/gate_notifier.dart';
import 'package:agung_opr/infrastructure/cache_storage/gate_storage.dart';
import 'package:agung_opr/infrastructure/gate/gate_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure/credentials_storage.dart';
import '../../../infrastructure/gate/gate_remote_service.dart';
import '../../../shared/providers.dart';
import '../gate_offline_notifier.dart';
import '../gate_offline_state.dart';
import '../gate_search_notifier.dart';
import '../gate_search_state.dart';

final gateStorage = Provider<CredentialsStorage>(
  (ref) => GateStorage(ref.watch(flutterSecureStorageProvider)),
);

final gateRemoteServiceProvider = Provider(
  (ref) =>
      GateRemoteService(ref.watch(dioProvider), ref.watch(dioRequestProvider)),
);

final gateRepositoryProvider = Provider((ref) => GateRepository(
    ref.watch(gateRemoteServiceProvider), ref.watch(gateStorage)));

final gateNotifierProvider = StateNotifierProvider<GateNotifier, CSUGateState>(
  (ref) => GateNotifier(ref.watch(gateRepositoryProvider)),
);

final gateOfflineNotifierProvider =
    StateNotifierProvider<GateOfflineNotifier, GateOfflineState>(
        (ref) => GateOfflineNotifier(ref.watch(gateRepositoryProvider)));

final gateSearchNotifierProvider =
    StateNotifierProvider<GateSearchNotifier, GateSearchState>(
        (ref) => GateSearchNotifier());
