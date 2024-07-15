import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/remote_failure.dart';
import '../../../../shared/providers.dart';
import '../../../auto_data/view/data_update_linear_progress.dart';
import '../../../widgets/alert_helper.dart';
import '../../../widgets/loading_overlay.dart';
import '../shared/csu_providers.dart';

import '../state/csu_items/csu_items.dart';
import '../state/csu_jenis_penyebab/csu_jenis_penyebab_item.dart';
import '../state/csu_ng/csu_ng_result.dart';
import '../state/csu_posisi/csu_posisi.dart';
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
      final frame = ref.read(csuFrameNotifierProvider).frame;

      ref
          .read(updateCSUFrameNotifierProvider.notifier)
          .changeIdUnitAndFrameName(
            frame.idUnit,
            frame.frame ?? '',
          );

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
                  if (items != []) {
                    ref
                        .read(csuItemsFrameNotifierProvider.notifier)
                        .changeCSUItems(items);

                    ref
                        .read(updateCSUFrameNotifierProvider.notifier)
                        .processNewCSUItems(items: items);

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
                        ), (csuJenisItems) async {
                  if (csuJenisItems != []) {
                    ref
                        .read(jenisPenyebabFrameNotifierProvider.notifier)
                        .changeCSUJenisItems(csuJenisItems);

                    await ref
                        .read(jenisPenyebabFrameNotifierProvider.notifier)
                        .getCSUPosisiItems();
                  }
                })));

    ref.listen<Option<Either<RemoteFailure, List<CSUPosisi>>>>(
        jenisPenyebabFrameNotifierProvider.select(
          (state) => state.FOSOUpdateCSUPosisiItems,
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
                                  'Storage penuh. Tidak bisa menyimpan data CSU Posisi Item',
                            ),
                          ),
                        ), (csuPosisiItems) async {
                  if (csuPosisiItems != []) {
                    ref
                        .read(jenisPenyebabFrameNotifierProvider.notifier)
                        .changeCSUPosisiItems(csuPosisiItems);
                  }
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

  Future<void> _getCSUItems() async {
    final offline = ref.read(isOfflineStateProvider);
    if (offline) {
      await ref
          .read(csuItemsOfflineNotifierProvider.notifier)
          .checkAndUpdateCSUItemsOFFLINEStatus();

      final csuItemsOfflineOrOnline = ref.read(csuItemsOfflineNotifierProvider);
      await csuItemsOfflineOrOnline.maybeWhen(
          hasOfflineStorage: () => ref
              .read(csuItemsFrameNotifierProvider.notifier)
              .getCSUItemsOFFLINE(),
          orElse: () => _getCSUItemsOnline());
    } else {
      await _getCSUItemsOnline();
    }
  }

  Future<void> _getCSUNGByID(int idCS) async {
    final offline = ref.read(isOfflineStateProvider);
    if (offline) {
      await ref
          .read(csuNGByIDOfflineNotifierProvider.notifier)
          .checkAndUpdateCSUNGByIDOFFLINEStatus(idCS: idCS);

      final CSNGByID = ref.read(csuNGByIDOfflineNotifierProvider);
      await CSNGByID.maybeWhen(
          hasOfflineStorage: () => ref
              .read(csuFrameNotifierProvider.notifier)
              .getCSUNGByIdCSOFFLINE(idCS: widget.idCS),
          orElse: () => _getCSUNGByIdOnline(idCS));
    } else {
      await _getCSUNGByIdOnline(idCS);
    }
  }

  Future<void> _getCSUNGByIdOnline(int idCS) async {
    await ref
        .read(csuFrameNotifierProvider.notifier)
        .getCSUNGByIdCS(idCS: widget.idCS);

    await ref
        .read(csuNGByIDOfflineNotifierProvider.notifier)
        .checkAndUpdateCSUNGByIDOFFLINEStatus(idCS: idCS);
  }

  Future<void> _getCSUItemsOnline() async {
    await ref.read(csuItemsFrameNotifierProvider.notifier).getCSUItems();

    await ref
        .read(csuItemsOfflineNotifierProvider.notifier)
        .checkAndUpdateCSUItemsOFFLINEStatus();
  }
}
