import 'package:dartz/dartz.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/remote_failure.dart';
import 'history.dart';

part 'history_state.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState({
    required bool isGetting,
    required History history,
    required Option<Either<RemoteFailure, History?>> FOSOHistory,
  }) = _UserState;

  factory HistoryState.initial() => HistoryState(
        isGetting: false,
        FOSOHistory: none(),
        history: History.initial(),
      );
}
