import 'dart:developer';

import 'package:agung_opr/domain/local_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/remote_failure.dart';
import '../../../../shared/providers.dart';
import '../../../auto_data/view/data_update_linear_progress.dart';
import '../../../update_frame/frame.dart';
import '../../../widgets/alert_helper.dart';
import '../../../widgets/loading_overlay.dart';
import '../shared/csu_providers.dart';

import '../state/csu_items/csu_items.dart';
import '../state/csu_jenis_penyebab/csu_jenis_penyebab_item.dart';
import '../state/csu_ng/csu_ng_result.dart';
import 'csu_new_scaffold.dart';

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
      final Frame frame = ref.read(csuFrameNotifierProvider).frame;
      ref
          .read(updateCSUFrameNotifierProvider.notifier)
          .changeIdUnit(frame.idUnit);
      ref
          .read(updateCSUFrameNotifierProvider.notifier)
          .changeFrameName(frame.frame ?? '');

      // CSU ITEMS
      await _getCSUItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
      CSU Items listener 
      from _getCSUItems();
    */
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
                              orElse: () => '',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              parse: (value) => 'Parse $value',
                              storage: (_) =>
                                  'Storage penuh. Tidak bisa menyimpan data CSU ITEM',
                            ),
                          ),
                        ), (items) async {
                  log('items: $items');
                  if (items != []) {
                    ref
                        .read(csuItemsFrameNotifierProvider.notifier)
                        .changeCSUItems(items);

                    /// RUN [changeFillEmptyList] TO UPDATE NG PLACEHOLDERS
                    ref
                        .read(updateCSUFrameNotifierProvider.notifier)
                        .changeFillEmptyList(length: items.length);

                    // CSU JENIS
                    await ref
                        .read(jenisPenyebabFrameNotifierProvider.notifier)
                        .getCSUJenisItems();

                    if (widget.idCS != -1) {
                      await _getCSUNGByID(widget.idCS);
                    }
                  }
                })));

    ref.listen<Option<Either<RemoteFailure, List<CSUNGResult>>>>(
        csuFrameNotifierProvider.select(
          (state) => state.FOSOCSUNGResult,
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
                                  'Storage penuh. Tidak bisa menyimpan data HASIL CSU',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              parse: (value) => 'Parse $value',
                              orElse: () => '',
                            ),
                          ),
                        ), (csuNGResponse) {
                  log('FRAME CSU NG RESPONSE: $csuNGResponse');
                  if (csuNGResponse != []) {
                    ref
                        .read(updateCSUFrameNotifierProvider.notifier)
                        .changeFillNG(csuNGResult: csuNGResponse);
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

                  log('CSU RESPONSE: $CSUJenisResponse');
                  if (CSUJenisResponse != []) {
                    ref
                        .read(jenisPenyebabFrameNotifierProvider.notifier)
                        .changeCSUJenisItems(CSUJenisResponse);

                    // CSU PENYEBAB
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

                  log('CSUPenyebabResponse RESPONSE: $CSUPenyebabResponse');
                  if (CSUPenyebabResponse != []) {
                    ref
                        .read(jenisPenyebabFrameNotifierProvider.notifier)
                        .changeCSUPenyebabItems(CSUPenyebabResponse);
                  }
                })));

    /*
      CALLED Upon Saving Query
    */
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
                  _saveCSULastPage();
                  await ref
                      .read(updateCSUFrameOfflineNotifierProvider.notifier)
                      .CUUpdateCSUFrameOFFLINEStatus();

                  context.pop();
                })));

    final isLoading = ref.watch(
        updateCSUFrameNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [
        CSUNewScaffold(),
        Positioned(top: 100, child: DataUpdateLinearProgress()),
        LoadingOverlay(isLoading: isLoading)
      ],
    );
  }

  void _saveCSULastPage() {
    final Frame frame = ref.read(csuFrameNotifierProvider).frame;
    ref.read(csuLastPageProvider.notifier).state = frame;
  }

  Future<void> _getCSUItems() async {
    await ref
        .read(csuItemsOfflineNotifierProvider.notifier)
        .checkAndUpdateCSUItemsOFFLINEStatus();

    final csuItemsOfflineOrOnline = ref.read(csuItemsOfflineNotifierProvider);
    await csuItemsOfflineOrOnline.maybeWhen(
      hasOfflineStorage: () =>
          ref.read(csuItemsFrameNotifierProvider.notifier).getCSUItemsOFFLINE(),
      orElse: () async {
        await ref.read(csuItemsFrameNotifierProvider.notifier).getCSUItems();

        // CSU RESULT STORAGE
        await ref
            .read(csuItemsOfflineNotifierProvider.notifier)
            .checkAndUpdateCSUItemsOFFLINEStatus();
      },
    );
  }

  Future<void> _getCSUNGByID(int idCS) async {
    final isOffline = ref.read(isOfflineStateProvider);
    if (!isOffline) {
      await _getCSUNGByIdOnline(idCS);
      return;
    }

    await ref
        .read(csuNGByIDOfflineNotifierProvider.notifier)
        .checkAndUpdateCSUNGByIDOFFLINEStatus(idCS: idCS);

    final CSNGByID = ref.read(csuNGByIDOfflineNotifierProvider);
    await CSNGByID.maybeWhen(
      hasOfflineStorage: () => ref
          .read(csuFrameNotifierProvider.notifier)
          .getCSUNGByIdCSOFFLINE(idCS: widget.idCS),
      orElse: () => _getCSUNGByIdOnline(idCS),
    );
  }

  Future<void> _getCSUNGByIdOnline(int idCS) async {
    await ref
        .read(csuFrameNotifierProvider.notifier)
        .getCSUNGByIdCS(idCS: widget.idCS);

    // PENYEBAB CSU STORAGE
    await ref
        .read(csuNGByIDOfflineNotifierProvider.notifier)
        .checkAndUpdateCSUNGByIDOFFLINEStatus(idCS: idCS);
  }
}
