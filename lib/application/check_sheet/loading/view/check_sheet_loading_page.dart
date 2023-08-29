import 'package:agung_opr/application/check_sheet/shared/providers/cs_providers.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/local_failure.dart';
import '../../../../shared/providers.dart';
import '../../../auto_data/view/data_update_linear_progress.dart';
import '../../../routes/route_names.dart';
import '../../../spk/spk.dart';
import '../../../update_frame/shared/update_frame_providers.dart';
import '../../../widgets/alert_helper.dart';
import '../../shared/state/cs_item.dart';
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
      final idSPK = widget.spk.idSpk;
      ref.read(selectedSPKStateProvider.notifier).state = widget.spk;
      ref.read(updateCSNotifierProvider.notifier).changeidSPK(idSPK);

      // CS ITEM
      Map<int, List<CSItem>> csItemMap = {};

      final csItem = ref.read(csItemNotifierProvider);

      final csId =
          ref.read(csItemNotifierProvider.notifier).getCSId(csItem.selectedId);

      List<CSItem> csItemsByID = csId.foldIndexed([], (index, previous, cs) {
        final list =
            ref.read(csItemNotifierProvider.notifier).getCSItemById(cs);

        csItemMap.addAll({
          cs: [...list]
        });

        return previous + list;
      });

      /// RUN [changeAllFrame] TO UPDATE PLACEHOLDERS
      ref.read(updateCSNotifierProvider.notifier).changeFillEmptyList(
            length: csItemsByID.length,
          );
      ref
          .read(updateCSNotifierProvider.notifier)
          .changeFillWithValue(spk: widget.spk);
      ref
          .read(csItemNotifierProvider.notifier)
          .changeCSItemsByIDList(csItemMap);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                                'Storage penuh. Tidak bisa menyimpan data CS PENYEBAB ITEM',
                            empty: (_) => 'Data kosong',
                            format: (error) => 'Error format. $error',
                          ),
                        ), (_) async {
                  // debugger(message: 'called');
                  await ref
                      .read(updateCSOfflineNotifierProvider.notifier)
                      .CUUpdateCSOFFLINEStatus();

                  context.pushReplacementNamed(RouteNames.dataUpdateQueryName);
                })));

    final isLoading =
        ref.watch(frameNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [
        CheckSheetLoadingScaffold(),
        Positioned(top: 15, child: DataUpdateLinearProgress()),
        LoadingOverlay(isLoading: isLoading)
      ],
    );
  }
}
