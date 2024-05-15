import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/csu/csu_repository.dart';
import 'unit/state/csu_ng/csu_ng_by_id_offline_state.dart';

class CSUNGByIDOfflineNotifier extends StateNotifier<CSUNGByIDfflineState> {
  CSUNGByIDOfflineNotifier(this._repository)
      : super(CSUNGByIDfflineState.initial());

  final CSUFrameRepository _repository;

  Future<void> checkAndUpdateCSUNGByIDOFFLINEStatus({required int idCS}) async {
    final isOfffline = await _repository.hasOfflineCSUNGResultIndex(idCS);

    if (isOfffline) {
      state = const CSUNGByIDfflineState.hasOfflineStorage();
    } else {
      state = const CSUNGByIDfflineState.empty();
    }
  }
}
