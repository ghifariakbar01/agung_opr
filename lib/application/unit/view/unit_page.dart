import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auto_data/view/data_update_linear_progress.dart';
import '../../update_frame/frame.dart';
import '../../../common/widgets/alert_helper.dart';
import '../../../common/widgets/loading_overlay.dart';
import 'unit_scaffold.dart';

class UnitPage extends ConsumerStatefulWidget {
  const UnitPage({Key? key}) : super(key: key);

  @override
  ConsumerState<UnitPage> createState() => _UnitPageState();
}

class _UnitPageState extends ConsumerState<UnitPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reset();
      _resetFrame();
      _getFrame();
    });
  }

  void _resetFrame() {
    ref.read(frameNotifierProvider.notifier).changeFrameList([]);
  }

  void _reset() {
    ref.read(isAtBottomUnitPage.notifier).state = false;
    ref.read(scrollUnitPage.notifier).state = 0;
  }

  void _isNotAtBottom() {
    ref.read(isAtBottomUnitPage.notifier).state = false;
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
                    noConnection: (value) =>
                        ref.read(isOfflineStateProvider.notifier).state = true,
                    orElse: () => AlertHelper.showSnackBar(
                      context,
                      message: failure.maybeMap(
                        storage: (_) =>
                            'Storage penuh. Tidak bisa menyimpan data FRAME',
                        server: (value) => value.message ?? 'Server Error',
                        parse: (value) => 'Parse $value',
                        orElse: () => '',
                      ),
                    ),
                  ),
                  (list) {
                    _isNotAtBottom();
                    ref.read(frameNotifierProvider.notifier).addFrameList(list);
                  },
                )));

    final isLoading = ref.watch(frameNotifierProvider.select(
      (value) => value.isProcessing,
    ));

    return Stack(
      children: [
        UnitScaffold(),
        Positioned(top: 100, child: DataUpdateLinearProgress()),
        LoadingOverlay(isLoading: isLoading)
      ],
    );
  }
}
