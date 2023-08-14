import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../style/style.dart';

import '../../shared/csu_providers.dart';
import '../form/form_insert_deck.dart';
import '../form/form_insert_gate.dart';
import '../form/form_insert_supir1.dart';
import '../form/form_insert_supir2.dart';
import '../form/form_insert_supir_sdr.dart';
import '../form/form_insert_tgl_kirim.dart';
import '../form/form_insert_tgl_terima.dart';
import '../widget/csu_row_item.dart';

class CSUNewForm extends ConsumerWidget {
  const CSUNewForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frame =
        ref.watch(csuFrameNotifierProvider.select((value) => value.frame));

    final showErrorMessage = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.showErrorMessages));

    // ID UNIT
    return Form(
      autovalidateMode: showErrorMessage
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Palette.primaryColor, width: 2)),
        padding: EdgeInsets.all(4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CSURowItem(label: 'ID UNIT', text: frame.frame ?? ''),
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
    );
  }
}
