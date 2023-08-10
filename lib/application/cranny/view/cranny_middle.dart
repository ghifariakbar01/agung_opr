import 'dart:developer';

import 'package:agung_opr/domain/remote_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/assets.dart';
import '../../../domain/local_failure.dart';
import '../../auto_data/shared/auto_data_providers.dart';
import '../../update_frame/shared/update_frame_providers.dart';
import '../../update_frame/update_frame_offline_state.dart';
import '../../widgets/alert_helper.dart';
import '../../widgets/v_dialogs.dart';
import 'cranny_scaffold.dart';

final autoDataUpdateFutureProvider = FutureProvider((ref) async {});

class CrannyMiddle extends ConsumerStatefulWidget {
  const CrannyMiddle();

  @override
  ConsumerState<CrannyMiddle> createState() => _CrannyMiddleState();
}

class _CrannyMiddleState extends ConsumerState<CrannyMiddle> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<LocalFailure, Map<String, Map<String, String>>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOSPKAutoDataGetSavedUpdateFrame,
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
                        .isMapEmpty(idSPKMapidTIUnitMapQuery)
                    ? () {}
                    : ref.read(autoDataTimerNotifierProvider
                            .select((value) => value.isRunning == false))
                        ? () {
                            debugger(message: 'called');

                            log('isMapEmpty ${ref.read(autoDataUpdateFrameNotifierProvider.notifier).isMapEmpty(idSPKMapidTIUnitMapQuery)}');
                            log('isRunning ${ref.read(autoDataTimerNotifierProvider.select((value) => value.isRunning == false))}');
                            ref
                                .read(autoDataUpdateFrameNotifierProvider
                                    .notifier)
                                .runSavedQueryFromRepository(
                                    idSPKMapidTIUnitMapQuery:
                                        idSPKMapidTIUnitMapQuery);
                          }()
                        : () {})));

    ref.listen<Option<Either<RemoteFailure, Unit>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOSPKAutoDataUpdateFrame,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => AlertHelper.showSnackBar(
                      context,
                      message: failure.map(
                        storage: (_) => 'storage penuh',
                        noConnection: (_) => 'tidak ada koneksi',
                        parse: (error) => 'error parse $error',
                        server: (error) => 'error server $error',
                      ),
                    ),
                (_) => showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => VSimpleDialog(
                        label: 'Sukses',
                        labelDescription:
                            'Sukses melakukan query Update Frame.',
                        asset: Assets.iconChecked,
                      ),
                    ))));

    // final isSubmitting = ref.watch(
    //   autoDataUpdateFrameNotifierProvider.select((state) => state.isGetting),
    // );

    return CrannyScaffold();
  }
}
