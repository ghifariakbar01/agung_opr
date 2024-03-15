import 'package:agung_opr/application/auto_data/auto_data_update_frame_notifier.dart';
import 'package:agung_opr/application/auto_data/auto_data_update_frame_state.dart';
import 'package:agung_opr/application/check_sheet/shared/providers/cs_providers.dart';
import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../update_spk/providers/update_spk_providers.dart';
import '../timer/auto_data_timer.dart';
import '../timer/auto_data_timer_state.dart';

// TIMER
final autoDataTimerNotifierProvider =
    StateNotifierProvider<AutoDataTimerStateNotifier, AutoDataTimerState>(
        (ref) => AutoDataTimerStateNotifier());

//  this._frameRepository,
//     this._historyRepository,
//     this._updateCSRepository,
//     this._updateFrameRepository,
//     this._updateCSUFrameRepository,

final autoDataUpdateFrameNotifierProvider = StateNotifierProvider<
        AutoDataUpdateFrameNotifier, AutoDataUpdateFrameState>(
    (ref) => AutoDataUpdateFrameNotifier(
          ref.watch(updateCSRepositoryProvider),
          ref.watch(updateSPKRepositoryProvider),
          ref.watch(updateFrameRepositoryProvider),
          // ref.watch(updateCSUFrameRepositoryProvider),
        ));
