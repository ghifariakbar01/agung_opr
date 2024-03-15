import 'package:agung_opr/application/auto_data/shared/auto_data_providers.dart';
import 'package:agung_opr/application/check_sheet/unit/state/csu_id_query.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/assets.dart';
import '../../../domain/local_failure.dart';
import '../../check_sheet/shared/state/cs_id_query.dart';
import '../../history/history.dart';
import '../../widgets/v_dialogs.dart';
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
          .getSavedSPKQueryFromRepository();
      await ref
          .read(autoDataUpdateFrameNotifierProvider.notifier)
          .getSavedCSQueryFromRepository();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<LocalFailure, List<History>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOAutoDataLocalHistory,
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
                            storage: (_) => 'storage penuh',
                            format: (error) => 'Error Format: $error',
                            orElse: () => ''),
                        asset: Assets.iconCrossed,
                      ),
                    ),
                (histories) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .changeSavedHistories(histories: histories))));

    ref.listen<Option<Either<LocalFailure, Map<String, Map<String, String>>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOSPKAutoDataLocalUpdateFrame,
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
                            storage: (_) => 'storage penuh',
                            format: (error) => 'Error Format: $error',
                            orElse: () => ''),
                        asset: Assets.iconCrossed,
                      ),
                    ),
                (idSPKMapidTIUnitMapQuery) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .changeSavedQuery(
                        idSPKMapidTIUnitMapQuery: idSPKMapidTIUnitMapQuery))));

    // CSU
    ref.listen<Option<Either<LocalFailure, List<CSUIDQuery>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOAutoDataLocalUpdateFrameCSU,
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
                            storage: (_) => 'storage penuh',
                            format: (error) => 'Error Format: $error',
                            orElse: () => ''),
                        asset: Assets.iconCrossed,
                      ),
                    ),
                (csuIdQueries) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .changeSavedCSUQuery(csuIdQueries: csuIdQueries))));

    // CS
    ref.listen<Option<Either<LocalFailure, List<CSIDQuery>>>>(
        autoDataUpdateFrameNotifierProvider.select(
          (state) => state.FOSOAutoDataLocalUpdateFrameCS,
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
                            storage: (_) => 'storage penuh',
                            format: (error) => 'Error Format: $error',
                            orElse: () => ''),
                        asset: Assets.iconCrossed,
                      ),
                    ),
                (csIdQueries) => ref
                    .read(autoDataUpdateFrameNotifierProvider.notifier)
                    .changeSavedCSQuery(csIdQueries: csIdQueries))));

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
