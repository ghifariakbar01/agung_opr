import 'package:agung_opr/application/double/double_notifier.dart';
import 'package:agung_opr/application/update_cs_disable/update_cs_disable_notifier.dart';
import 'package:agung_opr/application/update_spk/providers/update_spk_providers.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';
import '../../../double/double.dart';
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

    final csIdMap = ref.watch(csItemNotifierProvider).csItemListByID;
    final _isCsLoaded = csIdMap.isNotEmpty;

    final _double = ref.watch(doubleNotifierProvider);

    return Column(
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
                final bool _disUnload = dis.unload;
                final bool _disLoadUnload = dis.loadunload;

                final _d = _double ??
                    SPKDouble.initial().copyWith(idSpk: _currSpk.idSpk);
                final _doubleDisable = _d.disable;

                final _csLoading = _disLoad || _doubleDisable.loading;
                final _csUnload = _disUnload || _doubleDisable.unload;
                final _csLoadUnload =
                    _disLoadUnload || _doubleDisable.loadunload;

                final _enabled = modeApp.maybeMap(
                  checkSheetLoading: (_) => _csLoading,
                  checkSheetUnloading: (_) => _csUnload,
                  checkSheetLoadingUnloading: (_) => _csLoadUnload,
                  orElse: () => false,
                );

                final SPKDouble _spkDouble = SPKDouble(
                  idSpk: updateCS.selectedSPK.idSpk,
                  disable: UpdateCsDisable(
                    loading: modeApp.maybeWhen(
                      checkSheetLoading: () => true,
                      orElse: () => _csLoading,
                    ),
                    unload: modeApp.maybeWhen(
                      checkSheetUnloading: () => true,
                      orElse: () => _csUnload,
                    ),
                    loadunload: modeApp.maybeWhen(
                      checkSheetLoadingUnloading: () => true,
                      orElse: () => _csLoadUnload,
                    ),
                  ),
                );

                return VButton(
                    // isEnabled: _isCsLoaded && _enabled == false,
                    label: _isCsLoaded == false
                        ? 'Muat Ulang Halaman'
                        : _enabled
                            ? 'Sudah Check Sheet'
                            : isDefect
                                ? 'NG'
                                : 'OK',
                    color: isDefect ? Palette.red : null,
                    onPressed: () async {
                      final _notifier =
                          ref.read(updateCSNotifierProvider.notifier);

                      if (_notifier.isValid()) {
                        await _notifier.saveQuery();
                        await ref
                            .read(updateSPKNotifierProvider.notifier)
                            .saveQuerySPK();

                        final _isLoading = modeApp.maybeMap(
                          checkSheetLoading: (_) => true,
                          orElse: () => false,
                        );

                        if (_isLoading) {
                          final updateProvider =
                              ref.read(updateFrameNotifierProvider);
                          final idSPK =
                              ref.read(updateFrameNotifierProvider).idSPK;

                          await ref
                              .read(updateFrameNotifierProvider.notifier)
                              .updateAllFrame(
                                idSPK: idSPK.toString(),
                                nama: user.user.nama!,
                                sjkb: updateProvider.sppdc,
                                userId: user.user.idUser.toString(),
                                gate: updateCS.updateCSForm.gate.getOrLeave(''),
                                updateFrameList: updateProvider.updateFrameList,
                              );

                          await ref
                              .read(updateFrameOfflineNotifierProvider.notifier)
                              .CUUpdateFrameOFFLINEStatus();
                        }

                        await ref
                            .read(doubleControllerProvider.notifier)
                            .save(_spkDouble);
                      }
                    });
              },
            );
          },
        ),
      ],
    );
  }
}
