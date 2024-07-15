// ignore_for_file: unused_result

import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/assets.dart';
import '../../../domain/local_failure.dart';
import '../../auto_data/shared/auto_data_providers.dart';
import '../../check_sheet/shared/providers/cs_providers.dart';
import '../../check_sheet/shared/state/cs_id_query.dart';
import '../../check_sheet/unit/state/csu_id_query.dart';
import '../../spk/application/spk_id_query.dart';
import '../../update_spk/providers/update_spk_providers.dart';
import '../../widgets/alert_helper.dart';
import '../../widgets/v_dialogs.dart';
import 'cranny_scaffold.dart';

class CrannyMiddle extends ConsumerStatefulWidget {
  const CrannyMiddle();

  @override
  ConsumerState<CrannyMiddle> createState() => _CrannyMiddleState();
}

class _CrannyMiddleState extends ConsumerState<CrannyMiddle> {
  Future<void> _updateOfflineStorageStatus() async {
    await ref
        .read(updateFrameOfflineNotifierProvider.notifier)
        .CUUpdateFrameOFFLINEStatus();
    await ref
        .read(updateCSOfflineNotifierProvider.notifier)
        .CUUpdateCSOFFLINEStatus();
    await ref
        .read(updateCSUFrameOfflineNotifierProvider.notifier)
        .CUUpdateCSUFrameOFFLINEStatus();
    await ref
        .read(updateSPKOfflineNotifierProvider.notifier)
        .CUUpdateSPKOFFLINEStatus();
  }

  @override
  Widget build(BuildContext context) {
    // Frame Queres
    ref.listen<Option<Either<LocalFailure, Map<String, Map<String, String>>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOSPKAutoDataLocalUpdateFrame,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold((failure) async {
                  await _updateOfflineStorageStatus();
                  return AlertHelper.showSnackBar(
                    context,
                    message: failure.map(
                      storage: (_) => 'storage penuh',
                      empty: (_) => 'Update Frame empty',
                      format: (error) => 'Error Format: $error',
                    ),
                  );
                },
                    (idSPKMapidTIUnitMapQuery) => ref
                        .read(autoDataUpdateFrameNotifierProvider.notifier)
                        .runSavedQueryFromRepository(
                            idSPKMapidTIUnitMapQuery:
                                idSPKMapidTIUnitMapQuery))));

    // CheckSheet Queries
    ref.listen<Option<Either<LocalFailure, List<CSIDQuery>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOAutoDataLocalUpdateFrameCS,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => VSimpleDialog(
                        label: 'Error',
                        labelDescription: failure.map(
                          empty: (_) => 'empty',
                          storage: (_) => 'storage penuh',
                          format: (value) => 'error format $value',
                        ),
                        asset: Assets.iconCrossed,
                      ),
                    ).then((_) => _updateOfflineStorageStatus()),
                (queryIds) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .runSavedCSQueryFromRepository(queryIds: queryIds)
                    .then((_) => ref
                        .read(updateCSOfflineNotifierProvider.notifier)
                        .CUUpdateCSOFFLINEStatus()))));

    // CheckSheet Unit Queries
    ref.listen<Option<Either<LocalFailure, List<CSUIDQuery>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOAutoDataLocalUpdateFrameCSU,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => VSimpleDialog(
                        label: 'Error',
                        labelDescription: failure.map(
                          empty: (_) => 'empty',
                          storage: (_) => 'storage penuh',
                          format: (value) => 'error format $value',
                        ),
                        asset: Assets.iconCrossed,
                      ),
                    ).then((_) => _updateOfflineStorageStatus()),
                (queryIds) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .runSavedCSUQueryFromRepository(queryIds: queryIds))));

    // SPK Queries
    ref.listen<Option<Either<LocalFailure, List<SPKIdQuery>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOAutoDataLocalUpdateFrameSPK,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => VSimpleDialog(
                        label: 'Error',
                        labelDescription: failure.map(
                            storage: (_) => 'storage penuh',
                            format: (value) => 'error format $value',
                            empty: (_) => 'empty'),
                        asset: Assets.iconCrossed,
                      ),
                    ).then((_) => _updateOfflineStorageStatus()),
                (queryIds) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .runSavedSPKQueryFromRepository(queryIds: queryIds)
                    .then((_) => ref
                        .read(updateSPKOfflineNotifierProvider.notifier)
                        .CUUpdateSPKOFFLINEStatus()))));

    //
    ref.listen<Option<Either<RemoteFailure, Unit>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOAutoDataRemote,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold((failure) async {
                  await _updateOfflineStorageStatus();
                  await failure.maybeWhen(
                      noConnection: () => {},
                      orElse: () => showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) => VSimpleDialog(
                              label: 'Error',
                              asset: Assets.iconCrossed,
                              labelDescription: failure.maybeMap(
                                orElse: () => '',
                                storage: (_) => 'storage penuh',
                                parse: (error) => 'error parse $error',
                                server: (error) =>
                                    '${error.errorCode} ${error.message}',
                              ),
                            ),
                          ));
                }, (_) => _updateOfflineStorageStatus())));

    return CrannyScaffold();
  }
}
