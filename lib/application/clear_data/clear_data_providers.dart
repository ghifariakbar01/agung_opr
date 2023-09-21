import 'package:agung_opr/application/check_sheet/shared/providers/cs_providers.dart';
import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/customer/shared/customer_providers.dart';
import 'package:agung_opr/application/gate/providers/gate_providers.dart';
import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'clear_data_notifier.dart';
import 'clear_data_repository.dart';
import 'clear_data_state.dart';

final clearDataRepositoryProvider = Provider((ref) => ClearDataRepository(
    spkRepository: ref.watch(spkRepositoryProvider),
    gateRepository: ref.watch(gateRepositoryProvider),
    csRepository: ref.watch(csJenisRepositoryProvider),
    frameRepository: ref.watch(frameRepositoryProvider),
    csItemsRepository: ref.watch(csItemRepositoryProvider),
    csuFrameRepository: ref.watch(csuFrameRepositoryProvider),
    csuItemsRepository: ref.watch(csuItemsRepositoryProvider),
    customerRepository: ref.watch(customerRepositoryProvider),
    csuJenisPenyebabRepository: ref.watch(jenisPenyebabRepositoryProvider)));

final clearDataNotifierProvider =
    StateNotifierProvider<ClearDataNotifier, ClearDataState>(
  (ref) => ClearDataNotifier(ref.watch(clearDataRepositoryProvider)),
);
