import 'package:agung_opr/infrastructure/gate/gate_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'gate_offline_state.dart';

class GateOfflineNotifier extends StateNotifier<GateOfflineState> {
  GateOfflineNotifier(this._repository) : super(GateOfflineState.initial());

  final GateRepository _repository;

  Future<void> checkAndUpdateGateOFFLINEStatus() async {
    final isOfffline = await _repository.hasOfflineData();

    if (isOfffline) {
      state = const GateOfflineState.hasOfflineStorage();
    } else {
      state = const GateOfflineState.empty();
    }
  }
}
