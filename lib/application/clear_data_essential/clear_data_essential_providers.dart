import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'clear_data_essential_notifier.dart';
import 'clear_data_essential_repository.dart';
import 'clear_data_essential_state.dart';

final clearDataEssentialRepositoryProvider =
    Provider((ref) => ClearDataEssentialRepository(
          spkRepository: ref.watch(spkRepositoryProvider),
          frameRepository: ref.watch(frameRepositoryProvider),
        ));

final clearDataEssentialNotifierProvider =
    StateNotifierProvider<ClearDataEssentialNotifier, ClearDataEssentialState>(
  (ref) => ClearDataEssentialNotifier(
      ref.watch(clearDataEssentialRepositoryProvider)),
);
