import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/local_failure.dart';
import 'clear_data_essential_repository.dart';
import 'clear_data_essential_state.dart';

class ClearDataEssentialNotifier
    extends StateNotifier<ClearDataEssentialState> {
  ClearDataEssentialNotifier(this._repository)
      : super(ClearDataEssentialState.initial());

  final ClearDataEssentialRepository _repository;

  Future<void> clearAllStorage({required int idSPK}) async {
    Either<LocalFailure, Unit> FOSOClear;
    state = state.copyWith(isClearing: true, FOSOSPKClearDataEssential: none());

    FOSOClear = await _repository.clearAllStorage(idSPK: idSPK);

    state = state.copyWith(
        isClearing: false, FOSOSPKClearDataEssential: optionOf(FOSOClear));
  }
}
