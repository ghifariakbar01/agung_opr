import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/Supir/Supir_repository.dart';

import 'supir.dart';
import 'supir_state.dart';

class SupirNotifier extends StateNotifier<SupirState> {
  SupirNotifier(this._repository) : super(SupirState.initial());

  final SupirRepository _repository;

  Future<void> getSupirList({required int page}) async {
    final Either<RemoteFailure, List<Supir>> FOS;

    state = state.copyWith(isProcessing: true, FOSOSupir: none());

    FOS = await _repository.getSupirList(page: page);

    state = state.copyWith(isProcessing: false, FOSOSupir: optionOf(FOS));
  }

  Future<void> getSupirListOFFLINE({required int page}) async {
    final Either<RemoteFailure, List<Supir>> FOS;

    state = state.copyWith(isProcessing: true, FOSOSupir: none());

    FOS = await _repository.getSupirListOFFLINE(page: page);

    state = state.copyWith(isProcessing: false, FOSOSupir: optionOf(FOS));
  }

  Future<void> searchSupirList({required String search}) async {
    final Either<RemoteFailure, List<Supir>> FOS;

    state = state.copyWith(isProcessing: true, FOSOSupir: none());

    FOS = await _repository.searchSupirList(search: search);

    state = state.copyWith(isProcessing: false, FOSOSupir: optionOf(FOS));
  }

  Future<void> searchSupirListOFFLINE({required String search}) async {
    final Either<RemoteFailure, List<Supir>> FOS;

    state = state.copyWith(isProcessing: true, FOSOSupir: none());

    FOS = await _repository.searchSupirListOFFLINE(search: search);

    state = state.copyWith(isProcessing: false, FOSOSupir: optionOf(FOS));
  }

  void changeSelectedId(int idSelected) {
    state = state.copyWith(idSelected: idSelected);
  }

  void changeIsMore(bool hasMore) {
    state = state.copyWith(hasMore: hasMore);
  }

  void changePage(int page) {
    state = state.copyWith(page: page);
  }

  void replaceSupirList(List<Supir> supir) {
    state = state.copyWith(supirList: [...supir]);
  }

  void changeSupirList(
      {required List<Supir> newSupir, required List<Supir> oldSupir}) {
    state = state.copyWith(supirList: [...oldSupir, ...newSupir]);
  }

  void processSupirList(
      {required List<Supir> newSupir,
      required Function changeSupir,
      required Function replaceSupir,
      required Function changeIsMore,
      required int page}) {
    final pageIsZero = page == 0;
    final SupirEmpty = newSupir.isEmpty;

    if (!pageIsZero && !SupirEmpty) {
      changeSupir();
    } else if (!pageIsZero && SupirEmpty) {
      changeIsMore();
    } else if (pageIsZero && !SupirEmpty) {
      replaceSupir();
    } else if (pageIsZero && SupirEmpty) {
      return;
    }
  }
}
