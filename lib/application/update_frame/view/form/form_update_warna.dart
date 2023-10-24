import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/value_objects_copy.dart';
import '../../../../shared/providers.dart';
import '../../../../style/style.dart';
import '../../shared/update_frame_providers.dart';
import 'form_update_warna_dropdown.dart';

class FormUpdateWarna extends ConsumerWidget {
  const FormUpdateWarna({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final warnaController = ref.watch(updateFrameNotifierProvider.select(
        (value) => value.warnaTextController.length < index ||
                value.warnaTextController.isEmpty
            ? TextEditingController()
            : value.warnaTextController[index]));

    final warna = ref.watch(updateFrameNotifierProvider.select((value) =>
        value.updateFrameList.length < index
            ? WarnaUnit('')
            : value.updateFrameList[index].warna));

    final bool isWarnaExist = ref
        .watch(updateFrameNotifierProvider.notifier)
        .checkIfWarnaExist(index: index);

    final String warnaStr = warna.getOrLeave('');

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
              controller: warnaController,
              decoration: Themes.formStyle(
                  warnaStr != '' ? warnaStr : 'Masukkan warna'),
              keyboardType: TextInputType.name,
              onChanged: (value) => ref
                  .read(updateFrameNotifierProvider.notifier)
                  .changeWarna(warnaStr: value, index: index),
            ),
          ),
        ),
        if (isWarnaExist || warnaStr.isEmpty) ...[
          SizedBox(width: 16),
          Flexible(flex: 0, child: FormUpdateWarnaDropdown(index: index))
        ]
      ],
    );
  }
}
