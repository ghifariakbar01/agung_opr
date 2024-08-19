import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/value_objects_copy.dart';
import '../../shared/update_frame_providers.dart';

class FormUpdateWarnaDropdown extends ConsumerWidget {
  const FormUpdateWarnaDropdown({Key? key, required this.index})
      : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basicColors = ref.watch(
        updateFrameNotifierProvider.select((value) => value.basicColors));

    final warna = ref.watch(updateFrameNotifierProvider.select((value) =>
        value.updateFrameList.length < index
            ? WarnaUnit('')
            : value.updateFrameList[index].warna));

    final warnaStr = warna.getOrLeave('');

    return Row(
      children: [
        DropdownButton<String>(
          value: basicColors.entries
              .firstWhere(
                (element) => element.key == warnaStr,
                orElse: () => basicColors.entries.first,
              )
              .key,
          onChanged: (String? value) {
            if (value != null) {
              ref.read(updateFrameNotifierProvider.notifier).checkIfValid();

              ref
                  .read(updateFrameNotifierProvider.notifier)
                  .changeWarna(warnaStr: value, index: index);

              ref
                  .read(updateFrameNotifierProvider.notifier)
                  .changeWarnaController(warnaStr: value, index: index);

              ref.read(updateFrameNotifierProvider.notifier).checkIfValid();
            }
          },
          items: basicColors.keys.map((colorMap) {
            return DropdownMenuItem<String>(
              value: colorMap,
              child: Row(
                children: [
                  Text(colorMap),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                      height: 25,
                      width: 25,
                      color: basicColors.entries
                          .firstWhere(
                            (element) => element.key == colorMap,
                            orElse: () => basicColors.entries.first,
                          )
                          .value)
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
