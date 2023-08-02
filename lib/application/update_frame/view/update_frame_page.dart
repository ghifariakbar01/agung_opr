import 'dart:developer';

import 'package:agung_opr/application/update_frame/frame.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/application/update_frame/view/update_frame_scaffold.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/remote_failure.dart';
import '../../../shared/providers.dart';
import '../../widgets/alert_helper.dart';

class UpdateFramePage extends ConsumerStatefulWidget {
  const UpdateFramePage({required this.idSPK});

  final int idSPK;

  @override
  ConsumerState<UpdateFramePage> createState() => _UpdateFramePageState();
}

class _UpdateFramePageState extends ConsumerState<UpdateFramePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(updateFrameNotifierProvider.notifier)
          .changeIdSPK(idSPK: widget.idSPK);

      await ref
          .read(frameOfflineNotifierProvider.notifier)
          .checkAndUpdateFrameOFFLINEStatus(idSPK: widget.idSPK);

      final frameOfflineOrOnline = ref.watch(frameOfflineNotifierProvider);

      log('frameOfflineOrOnline $frameOfflineOrOnline');

      await frameOfflineOrOnline.maybeWhen(
        hasOfflineStorage: () => ref
            .read(frameNotifierProvider.notifier)
            .getFrameListOFFLINE(idSPK: widget.idSPK),
        orElse: () async {
          await ref
              .read(frameNotifierProvider.notifier)
              .getFrameList(idSPK: widget.idSPK);

          await ref
              .read(frameOfflineNotifierProvider.notifier)
              .checkAndUpdateFrameOFFLINEStatus(idSPK: widget.idSPK);
        },
      );
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
                          noConnection: (value) =>
                              ref.read(isOfflineProvider.notifier).state = true,
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
                  debugger(message: 'called');
                  log('FRAME RESPONSE: $frameResponse');
                  if (frameResponse != []) {
                    ref
                        .read(frameNotifierProvider.notifier)
                        .changeFrameList(frameResponse);

                    final responseLEN = frameResponse.length;

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
      children: [UpdateFrameScaffold(), LoadingOverlay(isLoading: isLoading)],
    );
  }
}
