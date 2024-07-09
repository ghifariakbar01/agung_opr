import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/alert_helper.dart';
import '../../widgets/loading_overlay.dart';
import '../csu_mst_gate.dart';
import '../providers/gate_providers.dart';
import 'gate_scaffold.dart';

class GatePage extends ConsumerStatefulWidget {
  const GatePage();

  @override
  ConsumerState<GatePage> createState() => _GatePageState();
}

class _GatePageState extends ConsumerState<GatePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isOffline = ref.read(isOfflineStateProvider);
      if (!isOffline) {
        await ref.read(gateNotifierProvider.notifier).getGates();
        await ref
            .read(gateOfflineNotifierProvider.notifier)
            .checkAndUpdateGateOFFLINEStatus();
        return;
      }

      await ref
          .read(gateOfflineNotifierProvider.notifier)
          .checkAndUpdateGateOFFLINEStatus();

      final gateOfflineOrOnline = ref.watch(gateOfflineNotifierProvider);

      await gateOfflineOrOnline.maybeWhen(
        hasOfflineStorage: () =>
            ref.read(gateNotifierProvider.notifier).getGatesOFFLINE(),
        orElse: () async {
          await ref.read(gateNotifierProvider.notifier).getGates();
          await ref
              .read(gateOfflineNotifierProvider.notifier)
              .checkAndUpdateGateOFFLINEStatus();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<RemoteFailure, List<CSUMSTGate>>>>(
        gateNotifierProvider.select(
          (state) => state.FOSOGate,
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
                            orElse: () => '',
                            server: (value) => value.message ?? 'Server Error',
                            storage: (_) =>
                                'Storage penuh. Tidak bisa menyimpan data gate.'),
                      ),
                    ),
                (gateResponse) => ref
                    .read(gateNotifierProvider.notifier)
                    .changeGateList(gateResponse))));

    final isLoading =
        ref.watch(gateNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [GateScaffold(), LoadingOverlay(isLoading: isLoading)],
    );
  }
}
