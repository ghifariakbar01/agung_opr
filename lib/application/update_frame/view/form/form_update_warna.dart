import 'dart:developer';

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
    final basicColors = ref.watch(
        updateFrameNotifierProvider.select((value) => value.basicColors));

    final warna = ref.watch(updateFrameNotifierProvider.select((value) =>
        value.updateFrameList.length < index
            ? WarnaUnit('Hijau')
            : value.updateFrameList[index].warna));

    final warnaStr = warna.getOrLeave('Hijau');

    final modeApp = ref.watch(modeNotifierProvider);

    log('Color ${basicColors.entries.firstWhere((element) => element.key == warnaStr).value}');

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
              child: DropdownButton<String>(
                value: warnaStr,
                onChanged: (String? value) {
                  if (value != null) {
                    ref
                        .read(updateFrameNotifierProvider.notifier)
                        .changeWarna(warnaStr: value, index: index);
                  }
                },
                icon: Row(
                  children: [
                    Icon(Icons.arrow_drop_down_sharp),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                        width: 25,
                        height: 25,
                        color: basicColors.entries
                            .firstWhere((element) => element.key == warnaStr)
                            .value),
                  ],
                ),
                items: basicColors.keys.map((String colorName) {
                  return DropdownMenuItem<String>(
                    value: colorName,
                    child: Text(colorName),
                  );
                }).toList(),
              )),
        ),
      ],
    );
  }
}
