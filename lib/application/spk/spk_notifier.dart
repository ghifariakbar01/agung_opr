import 'dart:developer';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/infrastructure/spk/spk_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'spk.dart';
import 'spk_state.dart';

class SPKNotifier extends StateNotifier<SPKState> {
  SPKNotifier(this._repository) : super(SPKState.initial());

  final SPKRepository _repository;

  reset() {
    state = SPKState.initial();
  }

  Future<void> getSPKList({required int page}) async {
    final Either<RemoteFailure, List<SPK>> FOS;

    state = state.copyWith(isProcessing: true, FOSOSPK: none());

    FOS = await _repository.getSPKList(page: page);

    state = state.copyWith(isProcessing: false, FOSOSPK: optionOf(FOS));
  }

  Future<SPK> getSPKById({required int idSpk}) async {
    state = state.copyWith(isProcessing: true);

    final _spk = await _repository.getSPKById(idSpk: idSpk);

    state = state.copyWith(isProcessing: false);

    return _spk;
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

    debugger();

    state = state.copyWith(isProcessing: false, FOSOSPK: optionOf(FOS));
  }

  void changeSPKList(List<SPK> spkList) {
    state = state.copyWith(spkList: [...spkList]);
  }

  void addPKList({required List<SPK> newSPK, required List<SPK> oldSPK}) {
    state = state.copyWith(spkList: [...oldSPK, ...newSPK]);
  }

  void processSPKList({
    required List<SPK> newSPK,
    required Function changeSPK,
    required Function replaceSPK,
  }) {
    final SPKEmpty = newSPK.isEmpty;

    if (!SPKEmpty) {
      changeSPK();
    } else if (SPKEmpty) {
      replaceSPK();
    }
  }
}
