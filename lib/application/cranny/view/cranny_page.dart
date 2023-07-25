import 'dart:developer';

import 'package:agung_opr/application/cranny/view/cranny_scaffold.dart';
import 'package:agung_opr/application/model/shared/model_providers.dart';
import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/assets.dart';
import '../../../domain/user_failure.dart';
import '../../../shared/providers.dart';
import '../../auto_data/shared/auto_data_providers.dart';
import '../../widgets/v_dialogs.dart';

/// [SPK] Initialization
/// [USER] Initialization
/// [MODEL] Initialization
///

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
                        .read(autoDataNotifierProvider.notifier)
                        .startTimerAutoData(
                            getAndSaveDataOffline: () => getAndSaveAllData()),
                    checkAndUpdateStatus: () => ref
                        .read(authNotifierProvider.notifier)
                        .checkAndUpdateAuthStatus(),
                  ));
        }),
      ),
    );

    return Stack(
      children: [CrannyScaffold(), LoadingOverlay(isLoading: false)],
    );
  }
}
