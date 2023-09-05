
import 'package:agung_opr/application/auto_data/shared/auto_data_providers.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/constants.dart';
import '../../check_sheet/shared/providers/cs_providers.dart';
import '../../check_sheet/unit/shared/csu_providers.dart';
import '../../update_frame/shared/update_frame_providers.dart';

class DataUpdateLinearProgress extends ConsumerWidget {
  const DataUpdateLinearProgress();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(autoDataTimerNotifierProvider
        .select((value) => value.durationInSeconds));

    final updateFrameOfflineOrOnline =
        ref.watch(updateFrameOfflineNotifierProvider);

    final updateCSUFrameOfflineOrOnline =
        ref.watch(updateCSUFrameOfflineNotifierProvider);

    final updateCSFrameOfflineOrOnline =
        ref.watch(updateCSOfflineNotifierProvider);

    final hasQueryData = updateFrameOfflineOrOnline.maybeWhen(
          hasOfflineStorage: () => true,
          orElse: () => false,
        ) ||
        updateCSUFrameOfflineOrOnline.maybeWhen(
          hasOfflineStorage: () => true,
          orElse: () => false,
        ) ||
        updateCSFrameOfflineOrOnline.maybeWhen(
          hasOfflineStorage: () => true,
          orElse: () => false,
        );

    return Visibility(
      visible: hasQueryData,
      child: SizedBox(
        height: 15,
        width: MediaQuery.of(context).size.width,
        child: LinearProgressIndicator(
          color: Palette.secondaryColor,
          value: double.parse(
              (time / Constants.dataIntervalTimerInSeconds).toString()),
          semanticsLabel: 'Linear progress indicator',
        ),
      ),
    );
  }
}
