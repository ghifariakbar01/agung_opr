import 'package:agung_opr/application/gate/csu_mst_gate.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/infrastructure/gate/gate_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'csu_gate_state.dart';

class GateNotifier extends StateNotifier<CSUGateState> {
  GateNotifier(
    this._repository,
  ) : super(CSUGateState.initial());

  final GateRepository _repository;

  Future<void> getGates() async {
    Either<RemoteFailure, List<CSUMSTGate>>? FOS;

    state = state.copyWith(isProcessing: true, FOSOGate: none());

    // debugger(message: 'called');

    FOS = await _repository.getCSUGates();

    state = state.copyWith(isProcessing: false, FOSOGate: optionOf(FOS));
  }

  Future<void> searchGateList({required String search}) async {
    final Either<RemoteFailure, List<CSUMSTGate>> FOS;

    state = state.copyWith(isProcessing: true, FOSOGate: none());

    FOS = await _repository.searchGatesList(search: search);

    state = state.copyWith(isProcessing: false, FOSOGate: optionOf(FOS));
  }

  void changeGateList(List<CSUMSTGate> gateList) {
    state = state.copyWith(gates: [CSUMSTGate.initial(), ...gateList]);
  }
}
