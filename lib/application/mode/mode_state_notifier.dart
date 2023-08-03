import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'mode_state.dart';

class ModeNotifier extends StateNotifier<ModeState> {
  ModeNotifier() : super(ModeState.initial());

  final Map<String, ModeState> labelsMode = {
    'UPDATE FRAME DUMMY': ModeState.updateFrameDummy(),
    'CHECKSHEET CCR LOADING': ModeState.checkSheetLoading(),
    'CHECKSHEET CCR UNLOADING': ModeState.checkSheetUnloading(),
    'CHECKSHEET GATE MERAK': ModeState.checkSheetGateMerak(),
    'ASSIGN UNIT MERAK': ModeState.assignUnitMerak(),
    'DATA AKAN DIUPDATE': ModeState.dataUpdateQuery()
  };

  void changeModeAplikasi(String modeKey) {
    labelsMode.forEach((key, value) {
      if (modeKey == key) {
        state = value;
      }
    });
  }
}
