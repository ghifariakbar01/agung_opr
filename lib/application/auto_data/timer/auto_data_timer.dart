import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auto_data_timer_state.dart';

class AutoDataTimerStateNotifier extends StateNotifier<AutoDataTimerState> {
  Timer? _timer;

  AutoDataTimerStateNotifier() : super(AutoDataTimerState.initial());

  Future<void> startTimer(
    int duration, {
    required Future<void> Function() getSavedUpdateSPK,
    required Future<void> Function() getSavedUpdateFrame,
    required Future<void> Function() getSavedUpdateCSFrame,
    required Future<void> Function() getSavedUpdateCSUFrame,
  }) async {
    state = state.copyWith(durationInSeconds: duration, isRunning: true);

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (state.durationInSeconds > 0) {
        state = state.copyWith(durationInSeconds: state.durationInSeconds - 1);
      } else {
        _resetTimer();
        //
        await getSavedUpdateSPK();
        await getSavedUpdateFrame();
        await getSavedUpdateCSFrame();
        await getSavedUpdateCSUFrame();
        //
        await startTimer(
          duration,
          getSavedUpdateSPK: getSavedUpdateSPK,
          getSavedUpdateFrame: getSavedUpdateFrame,
          getSavedUpdateCSFrame: getSavedUpdateCSFrame,
          getSavedUpdateCSUFrame: getSavedUpdateCSUFrame,
        );
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    state = state.copyWith(durationInSeconds: 0, isRunning: false);
  }
}
