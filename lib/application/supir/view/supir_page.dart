import 'package:agung_opr/application/supir/supir.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/widgets/alert_helper.dart';
import '../../../common/widgets/loading_overlay.dart';

import '../shared/supir_providers.dart';
import 'supir_scaffold.dart';

class SupirPage extends ConsumerStatefulWidget {
  const SupirPage();

  @override
  ConsumerState<SupirPage> createState() => _SupirPageState();
}

class _SupirPageState extends ConsumerState<SupirPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isOnline = ref.read(isOfflineStateProvider) == false;
      if (isOnline) {
        await _getSupirOnline();
      }

      final supirOfflineOrOnline = ref.read(supirOfflineNotifierProvider);
      await supirOfflineOrOnline.maybeWhen(
        hasOfflineStorage: () => ref
            .read(supirNotifierProvider.notifier)
            .getSupirListOFFLINE(page: 0),
        orElse: () async {
          await _getSupirOnline();
        },
      );
    });
  }

  Future<void> _getSupirOnline() async {
    for (int i = 0; i < 1; i++) {
      await ref.read(supirNotifierProvider.notifier).getSupirList(page: i);
    }

    await ref
        .read(supirOfflineNotifierProvider.notifier)
        .checkAndUpdateSupirOFFLINEStatus();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<RemoteFailure, List<Supir>>>>(
        supirNotifierProvider.select(
          (state) => state.FOSOSupir,
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
                            'Storage penuh. Tidak bisa menyimpan data MODEL.',
                        server: (value) => value.message ?? 'Server Error',
                        orElse: () => '',
                      ),
                    ),
                  ),
                  ref.read(supirNotifierProvider.notifier).replaceSupirList,
                )));

    final isLoading = ref.watch(
      supirNotifierProvider.select((value) => value.isProcessing),
    );

    return Stack(
      children: [
        SupirScaffold(),
        LoadingOverlay(isLoading: isLoading),
      ],
    );
  }
}
