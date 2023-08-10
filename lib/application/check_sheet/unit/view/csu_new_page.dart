import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/check_sheet/unit/state/csu_items.dart';
import 'package:agung_opr/application/check_sheet/unit/view/csu_new_scaffold.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/remote_failure.dart';
import '../../../../shared/providers.dart';
import '../../../update_frame/frame.dart';
import '../../../widgets/alert_helper.dart';

class CSUNewPage extends ConsumerStatefulWidget {
  const CSUNewPage();

  @override
  ConsumerState<CSUNewPage> createState() => _CSUNewPageState();
}

class _CSUNewPageState extends ConsumerState<CSUNewPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(updateCSUFrameNotifierProvider.notifier).getCSUItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Option<Either<RemoteFailure, List<CSUItems>>>>(
        updateCSUFrameNotifierProvider.select(
          (state) => state.FOSOUpdateCSUItems,
        ),
        (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => failure.maybeMap(
                          noConnection: (value) =>
                              ref.read(isOfflineProvider.notifier).state = true,
                          orElse: () => AlertHelper.showSnackBar(
                            context,
                            message: failure.maybeMap(
                              storage: (_) =>
                                  'Storage penuh. Tidak bisa menyimpan data CSU ITEM',
                              server: (value) =>
                                  value.message ?? 'Server Error',
                              parse: (value) => 'Parse $value',
                              orElse: () => '',
                            ),
                          ),
                        ), (CSUResponse) {
                  /// SET [frameResponse] from GOT frameList
                  debugger(message: 'called');
                  log('CSU RESPONSE: $CSUResponse');
                  if (CSUResponse != []) {
                    ref
                        .read(updateCSUFrameNotifierProvider.notifier)
                        .changeCSUItems(CSUResponse);

                    final responseLEN = CSUResponse.length;

                    /// RUN [changeFillEmptyList] TO UPDATE NG PLACEHOLDERS
                    ref
                        .read(updateCSUFrameNotifierProvider.notifier)
                        .changeFillEmptyList(length: responseLEN);
                  }
                })));

    return Stack(
      children: [CSUNewScaffold(), LoadingOverlay(isLoading: false)],
    );
  }
}
