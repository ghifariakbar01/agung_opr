import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../style/style.dart';

class FormInsertKeterangan extends ConsumerStatefulWidget {
  const FormInsertKeterangan();

  @override
  ConsumerState<FormInsertKeterangan> createState() =>
      _FormInsertKeteranganState();
}

class _FormInsertKeteranganState extends ConsumerState<FormInsertKeterangan> {
  @override
  Widget build(BuildContext context) {
    final keterangan = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.keterangan));

    final keteranganTextController = ref.watch(updateCSUFrameNotifierProvider
        .select((value) => value.updateFrameList.keteranganTextController));

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
          child: TextFormField(
            controller: keteranganTextController,
            decoration: Themes.formStyle('Masukkan keterangan'),
            onChanged: (value) => ref
                .read(updateCSUFrameNotifierProvider.notifier)
                .changeKeterangan(value),
            validator: (_) => keterangan.value.fold(
              (f) => f.maybeMap(
                shortPassword: (_) => 'terlalu pendek',
                orElse: () => null,
              ),
              (_) => null,
            ),
            maxLines: 2,
          ),
        )
      ],
    );
  }
}
