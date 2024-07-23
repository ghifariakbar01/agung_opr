import 'package:agung_opr/application/history/shared/history_providers.dart';
import 'package:agung_opr/application/history/view/history_scaffold.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/assets.dart';
import '../../../constants/constants.dart';
import '../../../domain/remote_failure.dart';
import '../../widgets/v_dialogs.dart';
import '../history.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage();

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(historyNotifierProvider.notifier).getHistory(
              nopol: '',
              dateRange: Constants.defaultDateTimeRange,
            ));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<RemoteFailure, History?>>>(
        historyNotifierProvider.select(
          (state) => state.FOSOHistory,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => VSimpleDialog(
                        label: 'Error',
                        labelDescription: failure.maybeMap(
                          orElse: () => '',
                          storage: (_) => 'storage penuh',
                          server: (value) => 'Server $value',
                          noConnection: (value) => 'No connection',
                        ),
                        asset: Assets.iconCrossed,
                      ),
                    ),
                (history) => ref
                    .read(historyNotifierProvider.notifier)
                    .changeHistory(history ?? History.initial()))));

    final isLoading = ref.watch(
            historyNotifierProvider.select((value) => value.isGetting)) ||
        ref.watch(frameNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [
        HistoryScaffold(),
        LoadingOverlay(isLoading: isLoading),
      ],
    );
  }
}
