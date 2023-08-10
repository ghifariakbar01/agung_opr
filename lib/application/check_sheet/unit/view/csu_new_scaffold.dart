import 'package:agung_opr/application/widgets/v_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';
import '../../../widgets/v_appbar.dart';
import '../shared/csu_providers.dart';
import 'form/form_insert_deck.dart';
import 'form/form_insert_gate.dart';
import 'form/form_insert_supir1.dart';
import 'form/form_insert_supir2.dart';
import 'form/form_insert_supir_sdr.dart';
import 'form/form_insert_tgl_kirim.dart';
import 'form/form_insert_tgl_terima.dart';
import 'widget/csu_item_form.dart';
import 'widget/csu_row_item.dart';

class CSUNewScaffold extends ConsumerWidget {
  const CSUNewScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frame =
        ref.watch(csuFrameNotifierProvider.select((value) => value.frame));

    final csuItems = ref.watch(
        updateCSUFrameNotifierProvider.select((value) => value.csuItems));

    return KeyboardDismissOnTap(
        child: Scaffold(
            appBar: VAppBar('Check Sheet Unit New'),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ID UNIT
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Palette.primaryColor, width: 2)),
                        padding: EdgeInsets.all(4),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: CSURowItem(
                                  label: 'ID UNIT', text: frame.frame ?? ''),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            FormInsertGate(index: 0),
                            FormInsertDeck(index: 0),
                            FormInsertSupir1(index: 0),
                            FormInsertSupir2(index: 0),
                            FormInsertSupirSdr(
                              index: 0,
                            ),
                            FormInsertTglTerima(index: 0),
                            FormInsertTglKirim(index: 0),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 8,
                      ),

                      // KELENGKAPAN
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Palette.primaryColor, width: 2)),
                        padding: EdgeInsets.all(4),
                        child: Column(
                          children: [
                            Text(
                              'KELENGKAPAN',
                              style: Themes.customColor(
                                  FontWeight.bold, 16, Palette.primaryColor),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            for (int index = 0;
                                index < csuItems.length;
                                index++) ...[
                              CheckSheetUnitItemForm(
                                  index: index,
                                  instruction:
                                      '${csuItems[index].id}. ${csuItems[index].ind} (${csuItems[index].eng})')
                            ]
                          ],
                        ),
                      ),

                      VButton(
                          label: 'DEFECT',
                          color: Palette.red,
                          isEnabled: false,
                          onPressed: () {}),
                      VButton(
                          label: 'NO DEFECT',
                          isEnabled: false,
                          onPressed: () {}),
                    ],
                  ),
                ))));
  }
}
