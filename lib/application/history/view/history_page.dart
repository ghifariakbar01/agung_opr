import 'package:agung_opr/application/history/shared/history_providers.dart';
import 'package:agung_opr/application/history/view/history_scaffold.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/assets.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) => ref
        .read(historyNotifierProvider.notifier)
        .getHistory(
            startDate: DateTime.now(),
            endDate: DateTime.now().subtract(Duration(days: 1))));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<RemoteFailure, List<History>?>>>(
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
                            noConnection: (value) => 'No connection',
                            server: (value) => 'Server $value',
                            storage: (_) => 'storage penuh',
                            orElse: () => ''),
                        asset: Assets.iconCrossed,
                      ),
                    ),
                (histories) => ref
                    .read(historyNotifierProvider.notifier)
                    .changeHistoryList(histories ?? []))));

    final isLoading =
        ref.watch(historyNotifierProvider.select((value) => value.isGetting));

    return Stack(
      children: [HistoryScaffold(), LoadingOverlay(isLoading: isLoading)],
    );
  }
}
