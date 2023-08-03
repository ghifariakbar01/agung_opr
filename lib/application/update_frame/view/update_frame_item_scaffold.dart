import 'dart:developer';

import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/alert_helper.dart';
import '../shared/update_frame_providers.dart';
import 'update_frame_item_middle.dart';

class UpdateFrameItemScaffold extends ConsumerWidget {
  const UpdateFrameItemScaffold(this.index);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<Option<Either<LocalFailure, Unit>>>(
        updateFrameNotifierProvider.select(
          (state) => state.FOSOUpdateFrame[index],
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
                  final updateFrameProvider =
                      ref.read(updateFrameNotifierProvider);

                  debugger(message: 'called');

                  log('INDEX: $index');

                  await ref
                      .read(frameNotifierProvider.notifier)
                      .saveFrameIndexedSPK(
                          idSPK: updateFrameProvider.idSPK,
                          index: index,
                          newFrame: updateFrameProvider.updateFrameList[index]);
                })));

    return Stack(
      children: [
        UpdateFrameItemMiddle(index),
        // LoadingOverlay(isLoading: isLoading)
      ],
    );
  }
}
