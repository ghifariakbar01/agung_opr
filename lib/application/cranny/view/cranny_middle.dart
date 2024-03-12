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
import '../../clear_data_essential/clear_data_essential_providers.dart';
import '../../routes/route_names.dart';
import '../../spk/application/spk_id_query.dart';
import '../../spk/spk.dart';
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
  Future<void> savedQueriesFunction() async {
    await ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedQueryFromRepository();
    await ref
        .read(autoDataUpdateFrameNotifierProvider.notifier)
        .getSavedCSQueryFromRepository();
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
                    ),
                (idSPKMapidTIUnitMapQuery) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .runSavedQueryFromRepository(
                        idSPKMapidTIUnitMapQuery: idSPKMapidTIUnitMapQuery))));

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
                    .runSavedCSQueryFromRepository(queryIds: queryIds))));

    // SPK Items
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
                  await ref
                      .read(updateFrameOfflineNotifierProvider.notifier)
                      .CUUpdateFrameOFFLINEStatus();
                  await ref
                      .read(updateCSOfflineNotifierProvider.notifier)
                      .CUUpdateCSOFFLINEStatus();
                  await ref
                      .read(updateSPKOfflineNotifierProvider.notifier)
                      .CUUpdateSPKOFFLINEStatus();
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


// // CSU Items
//     ref.listen<Option<Either<LocalFailure, List<CSUIDQuery>>>>(
//         autoDataUpdateFrameNotifierProvider.select(
//           (state) => state.FOSOAutoDataLocalUpdateFrameCSU,
//         ),
//         (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
//             () {},
//             (either) => either.fold(
//                 (failure) => showDialog(
//                       context: context,
//                       barrierDismissible: true,
//                       builder: (_) => VSimpleDialog(
//                         label: 'Error',
//                         labelDescription: failure.map(
//                             storage: (_) => 'storage penuh',
//                             format: (value) => 'error format $value',
//                             empty: (_) => 'empty'),
//                         asset: Assets.iconCrossed,
//                       ),
//                     ),
//                 (queryIds) => ref
//                         .read(autoDataUpdateFrameNotifierProvider.notifier)
//                         .isCSUQueryEmpty()
//                     ? () {}
//                     : () async {
//                         ref
//                             .read(autoDataUpdateFrameNotifierProvider.notifier)
//                             .changeSavedCSUQuery(csuIdQueries: queryIds);

//                         log('isCSUQueryEmpty ${ref.read(autoDataUpdateFrameNotifierProvider.notifier).isCSUQueryEmpty()}');
//                         log('isRunning ${ref.read(autoDataTimerNotifierProvider.select((value) => value.isRunning == false))}');
//                         await ref
//                             .read(autoDataUpdateFrameNotifierProvider.notifier)
//                             .runSavedCSUQueryFromRepository(queryIds: queryIds);
//                       }())));
