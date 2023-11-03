import 'dart:developer';

import 'package:agung_opr/application/model/model.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/alert_helper.dart';
import '../../widgets/loading_overlay.dart';
import '../shared/model_providers.dart';
import 'model_scaffold.dart';

class ModelPage extends ConsumerStatefulWidget {
  const ModelPage();

  @override
  ConsumerState<ModelPage> createState() => _ModelPageState();
}

class _ModelPageState extends ConsumerState<ModelPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final modelOfflineOrOnline = ref.watch(modelOfflineNotifierProvider);

      log('modelOfflineOrOnline $modelOfflineOrOnline');

      // debugger(message: 'called');

      await modelOfflineOrOnline.maybeWhen(
        hasOfflineStorage: () => ref
            .read(modelNotifierProvider.notifier)
            .getModelListOFFLINE(page: 0),
        orElse: () async {
          for (int i = 0; i < 5; i++) {
            await ref
                .read(modelNotifierProvider.notifier)
                .getModelList(page: i);
          }

          await ref
              .read(modelOfflineNotifierProvider.notifier)
              .checkAndUpdateModelOFFLINEStatus();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<RemoteFailure, List<Model>>>>(
        modelNotifierProvider.select(
          (state) => state.FOSOModel,
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
                        ), (SPKResponse) async {
                  final oldModel =
                      ref.read(modelNotifierProvider.notifier).state.modelList;

                  final page =
                      ref.read(modelNotifierProvider.notifier).state.page;

                  await ref
                      .read(modelNotifierProvider.notifier)
                      .getAndChangeModelListOFFLINE();

                  ref.read(modelNotifierProvider.notifier).processModelList(
                        newModel: SPKResponse,
                        page: page,
                        changeModel: () => ref
                            .read(modelNotifierProvider.notifier)
                            .changeModelList(
                                newModel: SPKResponse, oldModel: oldModel),
                        replaceModel: () => ref
                            .read(modelNotifierProvider.notifier)
                            .replaceModelList(SPKResponse),
                        changeIsMore: () => ref
                            .read(modelNotifierProvider.notifier)
                            .changeIsMore(false),
                      );
                })));

    final isLoading =
        ref.watch(modelNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [ModelScaffold(), LoadingOverlay(isLoading: isLoading)],
    );
  }
}
