import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/csu/csu_repository.dart';
import 'unit/state/csu_trips_offline_state.dart';

class CSUTripsOfflineNotifier extends StateNotifier<CSUTripsOfflineState> {
  CSUTripsOfflineNotifier(this._repository)
      : super(CSUTripsOfflineState.initial());

  final CSUFrameRepository _repository;

  Future<void> checkAndUpdateTripsOFFLINEStatus({required int idUnit}) async {
    final isOfffline = await _repository.hasOfflineTripsDataIndex(idUnit);

    if (isOfffline) {
      state = const CSUTripsOfflineState.hasOfflineStorage();
    } else {
      state = const CSUTripsOfflineState.empty();
    }
  }
}
