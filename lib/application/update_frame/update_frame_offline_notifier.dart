import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/update_frame/update_frame_repository.dart';
import 'update_frame_offline_state.dart';

class UpdateFrameOfflineNotifier
    extends StateNotifier<UpdateFrameOfflineState> {
  UpdateFrameOfflineNotifier(this._repository)
      : super(UpdateFrameOfflineState.initial());

  final UpdateFrameRepository _repository;

  Future<void> CUUpdateFrameOFFLINEStatus() async {
    final isOfffline = await _repository.hasOfflineData();

    if (isOfffline) {
      state = const UpdateFrameOfflineState.hasOfflineStorage();
    } else {
      state = const UpdateFrameOfflineState.empty();
    }
  }
}
