import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/assets.dart';
import '../../../domain/local_failure.dart';
import '../../auto_data/shared/auto_data_providers.dart';
import '../../check_sheet/shared/providers/cs_providers.dart';
import '../../check_sheet/shared/state/cs_id_query.dart';
import '../../check_sheet/unit/state/csu_id_query.dart';
import '../../clear_data_essential/clear_data_essential_providers.dart';
import '../../routes/route_names.dart';
import '../../spk/application/spk_id_query.dart';
import '../../spk/spk.dart';
import '../../update_frame/frame.dart';
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

  Future<void> _savedQueriesFunction() async {
    await ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedQueryFromRepository();
    await ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedCSQueryFromRepository();
    await ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedCSUQueryFromRepository();
    await ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedSPKQueryFromRepository();
  }

  @override
  Widget build(BuildContext context) {
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
                  await _savedQueriesFunction();
                  SPK selectedSPK =
                      ref.read(updateCSNotifierProvider).selectedSPK;
                  selectedSPK != SPK.initial()
                      ? () {
                          Map<String, dynamic> spkMap = selectedSPK.toJson();
                          context.pushReplacementNamed(
                            extra: spkMap,
                            RouteNames.checkSheetLoadingNameRoute,
                          );
                          return context.pushNamed(RouteNames.historyNameRoute);
                        }()
                      : () {}();
                })));

    // Frame Queres
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
                    ),
                (idSPKMapidTIUnitMapQuery) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .runSavedQueryFromRepository(
                        idSPKMapidTIUnitMapQuery: idSPKMapidTIUnitMapQuery))));

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
                            storage: (_) => 'storage penuh',
                            format: (value) => 'error format $value',
                            empty: (_) => 'empty'),
                        asset: Assets.iconCrossed,
                      ),
                    ),
                (queryIds) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .runSavedCSQueryFromRepository(queryIds: queryIds))));

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
                            storage: (_) => 'storage penuh',
                            format: (value) => 'error format $value',
                            empty: (_) => 'empty'),
                        asset: Assets.iconCrossed,
                      ),
                    ),
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
                    ),
                (queryIds) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .runSavedSPKQueryFromRepository(queryIds: queryIds))));

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
                  await _readCsuLastPage(context);
                  await _updateOfflineStorageStatus();
                  ref
                      .read(autoDataUpdateFrameNotifierProvider.notifier)
                      .resetAutoDataRemoteFOSO();
                })));

    return CrannyScaffold();
  }

  Future<void> _readCsuLastPage(BuildContext context) async {
    final Frame frame = ref.read(csuLastPageProvider);
    if (frame != Frame.initial()) {
      Map<String, dynamic> frameMap = frame.toJson();

      await context.pushNamed(extra: frameMap, RouteNames.CSUResultRoute);

      ref.read(csuLastPageProvider.notifier).state = Frame.initial();
    }
  }
}
