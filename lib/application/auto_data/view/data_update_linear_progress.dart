import 'package:agung_opr/application/auto_data/shared/auto_data_providers.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../shared/providers.dart';
import '../../check_sheet/shared/providers/cs_providers.dart';
import '../../check_sheet/unit/shared/csu_providers.dart';
import '../../routes/route_names.dart';
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

    final isOffline = ref.watch(isOfflineStateProvider);

    return Material(
      child: Visibility(
        visible: hasQueryData,
        child: Ink(
          height: 30,
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () => context.pushNamed(RouteNames.dataUpdateQueryName),
            child: isOffline
                ? Container(
                    color: Palette.secondaryColor,
                    child: Center(
                      child: Text(
                        'Data Pending (Offline)',
                        style: Themes.customColor(
                          FontWeight.normal,
                          11,
                          Colors.white,
                        ),
                      ),
                    ),
                  )
                : LinearProgressIndicator(
                    color: Palette.secondaryColor,
                    semanticsLabel: 'Linear progress indicator',
                    value: double.parse(
                      (time / Constants.dataIntervalTimerInSeconds).toString(),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
