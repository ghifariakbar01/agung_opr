import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/remote_failure.dart';
import '../../../infrastructure/csu/csu_items_repository.dart';
import 'state/csu_items/csu_items.dart';
import 'state/csu_items/csu_items_state.dart';

class CSUItemsNotifier extends StateNotifier<CSUItemsState> {
  CSUItemsNotifier(
    this._repository,
  ) : super(CSUItemsState.initial());

  final CSUItemsRepository _repository;

  Future<void> getCSUItems() async {
    Either<RemoteFailure, List<CSUItems>>? FOS;

    state = state.copyWith(isProcessing: true, FOSOUpdateCSUItems: none());

    FOS = await _repository.getCSUItems();

    state =
        state.copyWith(isProcessing: false, FOSOUpdateCSUItems: optionOf(FOS));
  }

  Future<void> getCSUItemsOFFLINE() async {
    Either<RemoteFailure, List<CSUItems>>? FOS;

    state = state.copyWith(isProcessing: true, FOSOUpdateCSUItems: none());

    FOS = await _repository.getCSUItemsOffline();

    state =
        state.copyWith(isProcessing: false, FOSOUpdateCSUItems: optionOf(FOS));
  }

  void changeCSUItems(List<CSUItems> csuItems) {
    state = state.copyWith(
      csuItems: csuItems,
      FOSOUpdateCSUItems: none(),
    );
  }
}
