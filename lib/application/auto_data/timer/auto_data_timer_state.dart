import 'package:agung_opr/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auto_data_timer_state.freezed.dart';

@freezed
class AutoDataTimerState with _$AutoDataTimerState {
  const factory AutoDataTimerState({
    required bool isRunning,
    required int durationInSeconds,
  }) = _AutoDataTimerState;

  factory AutoDataTimerState.initial() => AutoDataTimerState(
        isRunning: false,
        durationInSeconds: Constants.dataIntervalTimerInSeconds,
      );
}
