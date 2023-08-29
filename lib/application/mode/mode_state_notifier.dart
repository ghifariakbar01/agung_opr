import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'mode_state.dart';

//
///   [ModeState.updateFrameDummy],
///   [ModeState.checkSheetUnit],
///   [ModeState.checkSheetLoading],
///   [ModeState.checkSheetUnloading],
///   [ModeState.checkSheetLoadingUnloading],
///   [ModeState.checkSheetGateMerak],
///   [ModeState.assignUnitMerak],
///   [ModeState.dataUpdateQuery]
///

class ModeNotifier extends StateNotifier<ModeState> {
  ModeNotifier() : super(ModeState.initial());

  void changeModeAplikasi(ModeState modeState) {
    state = modeState;
  }
}
