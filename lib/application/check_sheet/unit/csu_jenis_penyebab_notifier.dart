import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/remote_failure.dart';
import '../../../infrastructure/csu/csu_jenis_penyebab_repository.dart';
import 'state/csu_jenis_penyebab/csu_jenis_penyebab_item.dart';
import 'state/csu_jenis_penyebab/csu_jenis_penyebab_state.dart';
import 'state/csu_posisi/csu_posisi.dart';

class CSUJenisPenyebabNotifier extends StateNotifier<CSUJenisPenyebabState> {
  CSUJenisPenyebabNotifier(
    this._repository,
  ) : super(CSUJenisPenyebabState.initial());

  final CSUJenisPenyebabRepository _repository;

  Future<void> getCSUJenisItemsOFFLINE() async {
    Either<RemoteFailure, List<CSUJenisPenyebabItem>>? FOS;

    state = state.copyWith(isProcessing: true, FOSOUpdateCSUJenisItems: none());

    FOS = await _repository.getJenisItemsOFFLINE();

    state = state.copyWith(
        isProcessing: false, FOSOUpdateCSUJenisItems: optionOf(FOS));
  }

  Future<void> getCSUJenisItems() async {
    Either<RemoteFailure, List<CSUJenisPenyebabItem>>? FOS;

    state = state.copyWith(isProcessing: true, FOSOUpdateCSUJenisItems: none());

    FOS = await _repository.getCSUJenisItems();

    state = state.copyWith(
        isProcessing: false, FOSOUpdateCSUJenisItems: optionOf(FOS));
  }

  Future<void> getCSUPosisiItemsOFFLINE() async {
    Either<RemoteFailure, List<CSUPosisi>>? FOS;

    state =
        state.copyWith(isProcessing: true, FOSOUpdateCSUPosisiItems: none());

    // debugger(message: 'called');

    FOS = await _repository.getPosisiItemsOFFLINE();

    state = state.copyWith(
        isProcessing: false, FOSOUpdateCSUPosisiItems: optionOf(FOS));
  }

  Future<void> getCSUPosisiItems() async {
    Either<RemoteFailure, List<CSUPosisi>>? FOS;

    state = state.copyWith(
      isProcessing: true,
      FOSOUpdateCSUPosisiItems: none(),
    );

    // debugger(message: 'called');

    FOS = await _repository.getCSUPosisiItems();

    state = state.copyWith(
        isProcessing: false, FOSOUpdateCSUPosisiItems: optionOf(FOS));
  }

  void changeCSUPosisiItems(List<CSUPosisi> csuPenyebabItems) {
    state = state.copyWith(
      csuPosisiItems: [CSUPosisi.initial(), ...csuPenyebabItems],
      FOSOUpdateCSUPosisiItems: none(),
    );
  }

  void changeCSUJenisItems(List<CSUJenisPenyebabItem> csuJenisItems) {
    state = state.copyWith(
      csuJenisItems: [CSUJenisPenyebabItem.initial(), ...csuJenisItems],
      FOSOUpdateCSUJenisItems: none(),
    );
  }
}
