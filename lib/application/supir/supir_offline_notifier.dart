import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/Supir/Supir_repository.dart';
import 'supir_offline_state.dart';

class SupirOfflineNotifier extends StateNotifier<SupirOfflineState> {
  SupirOfflineNotifier(this._repository) : super(SupirOfflineState.initial());

  final SupirRepository _repository;

  Future<void> checkAndUpdateSupirOFFLINEStatus() async {
    final isOfffline = await _repository.hasOfflineData();

    if (isOfffline) {
      state = const SupirOfflineState.hasOfflineStorage();
    } else {
      state = const SupirOfflineState.empty();
    }
  }
}
