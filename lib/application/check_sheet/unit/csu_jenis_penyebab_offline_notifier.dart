import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure/csu/csu_jenis_penyebab_repository.dart';
import 'state/csu_jenis_penyebab_offline_state.dart';

class CSUJenisPenyebabOfflineNotifier
    extends StateNotifier<CSUJenisPenyebabOfflineState> {
  CSUJenisPenyebabOfflineNotifier(this._repository)
      : super(CSUJenisPenyebabOfflineState.initial());

  final CSUJenisPenyebabRepository _repository;

  Future<void> checkAndUpdateCSUJenisPenyebabItemsOFFLINEStatus() async {
    final isOfffline = await _repository.hasOfflineDataJenis() &&
        await _repository.hasOfflineDataPenyebab();

    if (isOfffline) {
      state = const CSUJenisPenyebabOfflineState.hasOfflineStorage();
    } else {
      state = const CSUJenisPenyebabOfflineState.empty();
    }
  }
}
