import 'dart:async';

import 'package:agung_opr/application/auto_data/auto_data_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AutoDataNotifier extends StateNotifier<AutoDataState> {
  AutoDataNotifier() : super(AutoDataState.initial());

  void startTimerAutoData({required Function getAndSaveDataOffline}) {
    const duration = Duration(minutes: 60);
    Timer.periodic(duration, (Timer timer) async {
      await getAndSaveDataOffline();
    });
  }
}
