import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/assets.dart';
import '../../../domain/local_failure.dart';
import '../../widgets/v_dialogs.dart';
import 'update_frame_item.dart';

class UpdateFrameItemMiddle extends ConsumerWidget {
  const UpdateFrameItemMiddle(this.index);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<Option<Either<LocalFailure, Unit>>>(
        frameNotifierProvider.select(
          (state) => state.FOSOSaveFrame[index],
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold((failure) async {
                  await showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) => VSimpleDialog(
                      label: 'Gagal',
                      labelDescription: failure.maybeMap(
                        storage: (_) =>
                            'Storage penuh. Tidak bisa menyimpan data Frame ke ${index + 1} setelah disave.',
                        format: (error) => 'Error format. $error',
                        orElse: () => '',
                      ),
                      asset: Assets.iconChecked,
                    ),
                  );

                  ref.read(frameNotifierProvider.notifier).resetFOSOSaveFrame();
                }, (_) async {
                  final frameNotifier =
                      ref.read(frameNotifierProvider.notifier);

                  bool isLast = frameNotifier.isLastFOSO(index: index);
                  bool FOSOOK = frameNotifier.isFOSONotOK().toList().isEmpty;

                  //
                  if (isLast) {
                    FOSOOK
                        ? () async {
                            await showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (_) => VSimpleDialog(
                                label: 'Sukses',
                                labelDescription:
                                    'Sukses menyimpan Update Frame. Akan diupload setelah loading.',
                                asset: Assets.iconChecked,
                              ),
                            );
                            frameNotifier.resetFOSOSaveFrame();

                            await ref
                                .read(
                                    updateFrameOfflineNotifierProvider.notifier)
                                .CUUpdateFrameOFFLINEStatus();
                          }()
                        : () {};
                  }
                })));

    return Stack(
      children: [
        UpdateFrameItem(
          index: index,
        ),
        // LoadingOverlay(isLoading: isLoading)
      ],
    );
  }
}
