import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/assets.dart';
import '../../../domain/local_failure.dart';
import '../../widgets/alert_helper.dart';
import '../../widgets/v_dialogs.dart';
import 'update_frame_item.dart';

class UpdateFrameItemMiddle extends ConsumerWidget {
  const UpdateFrameItemMiddle(this.index);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<Option<Either<LocalFailure, Unit>>>(
        frameNotifierProvider.select(
          (state) => state.FOSOSaveFrame,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => AlertHelper.showSnackBar(
                      context,
                      message: failure.maybeMap(
                        storage: (_) =>
                            'Storage penuh. Tidak bisa menyimpan data FRAME SETELAH DISAVE',
                        format: (error) => 'Error format. $error',
                        orElse: () => '',
                      ),
                    ),
                (_) => showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => VSimpleDialog(
                        label: 'Sukses',
                        labelDescription:
                            'Sukses menyimpan Update Frame. Akan diupload di batch berikutnya.',
                        asset: Assets.iconChecked,
                      ),
                    ))));

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
