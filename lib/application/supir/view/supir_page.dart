import 'package:agung_opr/application/supir/supir.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/alert_helper.dart';
import '../../widgets/loading_overlay.dart';

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
      final supirOfflineOrOnline = ref.watch(supirOfflineNotifierProvider);

      await supirOfflineOrOnline.maybeWhen(
        hasOfflineStorage: () => ref
            .read(supirNotifierProvider.notifier)
            .getSupirListOFFLINE(page: 0),
        orElse: () async {
          for (int i = 0; i < 5; i++) {
            await ref
                .read(supirNotifierProvider.notifier)
                .getSupirList(page: i);
          }

          await ref
              .read(supirOfflineNotifierProvider.notifier)
              .checkAndUpdateSupirOFFLINEStatus();
        },
      );
    });
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
                          noConnection: (value) => ref
                              .read(isOfflineStateProvider.notifier)
                              .state = true,
                          orElse: () => AlertHelper.showSnackBar(
                            context,
                            message: failure.maybeMap(
                              storage: (_) =>
                                  'Storage penuh. Tidak bisa menyimpan data MODEL.',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              orElse: () => '',
                            ),
                          ),
                        ), (SupirResponse) {
                  final oldSupir = ref.read(supirNotifierProvider).supirList;
                  final page = ref.read(supirNotifierProvider).page;
                  ref.read(supirNotifierProvider.notifier).processSupirList(
                        newSupir: SupirResponse,
                        page: page,
                        changeSupir: () => ref
                            .read(supirNotifierProvider.notifier)
                            .changeSupirList(
                                newSupir: SupirResponse, oldSupir: oldSupir),
                        replaceSupir: () => ref
                            .read(supirNotifierProvider.notifier)
                            .replaceSupirList(SupirResponse),
                        changeIsMore: () => ref
                            .read(supirNotifierProvider.notifier)
                            .changeIsMore(false),
                      );
                })));

    final isLoading =
        ref.watch(supirNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [SupirScaffold(), LoadingOverlay(isLoading: isLoading)],
    );
  }
}
