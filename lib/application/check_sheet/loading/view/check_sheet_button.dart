import 'package:agung_opr/application/update_cs_disable/update_cs_disable_notifier.dart';
import 'package:agung_opr/application/update_spk/providers/update_spk_providers.dart';
import 'package:flutter/material.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';
import '../../../routes/route_names.dart';
import '../../../update_cs_disable/disable.dart';
import '../../../widgets/v_async_widget.dart';
import '../../../widgets/v_button.dart';
import '../../shared/providers/cs_providers.dart';
import '../../../update_frame/shared/update_frame_providers.dart';

class CheckSheetButton extends ConsumerWidget {
  const CheckSheetButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider);

    final updateCS = ref.watch(updateCSNotifierProvider);

    final bool isDefect = updateCS.updateCSForm.isNG.firstWhere(
      (checkSheet) => checkSheet == true,
      orElse: () => false,
    );

    final disabled = ref.watch(updateCsDisableNotifierProvider);
    final modeApp = ref.watch(modeNotifierProvider);

    return Column(
      children: [
        VAsyncValueWidget<UpdateCsDisable>(
          value: disabled,
          data: (dis) {
            final _disLoad = dis.loading;
            final _disUnload = dis.unload;
            final _disLoadUnload = dis.loadunload;

            final _enabled = modeApp.maybeMap(
              checkSheetLoading: (_) => _disLoad,
              checkSheetUnloading: (_) => _disUnload,
              checkSheetLoadingUnloading: (_) => _disLoadUnload,
              orElse: () {},
            );

            final _isLoading = modeApp.maybeMap(
              checkSheetLoading: (_) => true,
              orElse: () => false,
            );

            if (_enabled == null) {
              return Text('null');
            }

            return VButton(
                isEnabled: _enabled == false,
                label: _enabled
                    ? 'Sudah Check Sheet'
                    : isDefect
                        ? 'NG'
                        : 'OK',
                color: isDefect ? Palette.red : null,
                onPressed: () async {
                  final _notifier = ref.read(updateCSNotifierProvider.notifier);

                  if (_notifier.isValid()) {
                    await _notifier.saveQuery();
                    await ref
                        .read(updateSPKNotifierProvider.notifier)
                        .saveQuerySPK();

                    if (_isLoading) {
                      final updateProvider =
                          ref.read(updateFrameNotifierProvider);
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

                    context.replaceNamed(RouteNames.crannyName);
                  }
                });
          },
        ),
      ],
    );
  }
}
