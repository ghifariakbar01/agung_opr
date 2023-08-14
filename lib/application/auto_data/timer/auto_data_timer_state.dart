import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auto_data_timer_state.freezed.dart';

@freezed
class AutoDataTimerState with _$AutoDataTimerState {
  const factory AutoDataTimerState(
      {required int durationInSeconds,
      required bool isRunning}) = _AutoDataTimerState;

  factory AutoDataTimerState.initial() =>
      AutoDataTimerState(durationInSeconds: 10, isRunning: false);
}
