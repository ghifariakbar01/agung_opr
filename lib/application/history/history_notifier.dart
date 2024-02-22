import 'package:agung_opr/utils/string_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/remote_failure.dart';
import '../../infrastructure/history/history_repository.dart';
import 'history.dart';
import 'history_state.dart';

class HistoryNotifier extends StateNotifier<HistoryState> {
  HistoryNotifier(this._repository) : super(HistoryState.initial());

  final HistoryRepository _repository;

  Future<void> getHistory(
      {required DateTime startDate, required DateTime endDate}) async {
    Either<RemoteFailure, List<History>?> FOSOHistory;

    state = state.copyWith(isGetting: true, FOSOHistory: none());

    FOSOHistory = await _repository.getHistories();

    state =
        state.copyWith(isGetting: false, FOSOHistory: optionOf(FOSOHistory));
  }

  changeHistoryList(List<History> historyList) =>
      state = state.copyWith(historyList: historyList);

  // Future<void> getHistoryOFFLINE() async {
  //   Either<RemoteFailure, List<History>?> FOSOHistory;

  //   state = state.copyWith(isGetting: true, FOSOHistory: none());

  //   FOSOHistory = await _repository.getHistoriesOFFLINE();

  //   state =
  //       state.copyWith(isGetting: false, FOSOHistory: optionOf(FOSOHistory));
  // }
}
