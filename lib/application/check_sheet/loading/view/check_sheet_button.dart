import 'package:agung_opr/application/update_spk/providers/update_spk_providers.dart';
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

    final user = ref.watch(userNotifierProvider);

    final updateCS = ref.watch(updateCSNotifierProvider);

    return Column(
      children: [
        VButton(
            label: isDefect ? 'NG' : 'OK',
            color: isDefect ? Palette.red : null,
            onPressed: () async {
              final _notifier = ref.read(updateCSNotifierProvider.notifier);

              if (_notifier.isValid()) {
                await _notifier.saveQuery();
                await ref
                    .read(updateSPKNotifierProvider.notifier)
                    .saveQuerySPK();

                final updateProvider = ref.read(updateFrameNotifierProvider);
                final idSPK = ref.read(updateFrameNotifierProvider).idSPK;

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
              }
            }),
      ],
    );
  }
}
