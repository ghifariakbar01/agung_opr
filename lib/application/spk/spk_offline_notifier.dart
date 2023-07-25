import 'package:agung_opr/application/spk/spk_offline_state.dart';
import 'package:agung_opr/infrastructure/spk/spk_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SPKOfflineNotifier extends StateNotifier<SPKOfflineState> {
  SPKOfflineNotifier(this._repository) : super(SPKOfflineState.initial());

  final SPKRepository _repository;

  Future<void> checkAndUpdateSPKOFFLINEStatus() async {
    final isOfffline = await _repository.hasOfflineData();

    if (isOfffline) {
      state = const SPKOfflineState.hasOfflineStorage();
    } else {
      state = const SPKOfflineState.empty();
    }
  }
}
