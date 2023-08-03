import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auto_data_timer_state.dart';

class AutoDataTimerStateNotifier extends StateNotifier<AutoDataTimerState> {
  Timer? _timer;

  AutoDataTimerStateNotifier() : super(AutoDataTimerState.initial());

  Future<void> startTimer(int duration,
      {required Future<void> Function() onTimerRanOut}) async {
    state = state.copyWith(durationInSeconds: duration, isRunning: true);

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (state.durationInSeconds > 0) {
        state = state.copyWith(durationInSeconds: state.durationInSeconds - 1);
        log('DURATION: ${state.durationInSeconds}');
      } else {
        _resetTimer();
        await onTimerRanOut();
        startTimer(10, onTimerRanOut: onTimerRanOut);
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    state = state.copyWith(durationInSeconds: 0, isRunning: false);
  }
}
