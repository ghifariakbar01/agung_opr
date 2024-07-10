import 'package:agung_opr/application/check_sheet/unit/view/form/form_insert_keterangan.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../style/style.dart';

import '../../../../update_frame/frame.dart';
import '../../shared/csu_providers.dart';
import '../form/form_insert_deck.dart';
import '../form/form_insert_gate.dart';
import '../form/form_insert_supir_sdr.dart';
import '../form/form_insert_tgl_kirim.dart';
import '../form/form_insert_tgl_terima.dart';
import '../widget/csu_row_item.dart';

class CSUNewForm extends ConsumerWidget {
  const CSUNewForm(this.frame);

  final Frame frame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              child: CSURowItem(
                label: 'ID UNIT',
                text: frame.frame ?? '',
              ),
            ),
            SizedBox(
              height: 8,
            ),
            FormInsertGate(),
            FormInsertDeck(),
            FormInsertSupirSDR(),
            FormInsertTglTerima(),
            FormInsertTglKirim(),
            FormInsertKeterangan(),
          ],
        ),
      ),
    );
  }
}
