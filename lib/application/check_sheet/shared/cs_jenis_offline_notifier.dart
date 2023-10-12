import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure/cs/cs_repository.dart';
import 'state/cs_jenis_offline_state.dart';

class CSJenisOfflineNotifier extends StateNotifier<CSJenisOfflineState> {
  CSJenisOfflineNotifier(this._repository)
      : super(CSJenisOfflineState.initial());

  final CSRepository _repository;

  Future<void> checkAndUpdateCSJenisOFFLINEStatus() async {
    final isOfffline = await _repository.hasOfflineData();

    log('checkAndUpdateCSJenisOFFLINEStatus isOfffline $isOfffline');

    if (isOfffline) {
      state = const CSJenisOfflineState.hasOfflineStorage();
    } else {
      state = const CSJenisOfflineState.empty();
    }
  }
}
