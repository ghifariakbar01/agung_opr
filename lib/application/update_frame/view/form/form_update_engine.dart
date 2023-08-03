import 'dart:developer';

import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';

class FormUpdateEngine extends ConsumerWidget {
  const FormUpdateEngine({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final engine = ref.watch(updateFrameNotifierProvider
        .select((value) => value.updateFrameList[index].engine));

    final engineStr = engine.getOrLeave('');

    log('engineStr $engineStr');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: SizedBox(
            height: 70,
            width: 50,
            child: Center(
              child: Text(
                'Engine',
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
