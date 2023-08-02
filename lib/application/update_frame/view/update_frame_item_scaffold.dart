import 'dart:developer';

import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/assets.dart';
import '../../widgets/alert_helper.dart';
import '../../widgets/v_dialogs.dart';
import '../shared/update_frame_providers.dart';
import 'update_frame_item.dart';
import 'update_frame_item_middle.dart';

class UpdateFrameItemScaffold extends ConsumerWidget {
  const UpdateFrameItemScaffold(this.index);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<Option<Either<LocalFailure, Unit>>>(
        updateFrameNotifierProvider.select(
          (state) => state.FOSOUpdateFrame,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => AlertHelper.showSnackBar(
                          context,
                          message: failure.maybeMap(
                            storage: (_) =>
                                'Storage penuh. Tidak bisa menyimpan data UPDATE FRAME',
                            format: (error) => 'Error format. $error',
                            orElse: () => '',
                          ),
                        ), (_) async {
                  final idSPK = ref.read(updateFrameNotifierProvider
                      .select((value) => value.idSPK));

                  final frame = ref.watch(updateFrameNotifierProvider
                      .select((value) => value.updateFrameList[index]));

                  debugger(message: 'called');

                  await ref
                      .read(frameNotifierProvider.notifier)
                      .saveFrameIndexedSPK(
                          idSPK: idSPK, index: index, newFrame: frame);
                })));

    final isLoading = ref.watch(updateFrameNotifierProvider
            .select((value) => value.isProcessing)) ||
        ref.watch(frameNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [
        UpdateFrameItemMiddle(index),
        // LoadingOverlay(isLoading: isLoading)
      ],
    );
  }
}
