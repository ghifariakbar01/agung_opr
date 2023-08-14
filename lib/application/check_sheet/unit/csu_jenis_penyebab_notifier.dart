import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/remote_failure.dart';
import '../../../infrastructure/csu/csu_jenis_penyebab_repository.dart';
import 'state/csu_jenis_penyebab_item.dart';
import 'state/csu_jenis_penyebab_state.dart';

class CSUJenisPenyebabNotifier extends StateNotifier<CSUJenisPenyebabState> {
  CSUJenisPenyebabNotifier(
    this._repository,
  ) : super(CSUJenisPenyebabState.initial());

  final CSUJenisPenyebabRepository _repository;

  Future<void> getCSUJenisItems() async {
    Either<RemoteFailure, List<CSUJenisPenyebabItem>>? FOS;

    state = state.copyWith(isProcessing: true, FOSOUpdateCSUJenisItems: none());

    // debugger(message: 'called');

    FOS = await _repository.getCSUJenisItems();

    state = state.copyWith(
        isProcessing: false, FOSOUpdateCSUJenisItems: optionOf(FOS));
  }

  Future<void> getCSUPenyebabItems() async {
    Either<RemoteFailure, List<CSUJenisPenyebabItem>>? FOS;

    state =
        state.copyWith(isProcessing: true, FOSOUpdateCSUPenyebabItems: none());

    // debugger(message: 'called');

    FOS = await _repository.getCSUPenyebabItems();

    state = state.copyWith(
        isProcessing: false, FOSOUpdateCSUPenyebabItems: optionOf(FOS));
  }

  void changeCSUPenyebabItems(List<CSUJenisPenyebabItem> csuPenyebabItems) {
    state = state.copyWith(
      csuPenyebabItems: [
        CSUJenisPenyebabItem.initialPenyebab(),
        ...csuPenyebabItems
      ],
      FOSOUpdateCSUPenyebabItems: none(),
    );
  }

  void changeCSUJenisItems(List<CSUJenisPenyebabItem> csuJenisItems) {
    state = state.copyWith(
      csuJenisItems: [CSUJenisPenyebabItem.initial(), ...csuJenisItems],
      FOSOUpdateCSUJenisItems: none(),
    );
  }
}
