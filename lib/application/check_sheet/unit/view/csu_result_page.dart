import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/state/csu_trips.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/remote_failure.dart';
import '../../../../shared/providers.dart';
import '../../../auto_data/view/data_update_linear_progress.dart';
import '../../../widgets/alert_helper.dart';
import '../shared/csu_providers.dart';
import '../state/csu_result.dart';
import 'csu_result_scaffold.dart';

class CSUResultPage extends ConsumerStatefulWidget {
  const CSUResultPage();

  @override
  ConsumerState<CSUResultPage> createState() => _CSUResultPageState();
}

class _CSUResultPageState extends ConsumerState<CSUResultPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final index =
          ref.read(updateFrameNotifierProvider.select((value) => value.index));
      final frame = ref.read(
          frameNotifierProvider.select((value) => value.frameList[index]));

      final String frameName = frame.frame ?? '';
      final int frameId = frame.idUnit;

      // TRIPS STORAGE
      await ref
          .read(csuTripsOfflineNotifierProvider.notifier)
          .checkAndUpdateTripsOFFLINEStatus(idUnit: frameId);

      final tripsOfflineOrOnline = ref.watch(csuTripsOfflineNotifierProvider);

      log('tripsOfflineOrOnline $tripsOfflineOrOnline');

      await tripsOfflineOrOnline.maybeWhen(
        hasOfflineStorage: () => ref
            .read(csuFrameNotifierProvider.notifier)
            .getCSUTripsByFrameIdOFFLINE(idUnit: frameId),
        orElse: () async {
          await ref
              .read(csuFrameNotifierProvider.notifier)
              .getCSUTripsByFrameId(idUnit: frameId, frameName: frameName);

          await ref
              .read(csuTripsOfflineNotifierProvider.notifier)
              .checkAndUpdateTripsOFFLINEStatus(idUnit: frameId);
        },
      );

      // CSU ITEMS STORAGE

      //
      ref.read(csuFrameNotifierProvider.notifier).changeFrame(frame);
      ref.read(csuFrameNotifierProvider.notifier).changeFrameName(frameName);

      await ref
          .read(csuFrameNotifierProvider.notifier)
          .getCSUByFrameName(frameName: frameName);

      await ref
          .read(csuFrameNotifierProvider.notifier)
          .getCSUTripsByFrameId(idUnit: frameId, frameName: frameName);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<RemoteFailure, List<CSUResult>>>>(
        csuFrameNotifierProvider.select(
          (state) => state.FOSOCSUResult,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => failure.maybeMap(
                          noConnection: (value) =>
                              ref.read(isOfflineProvider.notifier).state = true,
                          orElse: () => AlertHelper.showSnackBar(
                            context,
                            message: failure.maybeMap(
                              storage: (_) =>
                                  'Storage penuh. Tidak bisa menyimpan data HASIL CSU',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              parse: (value) => 'Parse $value',
                              orElse: () => '',
                            ),
                          ),
                        ), (csuResponse) {
                  /// SET [csuResponse] from GOT csuResultList
                  // debugger(message: 'called');
                  log('FRAME CSU RESPONSE: $csuResponse');
                  if (csuResponse != []) {
                    ref
                        .read(csuFrameNotifierProvider.notifier)
                        .changeCSUResultList(csuResponse);
                  }
                })));

    ref.listen<Option<Either<RemoteFailure, List<CSUTrips>>>>(
        csuFrameNotifierProvider.select(
          (state) => state.FOSOCSUTripsResult,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => failure.maybeMap(
                          noConnection: (value) =>
                              ref.read(isOfflineProvider.notifier).state = true,
                          orElse: () => AlertHelper.showSnackBar(
                            context,
                            message: failure.maybeMap(
                              storage: (_) =>
                                  'Storage penuh. Tidak bisa menyimpan data HASIL CSU TRIPS',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              parse: (value) => 'Parse $value',
                              orElse: () => '',
                            ),
                          ),
                        ), (csuResponseTrips) {
                  /// SET [csuResponseTrips] from GOT csuResultList
                  // debugger(message: 'called');
                  log('FRAME CSU RESPONSE TRIPS: $csuResponseTrips');
                  if (csuResponseTrips != []) {
                    ref
                        .read(csuFrameNotifierProvider.notifier)
                        .changeCSUTripsResultList(csuResponseTrips);
                  }
                })));

    final isLoading =
        ref.watch(frameNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [
        CSUResultScaffold(),
        Positioned(top: 15, child: DataUpdateLinearProgress()),
        LoadingOverlay(isLoading: isLoading)
      ],
    );
  }
}
