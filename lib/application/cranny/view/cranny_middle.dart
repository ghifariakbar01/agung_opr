import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/check_sheet/unit/state/csu_id_query.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/assets.dart';
import '../../../domain/local_failure.dart';
import '../../auto_data/shared/auto_data_providers.dart';
import '../../widgets/alert_helper.dart';
import '../../widgets/v_dialogs.dart';
import 'cranny_scaffold.dart';

class CrannyMiddle extends ConsumerStatefulWidget {
  const CrannyMiddle();

  @override
  ConsumerState<CrannyMiddle> createState() => _CrannyMiddleState();
}

class _CrannyMiddleState extends ConsumerState<CrannyMiddle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<LocalFailure, Map<String, Map<String, String>>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOSPKAutoDataLocalUpdateFrame,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => AlertHelper.showSnackBar(
                          context,
                          message: failure.maybeMap(
                              storage: (_) => 'storage penuh',
                              format: (error) => 'Error Format: $error',
                              orElse: () => ''),
                        ), (idSPKMapidTIUnitMapQuery) {
                  ref
                          .read(autoDataUpdateFrameNotifierProvider.notifier)
                          .isMapEmpty(idSPKMapidTIUnitMapQuery)
                      ? () {
                          log('MAP IS EMPTY');
                        }
                      : ref.read(autoDataTimerNotifierProvider
                              .select((value) => value.isRunning == false))
                          ? () async {
                              ref
                                  .read(autoDataUpdateFrameNotifierProvider
                                      .notifier)
                                  .changeSavedQuery(
                                      idSPKMapidTIUnitMapQuery:
                                          idSPKMapidTIUnitMapQuery);

                              // debugger(message: 'called');

                              log('isMapEmpty ${ref.read(autoDataUpdateFrameNotifierProvider.notifier).isMapEmpty(idSPKMapidTIUnitMapQuery)}');
                              log('isRunning ${ref.read(autoDataTimerNotifierProvider.select((value) => value.isRunning == false))}');
                              await ref
                                  .read(autoDataUpdateFrameNotifierProvider
                                      .notifier)
                                  .runSavedQueryFromRepository(
                                      idSPKMapidTIUnitMapQuery:
                                          idSPKMapidTIUnitMapQuery);
                            }()
                          : () {
                              log('MAP IS NOT EMPTY');
                            }();
                })));

    // CSU Items
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
                            storage: (_) => 'storage penuh',
                            format: (value) => 'error format $value',
                            empty: (_) => 'empty'),
                        asset: Assets.iconCrossed,
                      ),
                    ),
                (queryIds) => ref
                        .read(autoDataUpdateFrameNotifierProvider.notifier)
                        .isCSUQueryEmpty()
                    ? () {
                        // debugger(message: 'called');
                      }
                    : ref.read(autoDataTimerNotifierProvider
                            .select((value) => value.isRunning == false))
                        ? () async {
                            ref
                                .read(autoDataUpdateFrameNotifierProvider
                                    .notifier)
                                .changeSavedCSUQuery(csuIdQueries: queryIds);

                            // debugger(message: 'called');

                            log('isCSUQueryEmpty ${ref.read(autoDataUpdateFrameNotifierProvider.notifier).isCSUQueryEmpty()}');
                            log('isRunning ${ref.read(autoDataTimerNotifierProvider.select((value) => value.isRunning == false))}');
                            await ref
                                .read(autoDataUpdateFrameNotifierProvider
                                    .notifier)
                                .runSavedCSUQueryFromRepository(
                                    queryIds: queryIds);
                          }()
                        : () {})));

    //
    ref.listen<Option<Either<RemoteFailure, Unit>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOAutoDataRemote,
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
                              noConnection: (_) => 'tidak ada koneksi',
                              parse: (error) => 'error parse $error',
                              server: (error) =>
                                  '${error.errorCode} ${error.message}',
                            ),
                            asset: Assets.iconCrossed,
                          ),
                        ), (_) async {
                  await ref
                      .read(updateFrameOfflineNotifierProvider.notifier)
                      .CUUpdateFrameOFFLINEStatus();
                  await ref
                      .read(updateCSUFrameOfflineNotifierProvider.notifier)
                      .CUUpdateCSUFrameOFFLINEStatus();

                  await showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) => VSimpleDialog(
                      label: 'Sukses',
                      labelDescription: 'Sukses melakukan query tersimpan.',
                      asset: Assets.iconChecked,
                    ),
                  );
                })));

    return CrannyScaffold();
  }
}
