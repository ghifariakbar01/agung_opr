import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/spk/view/spk_search.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/v_appbar.dart';
import '../../widgets/v_bottomnav.dart';
import 'spk_item.dart';

class SPKScaffold extends ConsumerWidget {
  const SPKScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modeApp = ref.watch(modeNotifierProvider);

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: VAppBar(
          'SPK List (${modeApp.when(
            initial: () {},
            updateFrameDummy: () => 'Update Frame Dummy',
            checkSheetLoading: () => 'CS Loading',
            checkSheetUnloading: () => 'CS Unloading',
            checkSheetGateMerak: () => 'CS Gate Merak',
            assignUnitMerak: () => 'Assign Unit Merak',
          )})',
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                SPKSearch(),
                for (int i = 0; i < 5; i++) ...[
                  TextButton(
                    onPressed: () => modeApp.when(
                      initial: () {},
                      updateFrameDummy: () =>
                          context.pushNamed(RouteNames.updateFrameNameRoute),
                      checkSheetLoading: () => context
                          .pushNamed(RouteNames.checkSheetLoadingNameRoute),
                      checkSheetUnloading: () => context
                          .pushNamed(RouteNames.checkSheetUnloadingNameRoute),
                      checkSheetGateMerak: () => context
                          .pushNamed(RouteNames.checkSheetUnloadingNameRoute),
                      assignUnitMerak: () => context
                          .pushNamed(RouteNames.assignUnitMerakNameRoute),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                    child: SPKItem(
                      nomorSpk: 'ACT/SPK-2306138410-TNS',
                      namaDriver: 'Ambun / Hendi Saputra',
                      nomorPolisi: 'B 9910 PIN',
                    ),
                  )
                ]
              ],
            )),
        drawer: Drawer(),
        bottomNavigationBar: VBottomNav(),
      ),
    );
  }
}
