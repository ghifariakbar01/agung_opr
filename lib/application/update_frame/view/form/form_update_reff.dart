import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';
import '../../../../style/style.dart';

class FormUpdateReffEXP extends ConsumerWidget {
  const FormUpdateReffEXP({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noReff = ref.watch(updateFrameNotifierProvider.select((value) =>
        value.updateFrameList.length < index
            ? NoReffEXP('')
            : value.updateFrameList[index].noReff));

    final noReffStr = noReff.getOrLeave('');

    final modeApp = ref.watch(modeNotifierProvider);

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
                'Tujuan Akhir',
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
            child: IgnorePointer(
              ignoring: true,
              child: TextFormField(
                initialValue: noReffStr,
                decoration: Themes.formStyle(noReffStr != ''
                    ? noReffStr + ' (ketik untuk ubah teks)'
                    : 'Masukkan no ref'),
                keyboardType: TextInputType.name,
                onChanged: (value) => ref
                    .read(updateFrameNotifierProvider.notifier)
                    .changeNoReffEXP(noReffStr: value, index: index),
                validator: (_) => ref
                    .read(updateFrameNotifierProvider)
                    .updateFrameList[index]
                    .noReff
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
          ),
        )
      ],
    );
  }
}
