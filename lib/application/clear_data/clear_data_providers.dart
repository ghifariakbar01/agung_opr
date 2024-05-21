import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'clear_data_notifier.dart';
import 'clear_data_repository.dart';
import 'clear_data_state.dart';

final clearDataRepositoryProvider = Provider((ref) => ClearDataRepository(
      spkRepository: ref.watch(spkRepositoryProvider),
      frameRepository: ref.watch(frameRepositoryProvider),
    ));

final clearDataNotifierProvider =
    StateNotifierProvider<ClearDataNotifier, ClearDataState>(
  (ref) => ClearDataNotifier(ref.watch(clearDataRepositoryProvider)),
);
