import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';

class FormUpdateSPPDC extends ConsumerWidget {
  const FormUpdateSPPDC({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sppdc = ref.watch(updateFrameNotifierProvider
        .select((value) => value.updateFrameList[index].sppdc));

    final sppdcStr = sppdc.getOrLeave('');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: SizedBox(
            height: 40,
            width: 50,
            child: Center(
              child: Text(
                'SPPDC',
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
            height: 35,
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              initialValue: sppdcStr,
              decoration: Themes.formStyle(sppdcStr != ''
                  ? sppdcStr + ' (ketik untuk ubah teks)'
                  : 'Masukkan no SPPDC'),
              keyboardType: TextInputType.name,
              onChanged: (value) => ref
                  .read(updateFrameNotifierProvider.notifier)
                  .changeNoSPPDC(noSPPDCStr: value, index: index),
              validator: (_) => ref
                  .read(updateFrameNotifierProvider)
                  .updateFrameList[index]
                  .sppdc
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
