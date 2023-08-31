import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/infrastructure/spk/spk_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'spk.dart';
import 'spk_state.dart';

class SPKNotifier extends StateNotifier<SPKState> {
  SPKNotifier(this._repository) : super(SPKState.initial());

  final SPKRepository _repository;

  Future<void> getSPKList({required int page}) async {
    final Either<RemoteFailure, List<SPK>> FOS;

    state = state.copyWith(isProcessing: true, FOSOSPK: none());

    FOS = await _repository.getSPKList(page: page);

    state = state.copyWith(isProcessing: false, FOSOSPK: optionOf(FOS));
  }

  Future<void> getSPKListOFFLINE({required int page}) async {
    final Either<RemoteFailure, List<SPK>> FOS;

    state = state.copyWith(isProcessing: true, FOSOSPK: none());

    FOS = await _repository.getSPKListOFFLINE(page: page);

    state = state.copyWith(isProcessing: false, FOSOSPK: optionOf(FOS));
  }

  Future<void> searchSPKList({required String search}) async {
    final Either<RemoteFailure, List<SPK>> FOS;

    state = state.copyWith(isProcessing: true, FOSOSPK: none());

    FOS = await _repository.searchSPKList(search: search);

    state = state.copyWith(isProcessing: false, FOSOSPK: optionOf(FOS));
  }

  Future<void> searchSPKListOFFLINE({required String search}) async {
    final Either<RemoteFailure, List<SPK>> FOS;

    state = state.copyWith(isProcessing: true, FOSOSPK: none());

    FOS = await _repository.searchSPKListOFFLINE(search: search);

    state = state.copyWith(isProcessing: false, FOSOSPK: optionOf(FOS));
  }

  void changeIsMore(bool hasMore) {
    state = state.copyWith(hasMore: hasMore);
  }

  void changePage(int page) {
    state = state.copyWith(page: page);
  }

  void replaceSPKList(List<SPK> spkList) {
    state = state.copyWith(spkList: [...spkList]);
  }

  void changeSPKList({required List<SPK> newSPK, required List<SPK> oldSPK}) {
    state = state.copyWith(spkList: [...oldSPK, ...newSPK]);
  }

  void processSPKList(
      {required List<SPK> newSPK,
      required Function changeSPK,
      required Function replaceSPK,
      required Function changeIsMore,
      required int page}) {
    final pageIsZero = page == 0;
    final SPKEmpty = newSPK.isEmpty;

    if (!pageIsZero && !SPKEmpty) {
      changeSPK();
    } else if (!pageIsZero && SPKEmpty) {
      changeIsMore();
    } else if (pageIsZero && !SPKEmpty) {
      replaceSPK();
    } else if (pageIsZero && SPKEmpty) {
      return;
    }
  }
}
