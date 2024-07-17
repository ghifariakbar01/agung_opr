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
import '../../../update_cs_disable/update_cs_disable_notifier.dart';
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

      await ref
          .read(updateCsDisableNotifierProvider.notifier)
          .getDisabled(idSPK: widget.spk.idSpk);

      await _fillFrame(widget.spk.idSpk);
      await _fillCSJenis();

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
                          orElse: () => 'err',
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

    ref.listen<Option<Either<LocalFailure, Unit>>>(
        updateFrameNotifierProvider.select(
          (state) => state.FOSOUpdateFrame,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => AlertHelper.showSnackBar(
                      context,
                      message: failure.map(
                        empty: (_) => 'Data kosong',
                        format: (error) => 'Error format. $error',
                        storage: (_) =>
                            'Storage penuh. Tidak bisa menyimpan data Update Frame',
                      ),
                    ),
                (_) => ref
                    .read(updateFrameOfflineNotifierProvider.notifier)
                    .CUUpdateFrameOFFLINEStatus())));

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
    final responseLEN = frameResponse.length;

    if (responseLEN != 0) {
      /// RUN [changeAllFrame] TO UPDATE PLACEHOLDERS
      ref.read(updateFrameNotifierProvider.notifier).changeFillEmptyList(
            length: responseLEN,
            frame: frameResponse,
          );

      ref.read(frameNotifierProvider.notifier).changeFrameList(
            frameResponse,
          );
    }
  }

  Future<void> _onCSJenis(List<CSJenis> csJenis) async {
    await Future.delayed(
        Duration(seconds: 1),
        () => ref
            .read(csJenisNotifierProvider.notifier)
            .changeCSJenisList(csJenis));

    await _fillCSItems();
  }

  _fillFrame(int idSpk) async {
    final isOffline = ref.read(isOfflineStateProvider);

    if (isOffline) {
      await ref
          .read(frameNotifierProvider.notifier)
          .getFrameListOFFLINE(idSPK: idSpk);
    } else {
      await _fillFrameOnline(idSpk);
      return;
    }

    await ref
        .read(frameOfflineNotifierProvider.notifier)
        .checkAndUpdateFrameOFFLINEStatus(idSPK: idSpk);

    final frameOfflineOrOnline = ref.read(frameOfflineNotifierProvider);
    await frameOfflineOrOnline.maybeWhen(
      hasOfflineStorage: () => ref
          .read(frameNotifierProvider.notifier)
          .getFrameListOFFLINE(idSPK: idSpk),
      orElse: () => _fillFrameOnline(idSpk),
    );
  }

  Future<void> _fillFrameOnline(int idSpk) async {
    await ref.read(frameNotifierProvider.notifier).getFrameList(idSPK: idSpk);
    await ref
        .read(frameOfflineNotifierProvider.notifier)
        .checkAndUpdateFrameOFFLINEStatus(idSPK: idSpk);
  }

  _fillCSJenis() async {
    final isOffline = ref.read(isOfflineStateProvider);
    if (!isOffline) {
      await _fillCSJenisOnline();
    }

    await ref
        .read(csJenisOfflineNotifierProvider.notifier)
        .checkAndUpdateCSJenisOFFLINEStatus();

    final csJenisOfflineOrOnline = ref.read(csJenisOfflineNotifierProvider);
    await csJenisOfflineOrOnline.maybeWhen(
      hasOfflineStorage: () =>
          ref.read(csJenisNotifierProvider.notifier).getCSJenisOFFLINE(),
      orElse: () => _fillCSJenisOnline(),
    );
  }

  _fillCSJenisOnline() async {
    await ref.read(csJenisNotifierProvider.notifier).getCSJenis();
    return ref
        .read(csJenisOfflineNotifierProvider.notifier)
        .checkAndUpdateCSJenisOFFLINEStatus();
  }

  _fillCSItems() async {
    final isOffline = ref.read(isOfflineStateProvider);
    if (!isOffline) {
      await _fillCSItemsOnline();
    }

    await ref
        .read(csItemOfflineNotifierProvider.notifier)
        .checkAndUpdateCSItemOFFLINEStatus();

    final csItemsOfflineOrOnline = ref.read(csItemOfflineNotifierProvider);
    await csItemsOfflineOrOnline.maybeWhen(
      hasOfflineStorage: () =>
          ref.read(csItemNotifierProvider.notifier).getCSItemsOFFLINE(),
      orElse: () => _fillCSItemsOnline(),
    );
  }

  _fillCSItemsOnline() async {
    await ref.read(csItemNotifierProvider.notifier).getCSItems();
    return ref
        .read(csItemOfflineNotifierProvider.notifier)
        .checkAndUpdateCSItemOFFLINEStatus();
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
    _initCSItems();
  }

  _initCSItems() {
    Map<int, List<CSItem>> csItemMap = {};
    ref.read(csItemNotifierProvider.notifier).changeCSItemsByIDList(csItemMap);

    final int _csID = ref.read(csItemNotifierProvider).selectedId;

    final List<int> csId =
        ref.read(csItemNotifierProvider.notifier).getCSId(_csID);

    // fill csItemMap
    final csValuesUncombined = csId.map((id) {
      final List<CSItem> list =
          ref.read(csItemNotifierProvider.notifier).getCSItemById(id);

      csItemMap.addAll({
        id: [...list]
      });

      return list;
    }).toList();

    final List<CSItem> csValuesCombined =
        csValuesUncombined.fold([], (prev, next) => prev + next);

    /// RUN [changeFillEmptyList] TO UPDATE PLACEHOLDERS
    ref.read(updateCSNotifierProvider.notifier).changeFillEmptyList(
          isNGLength: csValuesCombined.length,
        );

    return;
  }

  Future<void> _onCSItemsInit(List<CSItem> csItems) async {
    return ref.read(csItemNotifierProvider.notifier).changeCSItemsList(csItems);
  }
}
