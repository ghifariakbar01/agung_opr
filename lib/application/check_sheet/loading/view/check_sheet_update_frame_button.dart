import 'package:agung_opr/application/double/double_notifier.dart';
import 'package:agung_opr/application/update_cs_disable/update_cs_disable_notifier.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../double/double.dart';
import '../../../update_cs_disable/disable.dart';
import '../../../../common/widgets/v_async_widget.dart';
import '../../../../common/widgets/v_button.dart';
import '../../shared/providers/cs_providers.dart';
import '../../../update_frame/shared/update_frame_providers.dart';

class CheckSheetUpdateFrameButton extends ConsumerWidget {
  const CheckSheetUpdateFrameButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider);
    final updateCS = ref.watch(updateCSNotifierProvider);

    final disabled = ref.watch(updateCsDisableNotifierProvider);
    final modeApp = ref.watch(modeNotifierProvider);

    final _double = ref.watch(doubleNotifierProvider);

    final _isLoading = modeApp.maybeMap(
      checkSheetLoading: (_) => true,
      orElse: () => false,
    );

    return _isLoading
        ? Column(
            children: [
              VAsyncValueWidget<List<SPKDouble>>(
                value: _double,
                data: (_data) {
                  return VAsyncValueWidget<UpdateCsDisable>(
                    value: disabled,
                    data: (dis) {
                      final _currSpk = ref.read(selectedSPKStateProvider);
                      final SPKDouble? _double = _data.firstWhereOrNull(
                          (element) => element.idSpk == _currSpk.idSpk);

                      final bool _disLoad = dis.loading;

                      final _d = _double ??
                          SPKDouble.initial().copyWith(idSpk: _currSpk.idSpk);
                      final _doubleDisable = _d.disable;

                      final _csLoading = _disLoad || _doubleDisable.loading;

                      final _enabled = modeApp.maybeMap(
                        checkSheetLoading: (_) => _csLoading,
                        orElse: () => false,
                      );

                      return Visibility(
                        visible: _enabled,
                        child: VButton(
                            label: 'Update Frame Ulang',
                            onPressed: () async {
                              if (_isLoading) {
                                final updateProvider =
                                    ref.read(updateFrameNotifierProvider);
                                final idSPK =
                                    ref.read(updateFrameNotifierProvider).idSPK;

                                ref
                                    .read(updateFrameNotifierProvider.notifier)
                                    .checkIfValid();
                                final isValid = updateProvider.isValid;

                                if (isValid) {
                                  await ref
                                      .read(
                                          updateFrameNotifierProvider.notifier)
                                      .updateAllFrame(
                                        idSPK: idSPK.toString(),
                                        nama: user.user.nama!,
                                        sjkb: updateProvider.sppdc,
                                        userId: user.user.idUser.toString(),
                                        gate: updateCS.updateCSForm.gate
                                            .getOrLeave(''),
                                        updateFrameList:
                                            updateProvider.updateFrameList,
                                      );
                                }
                              }
                            }),
                      );
                    },
                  );
                },
              ),
            ],
          )
        : Container();
  }
}
