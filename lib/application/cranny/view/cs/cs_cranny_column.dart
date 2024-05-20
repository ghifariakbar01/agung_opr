import 'package:agung_opr/application/check_sheet/shared/providers/cs_providers.dart';
import 'package:agung_opr/application/mode/mode_state.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/spk/view/spk_scaffold.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
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

class _CSCrannyColumnState extends ConsumerState<CSCrannyColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
            onPressed: () async {
              ModeState mode = ModeState.checkSheetLoading();

              _changeInitialAndMode(mode);

              const int id = 1;
              ref.read(csItemNotifierProvider.notifier).changeId(id);

              await context.pushNamed(RouteNames.spkNameRoute);
            },
            child: CrannyItem(label: 'UPDATE UNIT')),
      ],
    );
  }

  void _changeInitialAndMode(ModeState mode) {
    ref.read(frameNotifierProvider.notifier).changeFillInitial();
    ref.read(updateCSNotifierProvider.notifier).changeFillInitial();
    ref.read(modeNotifierProvider.notifier).changeModeAplikasi(mode);
    ref.read(updateCSNotifierProvider.notifier).changeTipe(mode);
    ref.read(scrollPageProvider.notifier).state = 0;
  }
}
