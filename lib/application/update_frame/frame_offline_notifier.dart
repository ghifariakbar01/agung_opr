import 'package:agung_opr/application/update_frame/frame_offline_state.dart';
import 'package:agung_opr/infrastructure/frame/frame_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FrameOfflineNotifier extends StateNotifier<FrameOfflineState> {
  FrameOfflineNotifier(this._repository) : super(FrameOfflineState.initial());

  final FrameRepository _repository;

  Future<void> checkAndUpdateFrameOFFLINEStatus({required int idSPK}) async {
    final isOfffline = await _repository.hasOfflineDataIndex(idSPK);

    if (isOfffline) {
      state = const FrameOfflineState.hasOfflineStorage();
    } else {
      state = const FrameOfflineState.empty();
    }
  }

  Future<void> checkAndUpdateFrameOFFLINEStatusByPage(
      {required int page}) async {
    final isOfffline = await _repository.hasOfflineDataByPage(page: page);

    if (isOfffline) {
      state = const FrameOfflineState.hasOfflineStorage();
    } else {
      state = const FrameOfflineState.empty();
    }
  }
}
