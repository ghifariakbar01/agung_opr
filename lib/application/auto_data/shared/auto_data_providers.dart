import 'package:agung_opr/application/auto_data/auto_data_notifier.dart';
import 'package:agung_opr/application/auto_data/auto_data_state.dart';
import 'package:agung_opr/application/auto_data/auto_data_update_frame_notifier.dart';
import 'package:agung_opr/application/auto_data/auto_data_update_frame_state.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../timer/auto_data_timer.dart';
import '../timer/auto_data_timer_state.dart';

// TIMER
final autoDataTimerNotifierProvider =
    StateNotifierProvider<AutoDataTimerStateNotifier, AutoDataTimerState>(
        (ref) => AutoDataTimerStateNotifier());

final autoDataUpdateFrameNotifierProvider = StateNotifierProvider<
        AutoDataUpdateFrameNotifier, AutoDataUpdateFrameState>(
    (ref) => AutoDataUpdateFrameNotifier(
        ref.watch(updateFrameRepositoryProvider),
        ref.watch(frameRepositoryProvider)));

final autoDataNotifierProvider =
    StateNotifierProvider<AutoDataNotifier, AutoDataState>(
        (ref) => AutoDataNotifier());
