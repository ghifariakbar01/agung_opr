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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resetFrame();
      _getFrame();
    });
  }

  void _resetFrame() {
    ref.read(frameNotifierProvider.notifier).changeFrameList([]);
  }

  Future<void> _getFrame() async {
    final isOffline = ref.read(isOfflineStateProvider);

    if (!isOffline) {
      await _getFrameOnline();
    } else {
      await ref
          .read(frameOfflineNotifierProvider.notifier)
          .checkAndUpdateFrameOFFLINEStatusByPage(page: 0);

      final frameOfflineOrOnline = ref.read(frameOfflineNotifierProvider);
      await frameOfflineOrOnline.maybeWhen(
        hasOfflineStorage: () => ref
            .read(frameNotifierProvider.notifier)
            .getFrameListOFFLINEByPage(page: 0),
        orElse: () => _getFrameOnline(),
      );
    }
  }

  Future<void> _getFrameOnline() async {
    await ref.read(frameNotifierProvider.notifier).getFrameListByPage(page: 0);
    await ref
        .read(frameOfflineNotifierProvider.notifier)
        .checkAndUpdateFrameOFFLINEStatusByPage(page: 0);
  }

  @override
  Widget build(BuildContext context) {
    /*
      FRAME listener
      to change frame response
    */
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
                  final isSearching =
                      ref.read(frameSearchNotifierProvider).isSearching;

                  if (isSearching) {
                    _replaceFrame(frameResponse);
                    return;
                  }

                  if (frameResponse != []) {
                    _changeFrame(frameResponse);
                    return;
                  }
                })));

    final isLoading =
        ref.watch(frameNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [
        UnitScaffold(),
        Positioned(top: 100, child: DataUpdateLinearProgress()),
        LoadingOverlay(isLoading: isLoading)
      ],
    );
  }

  void _changeFrame(List<Frame> frameResponse) {
    final _prev = ref.read(frameNotifierProvider).frameList;
    ref
        .read(frameNotifierProvider.notifier)
        .changeFrameList([..._prev, ...frameResponse]);

    final int _len = _prev.length + frameResponse.length;

    /// RUN [changeAllFrame] TO UPDATE PLACEHOLDERS
    ref
        .read(updateFrameNotifierProvider.notifier)
        .changeFillEmptyList(length: _len, frame: [..._prev, ...frameResponse]);
  }

  void _replaceFrame(List<Frame> frameResponse) {
    ref
        .read(frameNotifierProvider.notifier)
        .changeFrameList([...frameResponse]);

    final int _len = frameResponse.length;

    /// RUN [changeAllFrame] TO UPDATE PLACEHOLDERS
    ref.read(updateFrameNotifierProvider.notifier).changeFillEmptyList(
      length: _len,
      frame: [...frameResponse],
    );
  }
}
