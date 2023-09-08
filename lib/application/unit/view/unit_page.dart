import 'dart:developer';

import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auto_data/view/data_update_linear_progress.dart';
import '../../update_frame/frame.dart';
import '../../widgets/alert_helper.dart';
import '../../widgets/loading_overlay.dart';
import 'unit_scaffold.dart';

class UnitPage extends ConsumerStatefulWidget {
  const UnitPage();

  @override
  ConsumerState<UnitPage> createState() => _UnitPageState();
}

class _UnitPageState extends ConsumerState<UnitPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final frameOfflineOrOnline = ref.watch(frameOfflineNotifierProvider);

      log('frameOfflineOrOnline $frameOfflineOrOnline');

      // debugger(message: 'called');

      // await spkOfflineOrOnline.maybeWhen(
      //   hasOfflineStorage: () =>
      //       ref.read(spkNotifierProvider.notifier).getSPKListOFFLINE(page: 0),
      //   orElse: () async {
      //     for (int i = 0; i < 5; i++) {
      //       ref.read(spkNotifierProvider.notifier).getSPKList(page: i);
      //     }

      //     await ref
      //         .read(spkOfflineNotifierProvider.notifier)
      //         .checkAndUpdateSPKOFFLINEStatus();
      //   },
      // );

      await ref.read(frameNotifierProvider.notifier).getFrameListWithoutSPK();

      await ref
          .read(frameOfflineNotifierProvider.notifier)
          .checkAndUpdateFrameOFFLINEStatus(idSPK: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<RemoteFailure, List<Frame>>>>(
        frameNotifierProvider.select(
          (state) => state.FOSOFrame,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => failure.maybeMap(
                          noConnection: (value) => ref
                              .read(isOfflineStateProvider.notifier)
                              .state = true,
                          orElse: () => AlertHelper.showSnackBar(
                            context,
                            message: failure.maybeMap(
                              storage: (_) =>
                                  'Storage penuh. Tidak bisa menyimpan data FRAME',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              parse: (value) => 'Parse $value',
                              orElse: () => '',
                            ),
                          ),
                        ), (frameResponse) {
                  /// SET [frameResponse] from GOT frameList
                  // debugger(message: 'called');
                  log('FRAME RESPONSE: $frameResponse');
                  if (frameResponse != []) {
                    ref
                        .read(frameNotifierProvider.notifier)
                        .changeFrameList(frameResponse);

                    final responseLEN = frameResponse.length;

                    ref
                        .read(frameNotifierProvider.notifier)
                        .changeFillEmptyFOSOSaveFrameList(length: responseLEN);

                    /// RUN [changeAllFrame] TO UPDATE PLACEHOLDERS
                    ref
                        .read(updateFrameNotifierProvider.notifier)
                        .changeFillEmptyList(
                            length: responseLEN, frame: frameResponse);
                  }
                })));

    final isLoading =
        ref.watch(frameNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [
        UnitScaffold(),
        Positioned(top: 15, child: DataUpdateLinearProgress()),
        LoadingOverlay(isLoading: isLoading)
      ],
    );
  }
}
