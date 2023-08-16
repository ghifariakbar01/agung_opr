import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/mode/mode_state.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../update_frame/shared/update_frame_providers.dart';
import '../../widgets/v_appbar.dart';
import '../../widgets/v_bottomnav.dart';
import 'cranny_item.dart';

final List<String> labels = [
  'UPDATE FRAME DUMMY',
  'CHECKSHEET UNIT',
];

class CrannyScaffold extends ConsumerStatefulWidget {
  const CrannyScaffold();

  @override
  ConsumerState<CrannyScaffold> createState() => _CrannyScaffoldState();
}

class _CrannyScaffoldState extends ConsumerState<CrannyScaffold> {
  @override
  Widget build(BuildContext context) {
    final updateFrameOfflineOrOnline =
        ref.watch(updateFrameOfflineNotifierProvider);

    final updateCSUFrameOfflineOrOnline =
        ref.watch(updateCSUFrameOfflineNotifierProvider);

    final current = ref.watch(index);

    return Scaffold(
      appBar: VAppBar(
        'Aplikasi OPR CCR',
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              for (final label in labels) ...[
                if (current == 1 && label == 'CHECKSHEET UNIT') ...[
                  Container()
                ] else ...[
                  TextButton(
                      onPressed: () async {
                        ref
                            .read(modeNotifierProvider.notifier)
                            .changeModeAplikasi(label);

                        await context.pushNamed(RouteNames.spkNameRoute);
                      },
                      child: CrannyItem(label: label))
                ]
              ],
              // Frame
              updateFrameOfflineOrOnline.maybeWhen(
                hasOfflineStorage: () => TextButton(
                    onPressed: () async {
                      ref
                          .read(modeNotifierProvider.notifier)
                          .changeModeAplikasi('DATA AKAN DIUPDATE');

                      await context
                          .pushNamed(RouteNames.dataUpdateQueryNameRoute);
                    },
                    child: CrannyItem(label: 'DATA AKAN DIUPDATE')),
                orElse: () => Container(),
              ),
              // CSU Items
              updateCSUFrameOfflineOrOnline.maybeWhen(
                hasOfflineStorage: () => TextButton(
                    onPressed: () async {
                      ref
                          .read(modeNotifierProvider.notifier)
                          .changeModeAplikasi('DATA AKAN DIUPDATE');

                      await context
                          .pushNamed(RouteNames.dataUpdateQueryNameRoute);
                    },
                    child: CrannyItem(label: 'DATA AKAN DIUPDATE')),
                orElse: () => Container(),
              )
            ],
          )),
      // drawer: Drawer(),
      bottomNavigationBar: VBottomNav(),
    );
  }
}
