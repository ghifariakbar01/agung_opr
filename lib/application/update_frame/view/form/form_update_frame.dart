import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';

class FormUpdateFrame extends ConsumerWidget {
  const FormUpdateFrame({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frame = ref.watch(updateFrameNotifierProvider
        .select((value) => value.updateFrameList[index].frame));

    final frameStr = frame.getOrLeave('');

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
                'Frame',
                style: Themes.customColor(
                    FontWeight.bold, 14, Palette.primaryColor),
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
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              initialValue: frameStr,
              decoration: Themes.formStyle(frameStr != ''
                  ? frameStr + ' (ketik untuk ubah teks)'
                  : 'Masukkan frame'),
              keyboardType: TextInputType.name,
              onChanged: (value) => ref
                  .read(updateFrameNotifierProvider.notifier)
                  .changeFrame(frameStr: value, index: index),
              validator: (_) => ref
                  .read(updateFrameNotifierProvider)
                  .updateFrameList[index]
                  .frame
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
