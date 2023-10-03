import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';
import '../../../../style/style.dart';

class FormUpdateWarna extends ConsumerWidget {
  const FormUpdateWarna({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final warna = ref.watch(updateFrameNotifierProvider.select((value) =>
        value.updateFrameList.length < index
            ? WarnaUnit('')
            : value.updateFrameList[index].warna));

    final warnaStr = warna.getOrLeave('');

    final modeApp = ref.watch(modeNotifierProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: Center(
            child: Text(
              'Warna',
              style:
                  Themes.customColor(FontWeight.bold, 14, Palette.primaryColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 1,
          child: IgnorePointer(
            ignoring: modeApp.maybeWhen(
                checkSheetUnit: () => true, orElse: () => false),
            child: TextFormField(
              initialValue: warnaStr,
              decoration: Themes.formStyle(warnaStr != ''
                  ? warnaStr + ' (ketik untuk ubah teks)'
                  : 'Masukkan warna'),
              keyboardType: TextInputType.name,
              onChanged: (value) => ref
                  .read(updateFrameNotifierProvider.notifier)
                  .changeWarna(warnaStr: value, index: index),
            ),
          ),
        )
      ],
    );
  }
}
