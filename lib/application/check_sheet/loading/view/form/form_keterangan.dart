import 'package:agung_opr/application/update_spk/providers/update_spk_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';
import '../../../shared/providers/cs_providers.dart';

class FormKeterangan extends ConsumerStatefulWidget {
  const FormKeterangan();

  @override
  ConsumerState<FormKeterangan> createState() => _FormKeteranganState();
}

class _FormKeteranganState extends ConsumerState<FormKeterangan> {
  @override
  Widget build(BuildContext context) {
    final keterangan = ref.watch(updateCSNotifierProvider
        .select((value) => value.updateCSForm.keterangan));

    final keteranganStr = keterangan.getOrLeave('');

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
                'KETERANGAN',
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
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Palette.primaryColor, width: 2),
                borderRadius: BorderRadius.circular(12)),
            child: TextFormField(
              initialValue: keteranganStr,
              decoration: Themes.formStyle(
                'Masukkan KETERANGAN (Jika Ada Temuan Abnormality Terkait APD, CCR) :',
                hintFontSize: 11,
                icon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.note,
                      color: Palette.primaryColor,
                    )),
              ),
              onChanged: (value) {
                ref
                    .read(updateCSNotifierProvider.notifier)
                    .changeKeterangan(value);

                ref
                    .read(updateSPKNotifierProvider.notifier)
                    .changeKeterangan(keterangan: value);
              },
              maxLines: 2,
            ),
          ),
        )
      ],
    );
  }
}
