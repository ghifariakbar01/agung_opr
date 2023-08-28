import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/check_sheet/unit/state/csu_items.dart';
import 'package:agung_opr/application/check_sheet/unit/state/csu_jenis_penyebab_item.dart';
import 'package:agung_opr/application/check_sheet/unit/view/csu_new_scaffold.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/remote_failure.dart';
import '../../../../shared/providers.dart';
import '../../../auto_data/view/data_update_linear_progress.dart';
import '../../../routes/route_names.dart';
import '../../../widgets/alert_helper.dart';

class CSUNewPage extends ConsumerStatefulWidget {
  const CSUNewPage({this.idCS = -1});

  @override
  ConsumerState<CSUNewPage> createState() => _CSUNewPageState();

  final int idCS;
}

class _CSUNewPageState extends ConsumerState<CSUNewPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final frame =
          ref.read(csuFrameNotifierProvider.select((value) => value.frame));

      // debugger(message: 'called');

      ref
          .read(updateCSUFrameNotifierProvider.notifier)
          .changeIdUnit(frame.idUnit);

      ref
          .read(updateCSUFrameNotifierProvider.notifier)
          .changeFrameName(frame.frame ?? '');

      await ref.read(csuItemsFrameNotifierProvider.notifier).getCSUItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<RemoteFailure, List<CSUItems>>>>(
        csuItemsFrameNotifierProvider.select(
          (state) => state.FOSOUpdateCSUItems,
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
                                  'Storage penuh. Tidak bisa menyimpan data CSU ITEM',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              parse: (value) => 'Parse $value',
                              orElse: () => '',
                            ),
                          ),
                        ), (CSUResponse) async {
                  /// SET [frameResponse] from GOT frameList
                  // debugger(message: 'called');
                  log('CSU RESPONSE: $CSUResponse');
                  if (CSUResponse != []) {
                    ref
                        .read(csuItemsFrameNotifierProvider.notifier)
                        .changeCSUItems(CSUResponse);

                    final responseLEN = CSUResponse.length;

                    /// RUN [changeFillEmptyList] TO UPDATE NG PLACEHOLDERS
                    ref
                        .read(updateCSUFrameNotifierProvider.notifier)
                        .changeFillEmptyList(length: responseLEN);

                    await ref
                        .read(jenisPenyebabFrameNotifierProvider.notifier)
                        .getCSUJenisItems();

                    if (widget.idCS != -1) {
                      await ref
                          .read(csuFrameNotifierProvider.notifier)
                          .getCSUNGByIdCS(idCS: widget.idCS);
                    }

                    final NGItems = ref.read(csuFrameNotifierProvider
                        .select((value) => value.csuNGResultList));

                    ref
                        .read(updateCSUFrameNotifierProvider.notifier)
                        .changeFillNG(csuNGResult: NGItems);
                  }
                })));

    ref.listen<Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>>(
        jenisPenyebabFrameNotifierProvider.select(
          (state) => state.FOSOUpdateCSUJenisItems,
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
                                  'Storage penuh. Tidak bisa menyimpan data CSU JENIS ITEM',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              parse: (value) => 'Parse $value',
                              orElse: () => '',
                            ),
                          ),
                        ), (CSUJenisResponse) async {
                  /// SET [frameResponse] from GOT frameList
                  // debugger(message: 'called');
                  log('CSU RESPONSE: $CSUJenisResponse');
                  if (CSUJenisResponse != []) {
                    ref
                        .read(jenisPenyebabFrameNotifierProvider.notifier)
                        .changeCSUJenisItems(CSUJenisResponse);

                    await ref
                        .read(jenisPenyebabFrameNotifierProvider.notifier)
                        .getCSUPenyebabItems();
                  }
                })));

    ref.listen<Option<Either<RemoteFailure, List<CSUJenisPenyebabItem>>>>(
        jenisPenyebabFrameNotifierProvider.select(
          (state) => state.FOSOUpdateCSUPenyebabItems,
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
                                  'Storage penuh. Tidak bisa menyimpan data CSU PENYEBAB ITEM',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              parse: (value) => 'Parse $value',
                              orElse: () => '',
                            ),
                          ),
                        ), (CSUPenyebabResponse) async {
                  /// SET [frameResponse] from GOT frameList
                  // debugger(message: 'called');
                  log('CSU RESPONSE: $CSUPenyebabResponse');
                  if (CSUPenyebabResponse != []) {
                    ref
                        .read(jenisPenyebabFrameNotifierProvider.notifier)
                        .changeCSUPenyebabItems(CSUPenyebabResponse);
                  }
                })));

    ref.listen<Option<Either<LocalFailure, Unit>>>(
        updateCSUFrameNotifierProvider.select(
          (state) => state.FOSOUpdateCSU,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => AlertHelper.showSnackBar(
                          context,
                          message: failure.map(
                            storage: (_) =>
                                'Storage penuh. Tidak bisa menyimpan data CSU PENYEBAB ITEM',
                            empty: (_) => 'Data kosong',
                            format: (error) => 'Error format. $error',
                          ),
                        ), (_) async {
                  // debugger(message: 'called');
                  await ref
                      .read(updateCSUFrameOfflineNotifierProvider.notifier)
                      .CUUpdateCSUFrameOFFLINEStatus();

                  context.pushReplacementNamed(RouteNames.dataUpdateQueryName);
                })));

    // await ref
    //     .read(updateFrameOfflineNotifierProvider
    //         .notifier)
    //     .CUUpdateFrameOFFLINEStatus();

    final isLoading = ref.watch(
        updateCSUFrameNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [
        CSUNewScaffold(),
        Positioned(top: 15, child: DataUpdateLinearProgress()),
        LoadingOverlay(isLoading: isLoading)
      ],
    );
  }
}
