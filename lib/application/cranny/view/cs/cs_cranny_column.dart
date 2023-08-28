import 'dart:developer';

import 'package:agung_opr/application/check_sheet/shared/providers/cs_providers.dart';
import 'package:agung_opr/application/mode/mode_state.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../cranny_item.dart';

class CSCrannyColumn extends ConsumerStatefulWidget {
  const CSCrannyColumn();

  @override
  ConsumerState<CSCrannyColumn> createState() => _CSCrannyColumnState();
}

// final Map<String, ModeState> labelsMode = {
//   'UPDATE FRAME DUMMY': ModeState.updateFrameDummy(),
//   'CHECKSHEET UNIT': ModeState.checkSheetUnit(),
//   'CHECKSHEET CCR LOADING': ModeState.checkSheetLoading(),
//   'CHECKSHEET CCR UNLOADING': ModeState.checkSheetUnloading(),
//   'CHECKSHEET GATE MERAK': ModeState.checkSheetGateMerak(),
//   'ASSIGN UNIT MERAK': ModeState.assignUnitMerak(),
//   'DATA AKAN DIUPDATE': ModeState.dataUpdateQuery()
// };

class _CSCrannyColumnState extends ConsumerState<CSCrannyColumn> {
  @override
  Widget build(BuildContext context) {
    final jenis =
        ref.watch(csJenisNotifierProvider.select((value) => value.csJenisList));

    return Column(
      children: [
        for (final item in jenis) ...[
          TextButton(
              onPressed: () async {
                final isLoading = item.nama.toLowerCase().contains('loading');
                final isUnloading =
                    item.nama.toLowerCase().contains('unloading');
                final isInspection =
                    item.nama.toLowerCase().contains('inspection');

                if (isLoading) {
                  log('CALLED LOADING');
                  ref
                      .read(modeNotifierProvider.notifier)
                      .changeModeAplikasi('CHECKSHEET CCR LOADING');
                }

                if (isUnloading) {
                  ref
                      .read(modeNotifierProvider.notifier)
                      .changeModeAplikasi('CHECKSHEET CCR UNLOADING');
                }

                if (isInspection) {}

                ref.read(csItemNotifierProvider.notifier).changeId(item.id);

                await context.pushNamed(RouteNames.spkNameRoute);
              },
              child: CrannyItem(
                  label: item.nama
                      .toUpperCase()
                      .substring(0, item.nama.length - 1)))
        ]
      ],
    );
  }
}
