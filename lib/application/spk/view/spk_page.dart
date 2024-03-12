import 'package:agung_opr/application/spk/shared/spk_providers.dart';
import 'package:agung_opr/application/spk/spk.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auto_data/view/data_update_linear_progress.dart';
import '../../widgets/alert_helper.dart';
import '../../widgets/loading_overlay.dart';
import 'spk_scaffold.dart';

class SPKPage extends ConsumerStatefulWidget {
  const SPKPage();

  @override
  ConsumerState<SPKPage> createState() => _SPKPageState();
}

class _SPKPageState extends ConsumerState<SPKPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => loadSpkOnlineOrOffline());
  }

  Future<void> loadSpkOnlineOrOffline() async {
    final isOffline = ref.read(isOfflineStateProvider);

    if (isOffline) {
      await ref.read(spkNotifierProvider.notifier).getSPKListOFFLINE(page: 0);
    } else {
      for (int i = 0; i < 5; i++) {
        await ref.read(spkNotifierProvider.notifier).getSPKList(page: i);
      }

      await ref
          .read(spkOfflineNotifierProvider.notifier)
          .checkAndUpdateSPKOFFLINEStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<RemoteFailure, List<SPK>>>>(
        spkNotifierProvider.select(
          (state) => state.FOSOSPK,
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
                                  'Storage penuh. Tidak bisa menyimpan data SPK',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              orElse: () => '',
                            ),
                          ),
                        ), (SPKResponse) {
                  final oldSPK = ref.read(spkNotifierProvider).spkList;
                  final page = ref.read(scrollPageProvider);

                  ref.read(spkNotifierProvider.notifier).processSPKList(
                        newSPK: SPKResponse,
                        page: page,
                        changeSPK: () => ref
                            .read(spkNotifierProvider.notifier)
                            .changeSPKList(newSPK: SPKResponse, oldSPK: oldSPK),
                        replaceSPK: () => ref
                            .read(spkNotifierProvider.notifier)
                            .replaceSPKList(SPKResponse),
                        changeIsMore: () => ref
                            .read(spkNotifierProvider.notifier)
                            .changeIsMore(false),
                      );
                })));

    final isLoading =
        ref.watch(spkNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [
        SPKScaffold(),
        Positioned(top: 100, child: DataUpdateLinearProgress()),
        LoadingOverlay(isLoading: isLoading)
      ],
    );
  }
}
