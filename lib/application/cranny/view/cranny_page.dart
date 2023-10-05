import 'dart:developer';

import 'package:agung_opr/style/style.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';

import '../../../constants/assets.dart';
import '../../../constants/constants.dart';
import '../../../domain/local_failure.dart';
import '../../../domain/user_failure.dart';
import '../../../shared/providers.dart';
import '../../auto_data/shared/auto_data_providers.dart';
import '../../auto_data/view/data_update_linear_progress.dart';
import '../../check_sheet/shared/providers/cs_providers.dart';
import '../../check_sheet/shared/state/cs_id_query.dart';
import '../../check_sheet/unit/shared/csu_providers.dart';
import '../../check_sheet/unit/state/csu_id_query.dart';
import '../../clear_data/clear_data_providers.dart';
import '../../customer/shared/customer_providers.dart';
import '../../gate/providers/gate_providers.dart';
import '../../history/history.dart';
import '../../model/shared/model_providers.dart';
import '../../spk/shared/spk_providers.dart';
import '../../spk/spk.dart';
import '../../supir/shared/supir_providers.dart';
import '../../update_frame/shared/update_frame_providers.dart';
import '../../widgets/alert_helper.dart';
import '../../widgets/loading_overlay.dart';
import '../../widgets/v_dialogs.dart';
import 'cranny_middle.dart';

