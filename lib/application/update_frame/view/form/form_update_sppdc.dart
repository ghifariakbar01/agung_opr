import 'dart:developer';

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
    final sppdc =
        ref.watch(updateFrameNotifierProvider.select((value) => value.sppdc));

    final sppdcController = ref.watch(updateFrameNotifierProvider
        .select((value) => value.sjkbTextController));

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
                              .changeNoSPPDC(noSPPDCStr: sppdc);
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
                  .changeNoSPPDC(noSPPDCStr: value),
              validator: (_) =>
                  ref.read(updateFrameNotifierProvider).sppdc.value.fold(
                        (f) => f.maybeMap(
                          empty: (_) => 'Silahkan Masukan no SPPDC disini',
                          orElse: () => 'invalid',
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
