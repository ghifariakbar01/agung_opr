import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';
import '../../../../style/style.dart';
import '../../shared/update_frame_providers.dart';

class FormUpdateSPPDC extends ConsumerWidget {
  const FormUpdateSPPDC({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sppdc = ref.watch(updateFrameNotifierProvider.select((value) =>
        value.updateFrameList.length < index
            ? SPPDC('')
            : value.updateFrameList[index].sppdc));

    final sppdcStr = sppdc.getOrLeave('');

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
                'SPPDC',
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
              ignoring: modeApp.maybeWhen(
                  checkSheetUnit: () => true, orElse: () => false),
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
          ),
        )
      ],
    );
  }
}
