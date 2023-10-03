import 'dart:developer';

import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';
import '../../../mode/mode_state.dart';
import '../../../update_frame/shared/update_frame_providers.dart';
import '../../../widgets/v_button.dart';
import '../../shared/providers/cs_providers.dart';

class CheckSheetButton extends ConsumerWidget {
  const CheckSheetButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDefect = ref.watch(updateCSNotifierProvider.select((value) =>
        value.updateCSForm.isNG.firstWhere((checkSheet) => checkSheet == true,
            orElse: () => false)));

    final bool isValid =
        ref.watch(updateFrameNotifierProvider.select((value) => value.isValid));

    log('isValid $isValid');

    return Column(
      children: [
        VButton(
            label: 'NG',
            color: Palette.red,
            isEnabled: isDefect &&
                isValid &&
                ref.read(updateCSNotifierProvider.notifier).isValid(),
            onPressed: () async {
              await ref.read(updateCSNotifierProvider.notifier).saveQueryNG();

              await ref.read(updateCSNotifierProvider.notifier).saveQueryOK();

              final updateProvider = ref.read(updateFrameNotifierProvider);

              await ref
                  .read(updateFrameNotifierProvider.notifier)
                  .updateAllFrame(
                      sjkb: updateProvider.sppdc,
                      updateFrameList: updateProvider.updateFrameList);

              await ref
                  .read(updateFrameOfflineNotifierProvider.notifier)
                  .CUUpdateFrameOFFLINEStatus();

              // context.pushReplacementNamed(
              //     RouteNames.dataUpdateQueryName);
            }),
        VButton(
            label: 'OK',
            isEnabled: !isDefect &&
                isValid &&
                ref.read(updateCSNotifierProvider.notifier).isValid(),
            onPressed: () async {
              await ref.read(updateCSNotifierProvider.notifier).saveQueryNG();

              await ref.read(updateCSNotifierProvider.notifier).saveQueryOK();

              final updateProvider = ref.read(updateFrameNotifierProvider);

              await ref
                  .read(updateFrameNotifierProvider.notifier)
                  .updateAllFrame(
                      sjkb: updateProvider.sppdc,
                      updateFrameList: updateProvider.updateFrameList);

              await ref
                  .read(updateFrameOfflineNotifierProvider.notifier)
                  .CUUpdateFrameOFFLINEStatus();
            }),
      ],
    );
  }
}
