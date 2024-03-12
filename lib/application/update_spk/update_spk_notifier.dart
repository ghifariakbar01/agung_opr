import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/local_failure.dart';
import '../../domain/value_objects_copy.dart';
import '../../infrastructure/update_spk/update_spk_repository.dart';
import '../spk/spk.dart';
import 'state/update_spk_state.dart';

class UpdateSPKNotifier extends StateNotifier<UpdateSPKState> {
  UpdateSPKNotifier(
    this._repository,
  ) : super(UpdateSPKState.initial());

  final UpdateSPKRepository _repository;

  void changeFillWithValue({
    required SPK spk,
  }) {
    state =
        state.copyWith(selectedSPK: spk, keterangan: Keterangan(spk.ket ?? ''));
  }

  void changeKeterangan({
    required String keterangan,
  }) {
    state = state.copyWith(
      keterangan: Keterangan(keterangan),
    );
  }

  Future<void> saveQuerySPK() async {
    Either<LocalFailure, Unit>? FOS;

    if (isValid()) {
      state = state.copyWith(isProcessing: true, FOSOUpdateSPK: none());

      final spk = state.selectedSPK;
      final ket = state.keterangan;
      final keteranganStr = ket.getOrLeave('');
      // NG

      final queryId = await _repository.getSPKSavableQuery(
          idSPK: spk.idSpk, ket: keteranganStr);

      // set isNG to true
      FOS = await _repository.saveSPKQuery(queryId: queryId);

      state = state.copyWith(isProcessing: false, FOSOUpdateSPK: optionOf(FOS));
    }
  }

  bool isValid() {
    return state.selectedSPK != SPK.initial();
  }
}
