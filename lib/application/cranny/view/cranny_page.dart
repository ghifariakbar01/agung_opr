import 'dart:developer';

import 'package:agung_opr/application/cranny/view/cranny_middle.dart';
import 'package:agung_opr/application/model/shared/model_providers.dart';
import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/assets.dart';
import '../../../domain/local_failure.dart';
import '../../../domain/user_failure.dart';
import '../../../shared/providers.dart';
import '../../auto_data/shared/auto_data_providers.dart';
import '../../auto_data/view/data_update_linear_progress.dart';
import '../../check_sheet/unit/shared/csu_providers.dart';
import '../../check_sheet/unit/state/csu_id_query.dart';
import '../../update_frame/shared/update_frame_providers.dart';
import '../../widgets/alert_helper.dart';
import '../../widgets/v_dialogs.dart';

/// [SPK] Initialization
/// [USER] Initialization
/// [MODEL] Initialization
///

const dataIntervalTimerInSeconds = 120;

class CrannyPage extends ConsumerStatefulWidget {
  const CrannyPage();

  @override
  ConsumerState<CrannyPage> createState() => _CrannyPageState();
}

class _CrannyPageState extends ConsumerState<CrannyPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (_) async => await ref.read(userNotifierProvider.notifier).getUser());
  }

  @override
  Widget build(BuildContext context) {
    // SPK function get and update offline status
    Future<void> spkFunction() async {
      // GET [500] LATEST DATA
      for (int i = 0; i < 5; i++) {
        await ref.read(spkNotifierProvider.notifier).getSPKList(page: i);
      }

      await ref
          .read(spkOfflineNotifierProvider.notifier)
          .checkAndUpdateSPKOFFLINEStatus();
    }

    // MODEL function get and update offline status
    Future<void> modelFunction() async {
      // GET [500] LATEST DATA
      for (int i = 0; i < 5; i++) {
        await ref.read(modelNotifierProvider.notifier).getModelList(page: i);
      }

      await ref
          .read(modelOfflineNotifierProvider.notifier)
          .checkAndUpdateModelOFFLINEStatus();
    }

    // GET AND SAVE ALL DATA
    Future<void> getAndSaveAllData() async {
      await spkFunction();
      await modelFunction();
      await ref
          .read(autoDataUpdateFrameNotifierProvider.notifier)
          .getSavedQueryFromRepository();

      await ref
          .read(autoDataUpdateFrameNotifierProvider.notifier)
          .getSavedCSUQueryFromRepository();
    }

    ref.listen<Option<Either<UserFailure, String?>>>(
      userNotifierProvider.select(
        (state) => state.failureOrSuccessOption,
      ),
      (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
        () {},
        (either) => either.fold(
            (failure) => showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) => VSimpleDialog(
                    label: 'Error',
                    labelDescription: failure.maybeMap(
                        empty: (_) => 'No user found',
                        unknown: (unkn) => '${unkn.errorCode} ${unkn.message}',
                        orElse: () => ''),
                    asset: Assets.iconCrossed,
                  ),
                ), (userString) {
          final userParsed =
              ref.read(userNotifierProvider.notifier).parseUser(userString);

          userParsed.fold(
              (failure) => showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) => VSimpleDialog(
                      label: 'Error',
                      labelDescription: failure.maybeMap(
                          errorParsing: (error) =>
                              'Error while parsing user. ${error.message}',
                          orElse: () => ''),
                      asset: Assets.iconCrossed,
                    ),
                  ),
              (userParsed) => ref
                  .read(userNotifierProvider.notifier)
                  .onUserParsed(
                    user: userParsed,
                    initializeDioRequest: () =>
                        ref.read(dioRequestProvider).addAll({
                      "username": "${userParsed.nama}",
                      "password": "${userParsed.password}",
                    }),
                    initializeAndCheckData: () => getAndSaveAllData(),
                    initializeAutoData: () => ref
                        .read(autoDataTimerNotifierProvider.notifier)
                        .startTimer(dataIntervalTimerInSeconds,
                            getSavedUpdateFrame: () async {
                      await ref
                          .read(autoDataUpdateFrameNotifierProvider.notifier)
                          .getSavedQueryFromRepository();

                      await ref
                          .read(updateFrameOfflineNotifierProvider.notifier)
                          .CUUpdateFrameOFFLINEStatus();
                    }, getSavedUpdateCSUFrame: () async {
                      await ref
                          .read(autoDataUpdateFrameNotifierProvider.notifier)
                          .getSavedCSUQueryFromRepository();

                      await ref
                          .read(updateCSUFrameOfflineNotifierProvider.notifier)
                          .CUUpdateCSUFrameOFFLINEStatus();
                    }),
                    checkAndUpdateStatus: () => ref
                        .read(authNotifierProvider.notifier)
                        .checkAndUpdateAuthStatus(),
                  ));
        }),
      ),
    );

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
                    .changeSavedQuery(
                        idSPKMapidTIUnitMapQuery: idSPKMapidTIUnitMapQuery))));

    // CSU
    ref.listen<Option<Either<LocalFailure, List<CSUIDQuery>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOAutoDataLocalUpdateFrameCSU,
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
                (csuIdQueries) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .changeSavedCSUQuery(csuIdQueries: csuIdQueries))));

    // final isSubmitting = ref.watch(
    //   autoDataUpdateFrameNotifierProvider.select((state) => state.isGetting),
    // );

    return Stack(
      children: [
        CrannyMiddle(),
        Positioned(top: 15, child: DataUpdateLinearProgress()),
        LoadingOverlay(isLoading: false),
      ],
    );
  }
}
