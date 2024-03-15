import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/local_failure.dart';
import '../../../../domain/remote_failure.dart';
import '../../../../shared/providers.dart';
import '../../../auto_data/view/data_update_linear_progress.dart';
import '../../../model/shared/model_providers.dart';
import '../../../spk/spk.dart';
import '../../../update_frame/frame.dart';
import '../../../update_frame/shared/update_frame_providers.dart';
import '../../../update_spk/providers/update_spk_providers.dart';
import '../../../widgets/alert_helper.dart';
import '../../../widgets/loading_overlay.dart';
import '../../shared/providers/cs_providers.dart';
import '../../shared/state/cs_item.dart';
import '../../shared/state/cs_jenis.dart';
import 'check_sheet_loading_scaffold.dart';

class CheckSheetLoadingPage extends ConsumerStatefulWidget {
  const CheckSheetLoadingPage({required this.spk});

  @override
  ConsumerState<CheckSheetLoadingPage> createState() =>
      _CheckSheetLoadingPageState();

  final SPK spk;
}

class _CheckSheetLoadingPageState extends ConsumerState<CheckSheetLoadingPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(updateCSNotifierProvider.notifier).changeFillInitial();
      ref.read(updateCSNotifierProvider.notifier).changeSelectedSPK(widget.spk);
      ref.read(updateCSNotifierProvider.notifier).changeSelectedSPK(widget.spk);

      await _getFrameListBySpk();
      await _getCSJenisList();
      await _getCSItemsList();
      await ref
          .read(modelNotifierProvider.notifier)
          .getAndChangeModelListOFFLINE();
    });
  }

  Future<void> _getFrameListBySpk() async {
    final isOffline = ref.read(isOfflineStateProvider);
    if (isOffline) {
      return ref
          .read(frameNotifierProvider.notifier)
          .getFrameListOFFLINE(idSPK: widget.spk.idSpk);
    }

    await ref
        .read(frameOfflineNotifierProvider.notifier)
        .checkAndUpdateFrameOFFLINEStatus(idSPK: widget.spk.idSpk);

    final frameOfflineOrOnline = ref.read(frameOfflineNotifierProvider);
    await frameOfflineOrOnline.maybeWhen(
      hasOfflineStorage: () => ref
          .read(frameNotifierProvider.notifier)
          .getFrameListOFFLINE(idSPK: widget.spk.idSpk),
      orElse: () async {
        await ref
            .read(frameNotifierProvider.notifier)
            .getFrameList(idSPK: widget.spk.idSpk);
        await ref
            .read(frameOfflineNotifierProvider.notifier)
            .checkAndUpdateFrameOFFLINEStatus(idSPK: widget.spk.idSpk);
      },
    );
  }

  Future<void> _getCSJenisList() async {
    final isOffline = ref.read(isOfflineStateProvider);
    if (isOffline) {
      return ref.read(csJenisNotifierProvider.notifier).getCSJenisOFFLINE();
    }

    await ref
        .read(csJenisOfflineNotifierProvider.notifier)
        .checkAndUpdateCSJenisOFFLINEStatus();

    final csJenisOfflineOrOnline = ref.read(csJenisOfflineNotifierProvider);
    await csJenisOfflineOrOnline.maybeWhen(
      hasOfflineStorage: () =>
          ref.read(csJenisNotifierProvider.notifier).getCSJenisOFFLINE(),
      orElse: () async {
        await ref.read(csJenisNotifierProvider.notifier).getCSJenis();
        await ref
            .read(csJenisOfflineNotifierProvider.notifier)
            .checkAndUpdateCSJenisOFFLINEStatus();
      },
    );
  }

  Future<void> _getCSItemsList() async {
    final isOffline = ref.read(isOfflineStateProvider);
    if (isOffline) {
      return ref.read(csItemNotifierProvider.notifier).getCSItemsOFFLINE();
    }

    await ref
        .read(csItemOfflineNotifierProvider.notifier)
        .checkAndUpdateCSItemOFFLINEStatus();

    final csItemsOfflineOrOnline = ref.read(csItemOfflineNotifierProvider);
    await csItemsOfflineOrOnline.maybeWhen(
      hasOfflineStorage: () =>
          ref.read(csItemNotifierProvider.notifier).getCSItemsOFFLINE(),
      orElse: () async {
        await ref.read(csItemNotifierProvider.notifier).getCSItems();
        await ref
            .read(csItemOfflineNotifierProvider.notifier)
            .checkAndUpdateCSItemOFFLINEStatus();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  /// SET [frameResponse] from GOT frameList
                  // debugger(message: 'called');
                  log('FRAME RESPONSE: $frameResponse');
                  if (frameResponse != []) {
                    ref
                        .read(frameNotifierProvider.notifier)
                        .changeFrameList(frameResponse);

                    final responseLEN = frameResponse.length;

                    ref
                        .read(frameNotifierProvider.notifier)
                        .changeFillEmptyFOSOSaveFrameList(length: responseLEN);

                    /// RUN [changeAllFrame] TO UPDATE PLACEHOLDERS
                    ref
                        .read(updateFrameNotifierProvider.notifier)
                        .changeFillEmptyList(
                            length: responseLEN, frame: frameResponse);
                  }
                })));

    // debugger();
    // CS JENIS
    ref.listen<Option<Either<RemoteFailure, List<CSJenis>>>>(
        csJenisNotifierProvider.select((value) => value.FOSOCSJenis),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => AlertHelper.showSnackBar(
                          context,
                          message: failure.map(
                              noConnection: (value) =>
                                  'Error Saat Mengambil CS Jenis Tidak Ada Koneksi',
                              storage: (_) =>
                                  'Error Storage penuh saat menyimpan CS Jenis',
                              server: (value) =>
                                  'Error Saat Mengambil CS Jenis $value',
                              parse: (value) =>
                                  'Error Saat Parse CS Jenis $value'),
                        ), (csJenis) async {
                  await Future.delayed(
                      Duration(seconds: 1),
                      () => ref
                          .read(csJenisNotifierProvider.notifier)
                          .changeCSJenisList(csJenis));

                  await ref
                      .read(csItemOfflineNotifierProvider.notifier)
                      .checkAndUpdateCSItemOFFLINEStatus();

                  final csItemsOfflineOrOnline =
                      ref.watch(csItemOfflineNotifierProvider);

                  await csItemsOfflineOrOnline.maybeWhen(
                    hasOfflineStorage: () => ref
                        .read(csItemNotifierProvider.notifier)
                        .getCSItemsOFFLINE(),
                    orElse: () async {
                      await ref
                          .read(csItemNotifierProvider.notifier)
                          .getCSItem();

                      await ref
                          .read(csItemOfflineNotifierProvider.notifier)
                          .checkAndUpdateCSItemOFFLINEStatus();
                    },
                  );
                })));

    // CS ITEMS
    ref.listen<Option<Either<RemoteFailure, List<CSItem>>>>(
        csItemNotifierProvider.select((value) => value.FOSOCSItem),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => AlertHelper.showSnackBar(
                          context,
                          message: failure.map(
                              noConnection: (value) =>
                                  'Error Saat Mengambil CS Items Tidak Ada Koneksi',
                              storage: (_) =>
                                  'Error Storage penuh saat menyimpan CS Items',
                              server: (value) =>
                                  'Error Saat Mengambil CS Items $value',
                              parse: (value) =>
                                  'Error Saat Parse CS Items $value'),
                        ), (csItems) async {
                  await Future.delayed(
                      Duration(seconds: 1),
                      () => ref
                          .read(csItemNotifierProvider.notifier)
                          .changeCSItemsList(csItems));

                  final idSPK = widget.spk.idSpk;
                  ref.read(selectedSPKStateProvider.notifier).state =
                      widget.spk;

                  ref
                      .read(updateSPKNotifierProvider.notifier)
                      .changeFillWithValue(spk: widget.spk);
                  ref
                      .read(updateCSNotifierProvider.notifier)
                      .changeidSPK(idSPK);
                  ref
                      .read(updateFrameNotifierProvider.notifier)
                      .changeIdSPK(idSPK: idSPK);

                  // debugger();

                  // CS ITEM
                  Map<int, List<CSItem>> csItemMap = {};

                  final csItem = ref.read(csItemNotifierProvider);

                  final List<int> csId = ref
                      .read(csItemNotifierProvider.notifier)
                      .getCSId(csItem.selectedId);

                  log('csItemsByID csId $csId');

                  // fill csItemMap
                  final csValuesUncombined = csId.map((id) {
                    final List<CSItem> list = ref
                        .read(csItemNotifierProvider.notifier)
                        .getCSItemById(id);

                    csItemMap.addAll({
                      id: [...list]
                    });

                    return list;
                  }).toList();

                  final List<CSItem> csValuesCombined =
                      csValuesUncombined.fold([], (prev, next) => prev + next);

                  log('csItemsByID $csValuesUncombined csItemMap $csValuesCombined');

                  /// RUN [changeAllFrame] TO UPDATE PLACEHOLDERS
                  ref
                      .read(updateCSNotifierProvider.notifier)
                      .changeFillEmptyList(
                        length: csValuesCombined.length,
                      );
                  ref
                      .read(updateCSNotifierProvider.notifier)
                      .changeFillWithValue(spk: widget.spk);
                  //
                  final mode = ref.read(modeNotifierProvider);
                  ref.read(updateCSNotifierProvider.notifier).changeTipe(mode);
                  //
                  ref
                      .read(csItemNotifierProvider.notifier)
                      .changeCSItemsByIDList(csItemMap);
                })));

    // SUCCESS LISTENER
    ref.listen<Option<Either<LocalFailure, Unit>>>(
        updateCSNotifierProvider.select(
          (state) => state.FOSOUpdateCS,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => AlertHelper.showSnackBar(
                      context,
                      message: failure.map(
                        storage: (_) =>
                            'Storage penuh. Tidak bisa menyimpan data Update Check Sheet',
                        empty: (_) => 'Data kosong',
                        format: (error) => 'Error format. $error',
                      ),
                    ),
                (_) => ref
                    .read(updateCSOfflineNotifierProvider.notifier)
                    .CUUpdateCSOFFLINEStatus())));

    // SUCCESS LISTENER
    ref.listen<Option<Either<LocalFailure, Unit>>>(
        updateSPKNotifierProvider.select(
          (state) => state.FOSOUpdateSPK,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => AlertHelper.showSnackBar(
                      context,
                      message: failure.map(
                        storage: (_) =>
                            'Storage penuh. Tidak bisa menyimpan data Update Spk',
                        empty: (_) => 'Data kosong',
                        format: (error) => 'Error format. $error',
                      ),
                    ),
                (_) => ref
                    .read(updateSPKOfflineNotifierProvider.notifier)
                    .CUUpdateSPKOFFLINEStatus())));

    final isLoading = ref.watch(
            frameNotifierProvider.select((value) => value.isProcessing)) ||
        ref.watch(
            updateFrameNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [
        CheckSheetLoadingScaffold(),
        Positioned(top: 100, child: DataUpdateLinearProgress()),
        LoadingOverlay(isLoading: isLoading)
      ],
    );
  }
}
