import 'package:agung_opr/application/update_csu/state/update_csu_frame_offline_state.dart';
import 'package:agung_opr/infrastructure/update_csu/update_csu_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdateCSUFrameOfflineNotifier
    extends StateNotifier<UpdateCSUFrameOfflineState> {
  UpdateCSUFrameOfflineNotifier(this._repository)
      : super(UpdateCSUFrameOfflineState.initial());

  final UpdateCSUFrameRepository _repository;

  Future<void> CUUpdateCSUFrameOFFLINEStatus() async {
    final isOfffline = await _repository.hasOfflineData();

    if (isOfffline) {
      state = const UpdateCSUFrameOfflineState.hasOfflineStorage();
    } else {
      state = const UpdateCSUFrameOfflineState.empty();
    }
  }
}
