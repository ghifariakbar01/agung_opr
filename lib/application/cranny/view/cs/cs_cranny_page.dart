import 'dart:developer';

import 'package:agung_opr/application/check_sheet/shared/providers/cs_providers.dart';
import 'package:agung_opr/application/check_sheet/shared/state/cs_item.dart';
import 'package:agung_opr/application/check_sheet/shared/state/cs_jenis.dart';
import 'package:agung_opr/application/check_sheet/shared/state/cs_jenis_offline_state.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:agung_opr/domain/remote_failure.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/assets.dart';
import '../../../check_sheet/shared/state/cs_item_offline_state.dart';
import '../../../widgets/v_dialogs.dart';
import 'cs_cranny_column.dart';

/// [CSJenis] Initialization
/// [CSItem] Initialization
///

class CSCrannyPage extends ConsumerStatefulWidget {
  const CSCrannyPage();

  @override
  ConsumerState<CSCrannyPage> createState() => _CSCrannyPageState();
}

class _CSCrannyPageState extends ConsumerState<CSCrannyPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isOffline = ref.read(isOfflineStateProvider);

      // CS Jenis
      final csJenisOfflineOrOnline = ref.watch(csJenisOfflineNotifierProvider);
      final csJenishasOfflineStorage =
          csJenisOfflineOrOnline == CSJenisOfflineState.hasOfflineStorage();

      final isReallyOfflineMyNig = isOffline && csJenishasOfflineStorage;

      log('csJenisOfflineOrOnline $csJenisOfflineOrOnline');

      if (isReallyOfflineMyNig) {
        await ref.read(csJenisNotifierProvider.notifier).getCSJenisOFFLINE();
      } else {
        // await ref.read(csJenisNotifierProvider.notifier).getCSJenis();
      }

      // CS Item
      final csItemOfflineOrOnline = ref.watch(csItemOfflineNotifierProvider);
      final csItemhasOfflineStorage =
          csItemOfflineOrOnline == CSItemOfflineState.hasOfflineStorage();

      final isYouOfflineMyNig = isOffline && csItemhasOfflineStorage;

      log('csItemOfflineOrOnline $csItemOfflineOrOnline');

      if (isYouOfflineMyNig) {
        await ref.read(csItemNotifierProvider.notifier).getCSItemsOFFLINE();
      } else {
        // await ref.read(csItemNotifierProvider.notifier).getCSItems();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<RemoteFailure, List<CSJenis>?>>>(
      csJenisNotifierProvider.select(
        (state) => state.FOSOCSJenis,
      ),
      (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
        () {},
        (either) => either.fold(
            (failure) => showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) => VSimpleDialog(
                    label: 'Error',
                    labelDescription: failure.maybeMap(orElse: () => ''),
                    asset: Assets.iconCrossed,
                  ),
                ),
            (csJenis) => ref
                .read(csJenisNotifierProvider.notifier)
                .changeCSJenisList(csJenis ?? [])),
      ),
    );

    ref.listen<Option<Either<RemoteFailure, List<CSItem>?>>>(
      csItemNotifierProvider.select(
        (state) => state.FOSOCSItem,
      ),
      (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
        () {},
        (either) => either.fold(
            (failure) => showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) => VSimpleDialog(
                    label: 'Error',
                    labelDescription: failure.maybeMap(orElse: () => ''),
                    asset: Assets.iconCrossed,
                  ),
                ),
            (csItem) => ref
                .read(csItemNotifierProvider.notifier)
                .changeCSItemsList(csItem ?? [])),
      ),
    );

    final isSubmittingJenis = ref
        .watch(csJenisNotifierProvider.select((state) => state.isProcessing));

    final isSubmittingItem =
        ref.watch(csItemNotifierProvider.select((value) => value.isProcessing));

    return Stack(
      children: [
        CSCrannyColumn(),
        LoadingOverlay(isLoading: isSubmittingJenis || isSubmittingItem),
      ],
    );
  }
}
