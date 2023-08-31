import 'dart:developer';

import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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

    final sppdcController = ref.watch(updateFrameNotifierProvider.select(
        (value) => value.sppdcTextController.length < index ||
                value.sppdcTextController.isEmpty
            ? TextEditingController()
            : value.sppdcTextController[index]));

    final sppdcStr = sppdc.getOrLeave('');

    final modeApp = ref.watch(modeNotifierProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: Center(
            child: Text(
              'SPPDC',
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
              controller: sppdcController,
              decoration: Themes.formStyle(
                  sppdcStr != ''
                      ? sppdcStr + ' (ketik untuk ubah teks)'
                      : 'Masukkan no SPPDC',
                  icon: InkWell(
                      onTap: () async {
                        String? sppdc = await FlutterBarcodeScanner.scanBarcode(
                            "#65B689", "Cancel", false, ScanMode.DEFAULT);

                        log('sppdc $sppdc');

                        if (sppdc.isNotEmpty && sppdc != '-1') {
                          sppdcController.text = sppdc;

                          ref
                              .read(updateFrameNotifierProvider.notifier)
                              .changeNoSPPDC(noSPPDCStr: sppdc, index: index);
                        }
                      },
                      child: Ink(
                        child: Icon(
                          Icons.qr_code_2,
                          color: Colors.black,
                        ),
                      ))),
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
