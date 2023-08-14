import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../style/style.dart';

/// [TextEditingController] For displaying value only
///
///
class FormInsertTglTerima extends ConsumerWidget {
  const FormInsertTglTerima({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tglTerima = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.tglTerima));

    final tglTerimaTextController = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.tglTerimaTextController));

    final tglTerimaStr = tglTerima.getOrLeave('');

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
                'TGL TERIMA',
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
              onPressed: () async {
                DateTime selectedDate = DateTime.now();

                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2015, 8),
                    lastDate: selectedDate);

                if (picked != null && picked != selectedDate) {
                  final date = DateFormat('dd/MM/yyyy').format(picked);
                  ref
                      .read(updateCSUFrameNotifierProvider.notifier)
                      .changeTglTerima(date);

                  tglTerimaTextController.text = date;
                }
              },
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero)),
              child: IgnorePointer(
                ignoring: true,
                child: TextFormField(
                  controller: tglTerimaTextController,
                  decoration: Themes.formStyle(tglTerimaStr != ''
                      ? tglTerimaStr + ' (ketik untuk ubah teks)'
                      : 'Masukkan tgl terima'),
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
