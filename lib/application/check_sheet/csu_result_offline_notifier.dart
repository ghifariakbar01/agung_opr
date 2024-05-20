import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/csu/csu_repository.dart';
import 'unit/state/csu_result_offline_state.dart';

class CSUResultOfflineNotifier extends StateNotifier<CSUResultOfflineState> {
  CSUResultOfflineNotifier(this._repository)
      : super(CSUResultOfflineState.initial());

  final CSUFrameRepository _repository;

  Future<void> checkAndUpdateCSUResultOFFLINEStatus(
      {required String frame}) async {
    final isOfffline = await _repository.hasOfflineCSUResultIndex(frame);

    if (isOfffline) {
      state = const CSUResultOfflineState.hasOfflineStorage();
    } else {
      state = const CSUResultOfflineState.empty();
    }
  }
}
