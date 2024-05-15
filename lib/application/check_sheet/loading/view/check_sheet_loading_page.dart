// ignore_for_file: unused_result

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/local_failure.dart';
import '../../../../domain/remote_failure.dart';
import '../../../../shared/providers.dart';
import '../../../auto_data/view/data_update_linear_progress.dart';
import '../../../mode/mode_state.dart';
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

      await ref.refresh(fillFrameFutureProvider(widget.spk.idSpk).future);
      await ref.refresh(fillCSJenisFutureProvider.future);
      await ref.refresh(fillCSItemsFutureProvider.future);
      await ref
          .read(modelNotifierProvider.notifier)
          .getAndChangeModelListOFFLINE();
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
      FRAME LISTENER
      - On frame filled
    */
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
                          server: (value) => value.message ?? 'Server Error',
                          parse: (value) => 'Parse $value',
                          orElse: () => '',
                        ),
                      ),
                    ),
                _onFrame)));

    /*
      CS JENIS LISTENER
    */
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
                          parse: (value) => 'Error Saat Parse CS Jenis $value'),
                    ),
                _onCSJenis)));

    /*
      CS ITEMS LISTENER
    */
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
                          parse: (value) => 'Error Saat Parse CS Items $value'),
                    ),
                _onCSItems)));

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

  void _onFrame(List<Frame> frameResponse) {
    if (frameResponse != []) {
      ref.read(frameNotifierProvider.notifier).changeFrameList(frameResponse);

      final responseLEN = frameResponse.length;

      ref
          .read(frameNotifierProvider.notifier)
          .changeFillEmptyFOSOSaveFrameList(length: responseLEN);

      /// RUN [changeAllFrame] TO UPDATE PLACEHOLDERS
      ref
          .read(updateFrameNotifierProvider.notifier)
          .changeFillEmptyList(length: responseLEN, frame: frameResponse);
    }
  }

  Future<void> _onCSJenis(List<CSJenis> csJenis) async {
    await Future.delayed(
        Duration(seconds: 1),
        () => ref
            .read(csJenisNotifierProvider.notifier)
            .changeCSJenisList(csJenis));

    await ref
        .read(csJenisOfflineNotifierProvider.notifier)
        .checkAndUpdateCSJenisOFFLINEStatus();

    final csJenisOfflineOrOnline = ref.watch(csJenisOfflineNotifierProvider);

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

  /*
    csItemNotifierProvider,
    selectedSPKStateProvider,
    updateFrameNotifierProvider,
    updateSPKNotifierProvider,
    updateCSNotifierProvider,
    modeNotifierProvider,
  */
  Future<void> _onCSItems(List<CSItem> csItems) async {
    await _onCSItemsInit(csItems);
    await _initTheRest();
  }

  Future<void> _initTheRest() async {
    final SPK _currSPK = widget.spk;
    final int _idSPK = _currSPK.idSpk;

    ref.read(selectedSPKStateProvider.notifier).state = _currSPK;

    ref.read(updateFrameNotifierProvider.notifier).changeIdSPK(idSPK: _idSPK);
    ref
        .read(updateSPKNotifierProvider.notifier)
        .changeFillWithValue(spk: _currSPK);
    ref
        .read(updateCSNotifierProvider.notifier)
        .changeFillWithValue(spk: widget.spk);
    //
    final ModeState mode = ref.read(modeNotifierProvider);
    ref.read(updateCSNotifierProvider.notifier).changeTipe(mode);

    // CS ITEM
    await ref.refresh(fillCSItemsCombinedProvider.future);
  }

  Future<void> _onCSItemsInit(List<CSItem> csItems) async {
    await Future.delayed(
        Duration(seconds: 1),
        () => ref
            .read(csItemNotifierProvider.notifier)
            .changeCSItemsList(csItems));

    await ref
        .read(csItemOfflineNotifierProvider.notifier)
        .checkAndUpdateCSItemOFFLINEStatus();

    final csItemsOfflineOrOnline = ref.watch(csItemOfflineNotifierProvider);

    await csItemsOfflineOrOnline.maybeWhen(
      hasOfflineStorage: () =>
          ref.read(csItemNotifierProvider.notifier).getCSItemsOFFLINE(),
      orElse: () async {
        await ref.read(csItemNotifierProvider.notifier).getCSItem();

        await ref
            .read(csItemOfflineNotifierProvider.notifier)
            .checkAndUpdateCSItemOFFLINEStatus();
      },
    );
  }
}
