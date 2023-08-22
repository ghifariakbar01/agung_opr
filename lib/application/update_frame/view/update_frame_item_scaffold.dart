import 'dart:developer';

import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/alert_helper.dart';
import '../shared/update_frame_providers.dart';
import 'update_frame_item_middle.dart';

class UpdateFrameItemScaffold extends ConsumerStatefulWidget {
  const UpdateFrameItemScaffold(this.index);

  final int index;

  @override
  ConsumerState<UpdateFrameItemScaffold> createState() =>
      _UpdateFrameItemScaffoldState();
}

class _UpdateFrameItemScaffoldState
    extends ConsumerState<UpdateFrameItemScaffold> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(updateFrameNotifierProvider.notifier)
          .changeIndex(index: widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<LocalFailure, Unit>>>(
        updateFrameNotifierProvider.select(
          (state) => state.FOSOUpdateFrame[widget.index],
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

                  final custnm = ref.read(frameNotifierProvider
                      .select((value) => value.frameList[widget.index].custnm));

                  debugger(message: 'called');

                  log('INDEX: ${widget.index}');

                  await ref
                      .read(frameNotifierProvider.notifier)
                      .saveFrameIndexedSPK(
                          idSPK: updateFrameProvider.idSPK,
                          index: widget.index,
                          custnm: custnm ?? '-',
                          newFrame: updateFrameProvider
                              .updateFrameList[widget.index]);
                })));

    return Stack(
      children: [
        UpdateFrameItemMiddle(widget.index),
        // LoadingOverlay(isLoading: isLoading)
      ],
    );
  }
}
