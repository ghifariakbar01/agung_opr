import 'package:dartz/dartz.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/remote_failure.dart';
import 'history.dart';

part 'history_state.freezed.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState({
    required bool isGetting,
    required List<History> historyList,
    required Option<Either<RemoteFailure, List<History>?>> FOSOHistory,
  }) = _UserState;

  factory HistoryState.initial() => HistoryState(
        historyList: [],
        isGetting: false,
        FOSOHistory: none(),
      );
}
