import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/remote_failure.dart';
import '../../infrastructure/history/history_repository.dart';

import 'history.dart';
import 'history_state.dart';

class HistoryNotifier extends StateNotifier<HistoryState> {
  HistoryNotifier(this._repository) : super(HistoryState.initial());

  final HistoryRepository _repository;

  changeHistory(History history) => state = state.copyWith(history: history);

  Future<void> getHistory(
      {required DateTime startDate, required DateTime endDate}) async {
    Either<RemoteFailure, History?> FOSOHistory;

    state = state.copyWith(isGetting: true, FOSOHistory: none());

    FOSOHistory = await _repository.getHistories();

    state =
        state.copyWith(isGetting: false, FOSOHistory: optionOf(FOSOHistory));
  }
}
