import 'package:agung_opr/application/widgets/v_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';
import '../../../widgets/v_appbar.dart';
import 'check_sheet_unloading_item.dart';

class CheckSheetUnloadingScaffold extends ConsumerWidget {
  const CheckSheetUnloadingScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KeyboardDismissOnTap(
      child: Scaffold(
          appBar: VAppBar(context, 'Checksheet CCR Unloading'),
          bottomNavigationBar: Container(
              height: 80,
              color: Palette.greySecondary,
              child: Row(
                children: [
                  SizedBox(
                      width: 215,
                      child: VButton(label: 'SIMPAN & BACK', onPressed: () {})),
                ],
              )),
          // drawer: Drawer(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                // CheckSheetCCRHeader(),

                // Header
                Container(
                  height: 77,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Palette.yellow,
                  ),
                  child: Center(
                    child: Text(
                      'ACT/SPK-2306138410-TNS\nAmbun / Hendi Saputra\nB 9910 PIN',
                      style:
                          Themes.customColor(FontWeight.bold, 16, Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // Body
                CheckSheetUnloadingItem(),

                CheckSheetUnloadingItem()
              ],
            ),
          )),
    );
  }
}
