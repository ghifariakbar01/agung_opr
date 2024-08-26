import 'package:agung_opr/application/double/double_notifier.dart';
import 'package:agung_opr/application/update_cs_disable/update_cs_disable_notifier.dart';
import 'package:agung_opr/application/update_spk/providers/update_spk_providers.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/local_failure.dart';
import '../../../double/double.dart';
import '../../../update_cs_disable/disable.dart';
import '../../../../common/widgets/alert_helper.dart';
import '../../../../common/widgets/v_async_widget.dart';
import '../../../../common/widgets/v_button.dart';

class CheckSheetUpdateKeterangan extends ConsumerWidget {
  const CheckSheetUpdateKeterangan();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<Option<Either<LocalFailure, Unit>>>(
        updateSPKNotifierProvider.select(
          (state) => state.FOSOUpdateSPK,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => AlertHelper.showSnackBar(
                      context,
                      message: failure.map(
                        empty: (_) => 'Data kosong',
                        format: (error) => 'Error format. $error',
                        storage: (_) =>
                            'Storage penuh. Tidak bisa menyimpan data Update Spk',
                      ),
                    ),
                (_) => ref
                    .read(updateSPKOfflineNotifierProvider.notifier)
                    .CUUpdateSPKOFFLINEStatus())));

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
                            label: 'Update Keterangan Ulang',
                            onPressed: () async {
                              if (_isLoading) {
                                await ref
                                    .read(updateSPKNotifierProvider.notifier)
                                    .saveQuerySPK();
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