/**
 * [SPK] Initialization
 * [USER] Initialization
 * [MODEL] Initialization
 * [CSJenis] Initialization
 * [CSItem] Initialization
 *
 */

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
        (_) => ref.read(userNotifierProvider.notifier).getUser());
  }

  @override
  Widget build(BuildContext context) {
    // Saved Queries
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

    // CS function
    Future<void> CSFunction() async {
      // GET CS Jenis AND Item
      await ref.read(csJenisNotifierProvider.notifier).getCSJenis();
      await ref.read(csItemNotifierProvider.notifier).getCSItems();

      await ref
          .read(csJenisOfflineNotifierProvider.notifier)
          .checkAndUpdateCSJenisOFFLINEStatus();
      await ref
          .read(csItemOfflineNotifierProvider.notifier)
          .checkAndUpdateCSItemOFFLINEStatus();
    }

    Future<void> csJenisFunction() async {
      // debugger();

      await ref
          .read(jenisPenyebabFrameNotifierProvider.notifier)
          .getCSUJenisItems();

      // JENIS CSU STORAGE
      await ref
          .read(jenisPenyebabOfflineNotifierProvider.notifier)
          .checkAndUpdateCSUJenisPenyebabItemsOFFLINEStatus();
    }

    Future<void> csPenyebabFunction() async {
      await ref
          .read(jenisPenyebabFrameNotifierProvider.notifier)
          .getCSUPenyebabItems();

      await ref
          .read(jenisPenyebabOfflineNotifierProvider.notifier)
          .checkAndUpdateCSUJenisPenyebabItemsOFFLINEStatus();
    }

    // SPK function get and update offline status
    Future<void> spkFunction() async {
      // GET [100] LATEST DATA
      await ref.read(spkNotifierProvider.notifier).getSPKList(page: 0);

      await ref
          .read(spkOfflineNotifierProvider.notifier)
          .checkAndUpdateSPKOFFLINEStatus();
    }

    Future<void> frameFunction() async {
      // GET [500] LATEST DATA
      for (int i = 0; i < 5; i++) {
        await ref
            .read(frameNotifierProvider.notifier)
            .getFrameListWithoutSPK(page: i);
      }

      await ref
          .read(frameOfflineNotifierProvider.notifier)
          .checkAndUpdateFrameOFFLINEStatus(idSPK: 0);
    }

    // MODEL function get and update offline status
    Future<void> modelFunction() async {
      // GET [500] LATEST DATA
      for (int i = 0; i < 5; i++) {
        await ref.read(modelNotifierProvider.notifier).getModelList(page: i);
      }

      final list = await ref
          .read(modelNotifierProvider.notifier)
          .initModelListOFFLINE(limit: 5);

      ref.read(modelNotifierProvider.notifier).replaceModelList(list);

      await ref
          .read(modelOfflineNotifierProvider.notifier)
          .checkAndUpdateModelOFFLINEStatus();
    }

    // CSU ITEMS
    Future<void> csuItemsFunction() async {
      // GET [500] LATEST DATA
      await ref.read(csuItemsFrameNotifierProvider.notifier).getCSUItems();

      await ref
          .read(csuItemsOfflineNotifierProvider.notifier)
          .checkAndUpdateCSUItemsOFFLINEStatus();
    }

    // CUSTOMER function get and update offline status
    Future<void> customerFunction() async {
      // GET [500] LATEST DATA
      for (int i = 0; i < 5; i++) {
        await ref
            .read(customerNotifierProvider.notifier)
            .getCustomerList(page: i);
      }

      await ref
          .read(customerOfflineNotifierProvider.notifier)
          .checkAndUpdateCustomerOFFLINEStatus();
    }

    // SUPIR function get and update offline status
    Future<void> supirFunction() async {
      for (int i = 0; i < 5; i++) {
        await ref.read(supirNotifierProvider.notifier).getSupirList(page: i);
      }

      await ref
          .read(supirOfflineNotifierProvider.notifier)
          .checkAndUpdateSupirOFFLINEStatus();
    }

    // GATES function get and update offline status
    Future<void> gatesFunction() async {
      await ref.read(gateNotifierProvider.notifier).getGates();

      await ref
          .read(gateOfflineNotifierProvider.notifier)
          .checkAndUpdateGateOFFLINEStatus();
    }

    // GET AND SAVE ALL DATA
    Future<void> getAndSaveAllData() async {
      await CSFunction();
      await spkFunction();
      await frameFunction();
      await modelFunction();
      await supirFunction();
      await gatesFunction();
      await csJenisFunction();
      await csuItemsFunction();
      await customerFunction();
      await csPenyebabFunction();
      await savedQueriesFunction();
    }

    //
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
                                unknown: (unkn) =>
                                    '${unkn.errorCode} ${unkn.message}',
                                orElse: () => ''),
                            asset: Assets.iconCrossed,
                          ),
                        ), (userString) async {
                  final userParsed = ref
                      .read(userNotifierProvider.notifier)
                      .parseUser(userString);

                  // GET RECENT USER VALUES FROM DB
                  await userParsed.fold(
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
                      (user) => ref
                          .read(userNotifierProvider.notifier)
                          .onUserParsed(
                            user: user,
                            initializeDioRequest: () =>
                                ref.read(dioRequestProvider).addAll({
                              "username": "${user.nama}",
                              "password": "${user.password}",
                            }),
                            initializeAndCheckData: () => getAndSaveAllData(),
                            initializeAutoData: () => ref
                                .read(autoDataTimerNotifierProvider.notifier)
                                .startTimer(
                              Constants.dataIntervalTimerInSeconds,
                              getSavedUpdateFrame: () async {
                                await ref
                                    .read(autoDataUpdateFrameNotifierProvider
                                        .notifier)
                                    .getSavedQueryFromRepository();
                                await ref
                                    .read(updateFrameOfflineNotifierProvider
                                        .notifier)
                                    .CUUpdateFrameOFFLINEStatus();
                              },
                              getSavedUpdateCSUFrame: () async {
                                await ref
                                    .read(autoDataUpdateFrameNotifierProvider
                                        .notifier)
                                    .getSavedCSUQueryFromRepository();
                                await ref
                                    .read(updateCSUFrameOfflineNotifierProvider
                                        .notifier)
                                    .CUUpdateCSUFrameOFFLINEStatus();
                              },
                              getSavedUpdateCSFrame: () async {
                                await ref
                                    .read(autoDataUpdateFrameNotifierProvider
                                        .notifier)
                                    .getSavedCSQueryFromRepository();
                                await ref
                                    .read(updateCSOfflineNotifierProvider
                                        .notifier)
                                    .CUUpdateCSOFFLINEStatus();
                              },
                            ),
                            checkAndUpdateStatus: () => ref
                                .read(authNotifierProvider.notifier)
                                .checkAndUpdateAuthStatus(),
                          ));
                })));

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

    ref.listen<Option<Either<LocalFailure, List<History>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOAutoDataLocalHistory,
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
                            storage: (_) => 'storage penuh',
                            format: (error) => 'Error Format: $error',
                            orElse: () => ''),
                        asset: Assets.iconCrossed,
                      ),
                    ),
                (histories) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .changeSavedHistories(histories: histories))));

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
    // CS
    ref.listen<Option<Either<LocalFailure, List<CSIDQuery>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOAutoDataLocalUpdateFrameCS,
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
                (csIdQueries) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .changeSavedCSQuery(csIdQueries: csIdQueries))));

    // final isSubmitting = ref.watch(
    //   autoDataUpdateFrameNotifierProvider.select((state) => state.isGetting),
    // );

    return UpgradeAlert(
      upgrader: Upgrader(
        showLater: false,
        showIgnore: false,
        messages: MyUpgraderMessages(),
        dialogStyle: UpgradeDialogStyle.cupertino,
      ),
      child: Stack(
        children: [
          CrannyMiddle(),
          Positioned(top: 45, child: DataUpdateLinearProgress()),
          LoadingOverlay(isLoading: false),
        ],
      ),
    );
  }
}

class MyUpgraderMessages extends UpgraderMessages {
  @override
  String get body =>
      'Mohon lakukan update dengan versi aplikasi Mobile Carrier OPR CCR terbaru.';

  @override
  String get buttonTitleIgnore => '-';
}
