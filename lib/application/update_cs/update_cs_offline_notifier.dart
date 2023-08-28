import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/update_cs/update_cs_repository.dart';
import '../check_sheet/loading/state/update_cs_offline_state.dart';

class UpdateCSFrameOfflineNotifier extends StateNotifier<UpdateCSOfflineState> {
  UpdateCSFrameOfflineNotifier(this._repository)
      : super(UpdateCSOfflineState.initial());

  final UpdateCSRepository _repository;

  Future<void> CUUpdateCSFrameOFFLINEStatus() async {
    final isOfffline = await _repository.hasOfflineData();

    if (isOfffline) {
      state = const UpdateCSOfflineState.hasOfflineStorage();
    } else {
      state = const UpdateCSOfflineState.empty();
    }
  }
}
