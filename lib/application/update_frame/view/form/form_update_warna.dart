import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/value_objects_copy.dart';
import '../../../../style/style.dart';
import '../../shared/update_frame_providers.dart';
import 'form_update_warna_dropdown.dart';

class FormUpdateWarna extends HookConsumerWidget {
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

    final isCustom = useState(false);

    final String warnaStr = warna.getOrLeave('');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: Column(
            children: [
              Center(
                child: Text(
                  'Warna',
                  style: Themes.customColor(
                      FontWeight.bold, 14, Palette.primaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  'Manual',
                  style: Themes.customColor(
                      FontWeight.bold, 11, Palette.primaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
              Switch(
                  value: isCustom.value,
                  onChanged: (value) {
                    isCustom.value = value;
                  })
            ],
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          flex: 1,
          child: TextFormField(
            enabled: isCustom.value,
            key: isCustom.value ? null : Key(warnaController.text),
            controller: warnaController,
            decoration:
                Themes.formStyle(warnaStr != '' ? warnaStr : 'Masukkan warna'),
            keyboardType: TextInputType.name,
            onChanged: (value) {
              ref
                  .read(updateFrameNotifierProvider.notifier)
                  .changeWarna(warnaStr: value, index: index);

              ref
                  .read(updateFrameNotifierProvider.notifier)
                  .checkIfWarnaExist(index: index);

              ref.read(updateFrameNotifierProvider.notifier).checkIfValid();
            },
            validator: (_) => ref
                .read(updateFrameNotifierProvider)
                .updateFrameList[index]
                .warna
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
        if (isCustom.value == false || isWarnaExist || warnaStr.isEmpty) ...[
          SizedBox(width: 16),
          Flexible(
            flex: 0,
            child: FormUpdateWarnaDropdown(
              index: index,
            ),
          )
        ]
      ],
    );
  }
}
