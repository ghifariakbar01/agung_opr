import 'package:agung_opr/infrastructure/csu/csu_items_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/csu/csu_repository.dart';
import 'unit/state/csu_items_offline_state.dart';

class CSUItemsOfflineNotifier extends StateNotifier<CSUItemsOfflineState> {
  CSUItemsOfflineNotifier(this._repository)
      : super(CSUItemsOfflineState.initial());

  final CSUItemsRepository _repository;

  Future<void> checkAndUpdateCSUItemsOFFLINEStatus() async {
    final isOfffline = await _repository.hasOfflineData();

    if (isOfffline) {
      state = const CSUItemsOfflineState.hasOfflineStorage();
    } else {
      state = const CSUItemsOfflineState.empty();
    }
  }
}
