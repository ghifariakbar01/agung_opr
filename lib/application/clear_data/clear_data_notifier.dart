import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/local_failure.dart';
import 'clear_data_repository.dart';
import 'clear_data_state.dart';

class ClearDataNotifier extends StateNotifier<ClearDataState> {
  ClearDataNotifier(this._repository) : super(ClearDataState.initial());

  final ClearDataRepository _repository;

  Future<void> clearAllStorage() async {
    Either<LocalFailure, Unit> FOSOClear;
    //

    state = state.copyWith(isClearing: true, FOSOSPKClearData: none());

    FOSOClear = await _repository.clearAllStorage();

    state = state.copyWith(
        isClearing: false, FOSOSPKClearData: optionOf(FOSOClear));
  }
}
