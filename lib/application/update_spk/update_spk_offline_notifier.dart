import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/update_spk/update_spk_repository.dart';
import 'state/update_spk_offline_state.dart';

class UpdateSPKOfflineNotifier extends StateNotifier<UpdateSPKOfflineState> {
  UpdateSPKOfflineNotifier(this._repository)
      : super(UpdateSPKOfflineState.initial());

  final UpdateSPKRepository _repository;

  Future<void> CUUpdateSPKOFFLINEStatus() async {
    final isOfffline = await _repository.hasOfflineData();

    if (isOfffline) {
      state = const UpdateSPKOfflineState.hasOfflineStorage();
    } else {
      state = const UpdateSPKOfflineState.empty();
    }
  }
}
