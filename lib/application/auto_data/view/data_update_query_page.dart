import 'package:agung_opr/application/auto_data/shared/auto_data_providers.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'data_update_linear_progress.dart';
import 'data_update_query_scaffold.dart';

class DataUpdateQueryPage extends ConsumerStatefulWidget {
  const DataUpdateQueryPage();

  @override
  ConsumerState<DataUpdateQueryPage> createState() =>
      _DataUpdateQueryPageState();
}

class _DataUpdateQueryPageState extends ConsumerState<DataUpdateQueryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(autoDataUpdateFrameNotifierProvider.notifier)
          .getSavedQueryFromRepository();
      await ref
          .read(autoDataUpdateFrameNotifierProvider.notifier)
          .getSavedCSQueryFromRepository();
      await ref
          .read(autoDataUpdateFrameNotifierProvider.notifier)
          .getSavedCSUQueryFromRepository();
      await ref
          .read(autoDataUpdateFrameNotifierProvider.notifier)
          .getSavedSPKQueryFromRepository();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting = ref.watch(
      autoDataUpdateFrameNotifierProvider.select((state) => state.isGetting),
    );

    return Stack(
      children: [
        DataUpdateQueryScaffold(),
        Positioned(top: 100, child: DataUpdateLinearProgress()),
        LoadingOverlay(isLoading: isSubmitting)
      ],
    );
  }
}
