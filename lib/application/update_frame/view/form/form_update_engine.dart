import 'dart:developer';

import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';
import '../../../../style/style.dart';

class FormUpdateEngine extends ConsumerWidget {
  const FormUpdateEngine({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final engine = ref.watch(updateFrameNotifierProvider.select((value) =>
        value.updateFrameList.length < index
            ? EngineUnit('')
            : value.updateFrameList[index].engine));

    final engineStr = engine.getOrLeave('');

    final modeApp = ref.watch(modeNotifierProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: Center(
            child: Text(
              'Engine',
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
              initialValue: engineStr,
              decoration: Themes.formStyle(engineStr != ''
                  ? engineStr + ' (ketik untuk ubah teks)'
                  : 'Masukkan engine'),
              keyboardType: TextInputType.name,
              onChanged: (value) => ref
                  .read(updateFrameNotifierProvider.notifier)
                  .changeEngine(engineStr: value, index: index),
              validator: (_) => ref
                  .read(updateFrameNotifierProvider)
                  .updateFrameList[index]
                  .engine
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
        )
      ],
    );
  }
}
