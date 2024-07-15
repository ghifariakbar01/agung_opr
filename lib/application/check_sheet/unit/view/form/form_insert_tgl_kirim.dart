import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../style/style.dart';

/// [TextEditingController] For displaying value only
///
///
class FormInsertTglKirim extends ConsumerWidget {
  const FormInsertTglKirim();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tglKirim = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.tglKirim));

    final tglKirimTextController = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.tglKirimTextController));

    final tglKirimStr = tglKirim.getOrLeave('');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: SizedBox(
            height: 70,
            width: 65,
            child: Center(
              child: Text(
                'TGL KIRIM',
                style: Themes.customColor(
                    FontWeight.bold, 14, Palette.primaryColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            height: 65,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onLongPress: () async {
                DateTime selectedDate = DateTime.now();

                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2015, 8),
                    lastDate: selectedDate);

                if (picked != null && picked != selectedDate) {
                  final date = DateFormat('yyyy-MM-dd').format(picked);
                  ref
                      .read(updateCSUFrameNotifierProvider.notifier)
                      .changeTglKirim(date);

                  tglKirimTextController.text = date;
                }
              },
              onPressed: () async {
                DateTime picked = DateTime.now();

                final date = DateFormat('yyyy-MM-dd').format(picked);
                ref
                    .read(updateCSUFrameNotifierProvider.notifier)
                    .changeTglKirim(date);

                tglKirimTextController.text = date;
              },
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero)),
              child: IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: tglKirimTextController,
                  decoration: Themes.formStyle(tglKirimStr != ''
                      ? tglKirimStr + ' (ketik untuk ubah teks)'
                      : 'Masukkan tgl kirim'),
                  keyboardType: TextInputType.name,
                  onChanged: (value) => {},
                  validator: (_) => ref
                      .read(updateCSUFrameNotifierProvider)
                      .updateFrameList
                      .tglTerima
                      .value
                      .fold(
                        (f) => f.maybeMap(
                          empty: (_) => 'kosong',
                          orElse: () => null,
                        ),
                        (_) => null,
                      ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
