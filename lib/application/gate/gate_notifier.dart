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

  Future<Unit> saveDefaultGate(CSUMSTGate gate) async {
    await _repository.saveDefaultGate(gate);
    return unit;
  }

  Future<CSUMSTGate> readDefaultGate() async {
    return _repository.readDefaultGate();
  }

  Future<void> getGates() async {
    Either<RemoteFailure, List<CSUMSTGate>>? FOS;

    state = state.copyWith(
      isProcessing: true,
      FOSOGate: none(),
    );

    final _default = await readDefaultGate();
    FOS = await _repository.getCSUGates();

    state = state.copyWith(
      defaultGate: _default,
      isProcessing: false,
      FOSOGate: optionOf(FOS),
    );
  }

  Future<void> getGatesOFFLINE() async {
    Either<RemoteFailure, List<CSUMSTGate>>? FOS;

    state = state.copyWith(
      isProcessing: true,
      FOSOGate: none(),
    );

    final _default = await readDefaultGate();
    FOS = await _repository.getGatesOFFLINE();

    state = state.copyWith(
      defaultGate: _default,
      isProcessing: false,
      FOSOGate: optionOf(FOS),
    );
  }

  Future<void> searchGateListOFFLINE({required String search}) async {
    final Either<RemoteFailure, List<CSUMSTGate>> FOS;

    state = state.copyWith(
      isProcessing: true,
      FOSOGate: none(),
    );

    FOS = await _repository.searchGatesListOFFLINE(search: search);

    state = state.copyWith(
      isProcessing: false,
      FOSOGate: optionOf(FOS),
    );
  }

  Future<void> searchGateList({required String search}) async {
    final Either<RemoteFailure, List<CSUMSTGate>> FOS;

    state = state.copyWith(
      isProcessing: true,
      FOSOGate: none(),
    );

    FOS = await _repository.searchGatesList(search: search);

    state = state.copyWith(
      isProcessing: false,
      FOSOGate: optionOf(FOS),
    );
  }

  void changeGateList(List<CSUMSTGate> gateList) {
    state = state.copyWith(
      gates: [CSUMSTGate.initial(), ...gateList],
    );
  }
}
