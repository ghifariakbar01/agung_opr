import 'package:agung_opr/application/auto_data/shared/auto_data_providers.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/local_failure.dart';
import '../../widgets/alert_helper.dart';
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
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<LocalFailure, Map<String, Map<String, String>>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOSPKAutoDataGetSavedUpdateFrame,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                (failure) => AlertHelper.showSnackBar(
                      context,
                      message: failure.maybeMap(
                          storage: (_) => 'storage penuh',
                          format: (error) => 'Error Format: $error',
                          orElse: () => ''),
                    ),
                (idSPKMapidTIUnitMapQuery) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .changeSavedQuery(
                        idSPKMapidTIUnitMapQuery: idSPKMapidTIUnitMapQuery))));

    final isSubmitting = ref.watch(
      autoDataUpdateFrameNotifierProvider.select((state) => state.isGetting),
    );

    return Stack(
      children: [
        DataUpdateQueryScaffold(),
        LoadingOverlay(isLoading: isSubmitting)
      ],
    );
  }
}
