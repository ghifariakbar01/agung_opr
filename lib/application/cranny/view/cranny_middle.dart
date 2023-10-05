import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/state/csu_id_query.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/assets.dart';
import '../../../domain/local_failure.dart';
import '../../../shared/providers.dart';
import '../../auto_data/shared/auto_data_providers.dart';
import '../../check_sheet/shared/providers/cs_providers.dart';
import '../../check_sheet/shared/state/cs_id_query.dart';
import '../../clear_data/clear_data_providers.dart';
import '../../clear_data_essential/clear_data_essential_providers.dart';
import '../../history/history.dart';
import '../../routes/route_names.dart';
import '../../spk/shared/spk_providers.dart';
import '../../spk/spk.dart';
import '../../widgets/alert_helper.dart';
import '../../widgets/v_dialogs.dart';
import 'cranny_scaffold.dart';

class CrannyMiddle extends ConsumerStatefulWidget {
  const CrannyMiddle();

  @override
  ConsumerState<CrannyMiddle> createState() => _CrannyMiddleState();
}

class _CrannyMiddleState extends ConsumerState<CrannyMiddle> {
  Future<void> savedQueriesFunction() async {
    await ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedQueryFromRepository();
    await ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedCSUQueryFromRepository();
    await ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedCSQueryFromRepository();
    await ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedHistoriesFromRepository();
  }

  @override
  Widget build(BuildContext context) {
    // Clear Data upon refreshing
    ref.listen<Option<Either<LocalFailure, Unit>>>(
        clearDataNotifierProvider.select(
          (state) => state.FOSOSPKClearData,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => VSimpleDialog(
                          label: 'Error',
                          labelDescription: failure.maybeMap(
                              storage: (_) => 'storage penuh',
                              format: (error) => 'Error Format Clear: $error',
                              orElse: () => ''),
                          asset: Assets.iconCrossed,
                        )),
                (_) => ref.read(userNotifierProvider.notifier).getUser())));

    // Clear Data upon refreshing
    ref.listen<Option<Either<LocalFailure, Unit>>>(
        clearDataEssentialNotifierProvider.select(
          (state) => state.FOSOSPKClearDataEssential,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => VSimpleDialog(
                              label: 'Error',
                              labelDescription: failure.maybeMap(
                                  storage: (_) => 'storage penuh',
                                  format: (error) =>
                                      'Error Format Clear: $error',
                                  orElse: () => ''),
                              asset: Assets.iconCrossed,
                            )), (_) async {
                  await savedQueriesFunction();

                  SPK selectedSPK =
                      ref.read(updateCSNotifierProvider).selectedSPK;
                  selectedSPK != SPK.initial()
                      ? () {
                          Map<String, dynamic> spkMap = selectedSPK.toJson();

                          context.pushReplacementNamed(
                              RouteNames.checkSheetLoadingNameRoute,
                              extra: spkMap);
                        }()
                      : () {}();
                })));

    // History Items
    ref.listen<Option<Either<LocalFailure, List<History>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOAutoDataLocalHistory,
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
                        ), (histories) {
                  ref
                          .read(autoDataUpdateFrameNotifierProvider.notifier)
                          .isHistoriesEmpty()
                      ? () {
                          log('HISTORIES ARE EMPTY');
                        }
                      : () async {
                          ref
                              .read(
                                  autoDataUpdateFrameNotifierProvider.notifier)
                              .changeSavedHistories(histories: histories);

                          // debugger(message: 'called');

                          log('isHistoriesEmpty ${ref.read(autoDataUpdateFrameNotifierProvider.notifier).isHistoriesEmpty()}');
                          log('isRunning ${ref.read(autoDataTimerNotifierProvider.select((value) => value.isRunning == false))}');
                          await ref
                              .read(
                                  autoDataUpdateFrameNotifierProvider.notifier)
                              .runSavedHistoriesFromRepository(
                                  histories: histories);
                        }();
                })));

    // Frame Items
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
                      : () async {
                          ref
                              .read(
                                  autoDataUpdateFrameNotifierProvider.notifier)
                              .changeSavedQuery(
                                  idSPKMapidTIUnitMapQuery:
                                      idSPKMapidTIUnitMapQuery);

                          // debugger(message: 'called');

                          log('isMapEmpty ${ref.read(autoDataUpdateFrameNotifierProvider.notifier).isMapEmpty(idSPKMapidTIUnitMapQuery)}');
                          log('isRunning ${ref.read(autoDataTimerNotifierProvider.select((value) => value.isRunning == false))}');
                          await ref
                              .read(
                                  autoDataUpdateFrameNotifierProvider.notifier)
                              .runSavedQueryFromRepository(
                                  idSPKMapidTIUnitMapQuery:
                                      idSPKMapidTIUnitMapQuery);
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
                    ? () {}
                    : () async {
                        ref
                            .read(autoDataUpdateFrameNotifierProvider.notifier)
                            .changeSavedCSUQuery(csuIdQueries: queryIds);

                        log('isCSUQueryEmpty ${ref.read(autoDataUpdateFrameNotifierProvider.notifier).isCSUQueryEmpty()}');
                        log('isRunning ${ref.read(autoDataTimerNotifierProvider.select((value) => value.isRunning == false))}');
                        await ref
                            .read(autoDataUpdateFrameNotifierProvider.notifier)
                            .runSavedCSUQueryFromRepository(queryIds: queryIds);
                      }())));

    // CS Items
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
                            storage: (_) => 'storage penuh',
                            format: (value) => 'error format $value',
                            empty: (_) => 'empty'),
                        asset: Assets.iconCrossed,
                      ),
                    ),
                (queryIds) => ref
                        .read(autoDataUpdateFrameNotifierProvider.notifier)
                        .isCSQueryEmpty()
                    ? () {}
                    : ref.read(autoDataTimerNotifierProvider
                            .select((value) => value.isRunning == false))
                        ? () async {
                            ref
                                .read(autoDataUpdateFrameNotifierProvider
                                    .notifier)
                                .changeSavedCSQuery(csIdQueries: queryIds);

                            // debugger();

                            log('isCSQueryEmpty ${ref.read(autoDataUpdateFrameNotifierProvider.notifier).isCSQueryEmpty()}');
                            log('isRunning ${ref.read(autoDataTimerNotifierProvider.select((value) => value.isRunning == false))}');
                            await ref
                                .read(autoDataUpdateFrameNotifierProvider
                                    .notifier)
                                .runSavedCSQueryFromRepository(
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
                    (failure) => failure.maybeWhen(
                        noConnection: () => {},
                        orElse: () => showDialog(
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
                            )), (_) async {
                  await ref
                      .read(updateFrameOfflineNotifierProvider.notifier)
                      .CUUpdateFrameOFFLINEStatus();
                  await ref
                      .read(updateCSOfflineNotifierProvider.notifier)
                      .CUUpdateCSOFFLINEStatus();
                  ref
                      .read(autoDataUpdateFrameNotifierProvider.notifier)
                      .resetAutoDataRemoteFOSO();
                })));

    return CrannyScaffold();
  }
}

//   await ref
// .read(updateCSUFrameOfflineNotifierProvider.notifier)
// .CUUpdateCSUFrameOFFLINEStatus();