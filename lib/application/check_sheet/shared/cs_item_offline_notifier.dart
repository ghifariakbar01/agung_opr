import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure/cs/cs_items_repository.dart';
import 'state/cs_item_offline_state.dart';

class CSItemOfflineNotifier extends StateNotifier<CSItemOfflineState> {
  CSItemOfflineNotifier(this._repository) : super(CSItemOfflineState.initial());

  final CSItemsRepository _repository;

  Future<void> checkAndUpdateCSItemOFFLINEStatus() async {
    final isOfffline = await _repository.hasOfflineData();

    log('checkAndUpdateCSItemOFFLINEStatus isOfffline $isOfffline');

    if (isOfffline) {
      state = const CSItemOfflineState.hasOfflineStorage();
    } else {
      state = const CSItemOfflineState.empty();
    }
  }
}
