import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upgrader/upgrader.dart';

import '../../../constants/assets.dart';
import '../../../constants/constants.dart';
import '../../../domain/local_failure.dart';
import '../../../domain/remote_failure.dart';
import '../../../domain/user_failure.dart';
import '../../../shared/providers.dart';
import '../../auto_data/shared/auto_data_providers.dart';
import '../../auto_data/view/data_update_linear_progress.dart';
import '../../check_sheet/shared/state/cs_id_query.dart';
import '../../clear_data/clear_data_providers.dart';
import '../../model/shared/model_providers.dart';
import '../../network_state/network_state_notifier.dart';
import '../../spk/application/spk_id_query.dart';
import '../../widgets/alert_helper.dart';
import '../../widgets/loading_overlay.dart';
import '../../widgets/v_dialogs.dart';
import 'cranny_middle.dart';

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

    // Saved Queries
    Future<void> getSavedQueriesFunction() async {
      await ref
          .read(autoDataUpdateFrameNotifierProvider.notifier)
          .getSavedQueryFromRepository();
      await ref
          .read(autoDataUpdateFrameNotifierProvider.notifier)
          .getSavedCSQueryFromRepository();
      await ref
          .read(autoDataUpdateFrameNotifierProvider.notifier)
          .getSavedSPKQueryFromRepository();
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
                  return userParsed.fold(
                      (failure) => showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) => VSimpleDialog(
                              label: 'Error',
                              asset: Assets.iconCrossed,
                              labelDescription: failure.maybeMap(
                                orElse: () => '',
                                errorParsing: (error) =>
                                    'Error while parsing user. ${error.message}',
                              ),
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
                              initializeAndCheckData: () async {
                                await modelFunction();
                                await getSavedQueriesFunction();
                              },
                              initializeAutoData: () =>
                                  _startAutoData(getSavedQueriesFunction),
                              checkAndUpdateStatus: ref
                                  .read(authNotifierProvider.notifier)
                                  .checkAndUpdateAuthStatus,
                              sortDataFrameInSPK: ref
                                  .read(sortDataFormNotifierProvider.notifier)
                                  .sortDataFrameInSPK));
                })));

    // Sort Data
    ref.listen<Option<Either<RemoteFailure, Unit>>>(
        sortDataFormNotifierProvider.select(
          (state) => state.FOSOSPKSortData,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => VSimpleDialog(
                          label: 'Error',
                          asset: Assets.iconCrossed,
                          labelDescription: failure.maybeMap(
                            orElse: () => '',
                            parse: (value) => 'Error Parse $value',
                            server: (error) => 'Error Format Sort Data: $error',
                            storage: (_) =>
                                'mohon maaf storage anda penuh saat menyimpan frame dan spk',
                          ),
                        )),
                (_) {})));

    ref.listen(networkStateNotifierProvider, (__, _) {});
    ref.listen(isOfflineStateProvider, (previous, next) {
      if (previous == true && next == false) {
        ref.read(userNotifierProvider.notifier).getUser();
      }
    });

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

    // SPK
    ref.listen<Option<Either<LocalFailure, List<SPKIdQuery>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOAutoDataLocalUpdateFrameSPK,
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
                    .changeSavedSPKQuery(spkIdQueries: csIdQueries))));

    final isSubmitting = ref
        .watch(sortDataFormNotifierProvider.select((value) => value.isGetting));

    return SafeArea(
      child: UpgradeAlert(
        key: UniqueKey(),
        upgrader: Upgrader(
          showLater: false,
          showIgnore: false,
          canDismissDialog: false,
          minAppVersion: '2.0.0',
          messages: MyUpgraderMessages(),
          dialogStyle: UpgradeDialogStyle.cupertino,
        ),
        child: Stack(
          children: [
            CrannyMiddle(),
            Positioned(top: 100, child: DataUpdateLinearProgress()),
            LoadingOverlay(isLoading: isSubmitting),
          ],
        ),
      ),
    );
  }

  Future<void> _startAutoData(
      Future<void> Function() getSavedQueriesFunction) async {
    final autoDatanotifier = ref.read(autoDataTimerNotifierProvider.notifier);
    return autoDatanotifier.startTimer(Constants.dataIntervalTimerInSeconds,
        getSavedQueryFunction: getSavedQueriesFunction);
  }
}

class MyUpgraderMessages extends UpgraderMessages {
  @override
  String get body =>
      'Mohon lakukan update dengan versi aplikasi Mobile Carrier OPR CCR terbaru.';

  @override
  String get buttonTitleIgnore => '-';

  @override
  String get buttonTitleLater => 'Nanti Saja';
}
