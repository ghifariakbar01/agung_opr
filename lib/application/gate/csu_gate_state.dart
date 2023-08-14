import 'package:agung_opr/application/gate/csu_mst_gate.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/remote_failure.dart';

part 'csu_gate_state.freezed.dart';

@freezed
class CSUGateState with _$CSUGateState {
  const factory CSUGateState({
    required bool isProcessing,
    required List<CSUMSTGate> gates,
    required Option<Either<RemoteFailure, List<CSUMSTGate>>> FOSOGate,
  }) = _CSUGateState;

  factory CSUGateState.initial() =>
      CSUGateState(isProcessing: false, gates: [], FOSOGate: none());
}
