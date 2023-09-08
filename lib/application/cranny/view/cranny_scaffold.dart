import 'dart:developer';

import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/mode/mode_state.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../../check_sheet/shared/providers/cs_providers.dart';
import '../../update_frame/shared/update_frame_providers.dart';
import '../../widgets/v_appbar.dart';
import 'cranny_drawer.dart';
import 'cranny_item.dart';
import 'cs/cs_cranny_page.dart';

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

    final updateCSfflineOrOnline = ref.watch(updateCSOfflineNotifierProvider);

    log('updateFrameOfflineOrOnline $updateFrameOfflineOrOnline');
    log('updateCSfflineOrOnline $updateCSfflineOrOnline');

    final isUpdateAvailable = updateFrameOfflineOrOnline.maybeWhen(
            hasOfflineStorage: () => true, orElse: () => false) ||
        updateCSUFrameOfflineOrOnline.maybeWhen(
            hasOfflineStorage: () => true,
            orElse: () =>
                false ||
                updateCSfflineOrOnline.maybeWhen(
                    hasOfflineStorage: () => true, orElse: () => false));

    final reminder = ref.watch(reminderNotifierProvider);

    log('reminder.daysLeft ${reminder.daysLeft}');

    return Scaffold(
      appBar: VAppBar(
        'Mobile Car Carrier OPR CCR',
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // TextButton(
              //     onPressed: () async {
              //       ref
              //           .read(modeNotifierProvider.notifier)
              //           .changeModeAplikasi(ModeState.updateFrameDummy());

              //       await context.pushNamed(RouteNames.spkNameRoute);
              //     },
              //     child: CrannyItem(label: 'UPDATE FRAME DUMMY')),
              //
              //
              if (reminder.daysLeft < 8) ...[
                Text(
                  reminder.daysLeft == 0
                      ? ref
                          .read(reminderNotifierProvider.notifier)
                          .daysLeftStringDue
                      : reminder.daysLeft < 0
                          ? ref
                              .read(reminderNotifierProvider.notifier)
                              .daysLeftStringPass
                          : ref
                              .read(reminderNotifierProvider.notifier)
                              .daysLeftString,
                  style: Themes.customColor(FontWeight.bold, 9, Palette.red),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
              if (isUpdateAvailable) ...[
                TextButton(
                    onPressed: () async {
                      ref
                          .read(modeNotifierProvider.notifier)
                          .changeModeAplikasi(ModeState.dataUpdateQuery());

                      await context
                          .pushNamed(RouteNames.dataUpdateQueryNameRoute);
                    },
                    child: CrannyItem(label: 'DATA AKAN DIUPDATE'))
              ],
              //
              TextButton(
                  onPressed: () async {
                    ref.read(modeNotifierProvider.notifier).changeModeAplikasi(
                        ModeState.checkSheetUnitWithoutSPK());

                    await context.pushNamed(RouteNames.unitNameRoute);
                  },
                  child: CrannyItem(label: 'CHECK SHEET UNIT')),
              //
              CSCrannyPage(),
              //
              const SizedBox(height: 8),
            ],
          )),
      drawer: CrannyDrawer(),
    );
  }
}
