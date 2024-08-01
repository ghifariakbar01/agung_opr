import 'package:agung_opr/application/update_spk/providers/update_spk_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../domain/value_objects_copy.dart';
import '../../../../../style/style.dart';
import '../../../shared/providers/cs_providers.dart';

class FormKeterangan extends HookConsumerWidget {
  const FormKeterangan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keterangan = ref.watch(
      updateCSNotifierProvider.select((value) => value.updateCSForm.keterangan),
    );
    final keteranganStr = keterangan.getOrLeave('');
    final keteranganController = useTextEditingController(text: keteranganStr);

    ref.listen<Keterangan>(
        updateCSNotifierProvider
            .select((value) => value.updateCSForm.keterangan), (__, aft) {
      keteranganController.text = aft.getOrLeave('');
    });

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Palette.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        controller: keteranganController,
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
          ref.read(updateCSNotifierProvider.notifier).changeKeterangan(value);
          ref
              .read(updateSPKNotifierProvider.notifier)
              .changeKeterangan(keterangan: value);
        },
        maxLines: 2,
      ),
    );
  }
}
