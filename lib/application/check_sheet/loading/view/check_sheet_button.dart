import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';
import '../../../widgets/v_button.dart';
import '../../shared/providers/cs_providers.dart';
import '../../../update_frame/shared/update_frame_providers.dart';

class CheckSheetButton extends ConsumerWidget {
  const CheckSheetButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDefect = ref.watch(updateCSNotifierProvider.select((value) =>
        value.updateCSForm.isNG.firstWhere((checkSheet) => checkSheet == true,
            orElse: () => false)));

    final bool isValid =
        ref.watch(updateFrameNotifierProvider.select((value) => value.isValid));

    final user = ref.watch(userNotifierProvider);

    final updateCS = ref.watch(updateCSNotifierProvider);

    return Column(
      children: [
        VButton(
            label: 'NG',
            color: Palette.red,
            isEnabled: isDefect &&
                isValid &&
                ref.read(updateCSNotifierProvider.notifier).isValid(),
            onPressed: () async {
              await ref.read(updateCSNotifierProvider.notifier).saveQueryOK();

              final updateProvider = ref.read(updateFrameNotifierProvider);
              final idSPK = ref.read(updateFrameNotifierProvider).idSPK;

              debugger();

              await ref
                  .read(updateFrameNotifierProvider.notifier)
                  .updateAllFrame(
                      idSPK: idSPK.toString(),
                      nama: user.user.nama!,
                      sjkb: updateProvider.sppdc,
                      userId: user.user.idUser.toString(),
                      gate: updateCS.updateCSForm.gate.getOrLeave(''),
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
              await ref.read(updateCSNotifierProvider.notifier).saveQueryOK();

              final updateProvider = ref.read(updateFrameNotifierProvider);
              final idSPK = ref.read(updateFrameNotifierProvider).idSPK;

              debugger();

              await ref
                  .read(updateFrameNotifierProvider.notifier)
                  .updateAllFrame(
                      idSPK: idSPK.toString(),
                      nama: user.user.nama!,
                      sjkb: updateProvider.sppdc,
                      userId: user.user.idUser.toString(),
                      gate: updateCS.updateCSForm.gate.getOrLeave(''),
                      updateFrameList: updateProvider.updateFrameList);

              await ref
                  .read(updateFrameOfflineNotifierProvider.notifier)
                  .CUUpdateFrameOFFLINEStatus();
            }),
      ],
    );
  }
}
