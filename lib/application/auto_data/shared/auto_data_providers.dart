import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../check_sheet/shared/providers/cs_providers.dart';
import '../../check_sheet/unit/shared/csu_providers.dart';
import '../../update_frame/shared/update_frame_providers.dart';
import '../../update_spk/providers/update_spk_providers.dart';
import '../auto_data_update_frame_notifier.dart';
import '../auto_data_update_frame_state.dart';
import '../timer/auto_data_timer.dart';
import '../timer/auto_data_timer_state.dart';

final autoDataTimerNotifierProvider =
    StateNotifierProvider<AutoDataTimerStateNotifier, AutoDataTimerState>(
        (ref) => AutoDataTimerStateNotifier());

final autoDataUpdateFrameNotifierProvider = StateNotifierProvider<
        AutoDataUpdateFrameNotifier, AutoDataUpdateFrameState>(
    (ref) => AutoDataUpdateFrameNotifier(
          ref.watch(updateCSRepositoryProvider),
          ref.watch(updateSPKRepositoryProvider),
          ref.watch(updateFrameRepositoryProvider),
          ref.watch(updateCSUFrameRepositoryProvider),
        ));
