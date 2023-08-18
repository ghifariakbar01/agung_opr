import 'package:agung_opr/application/update_frame/frame.dart';
import 'package:agung_opr/application/update_frame/shared/update_frame_providers.dart';
import 'package:agung_opr/domain/value_objects_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';
import '../../../../style/style.dart';

class FormUpdateFrame extends ConsumerWidget {
  const FormUpdateFrame({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frame = ref.watch(updateFrameNotifierProvider.select((value) =>
        value.updateFrameList.length < index
            ? FrameUnit('')
            : value.updateFrameList[index].frame));

    final frameController = ref.watch(updateFrameNotifierProvider.select(
        (value) => value.frameTextController.length < index ||
                value.frameTextController.isEmpty
            ? TextEditingController()
            : value.frameTextController[index]));

    final frameStr = frame.getOrLeave('');

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
            height: 65,
            width: MediaQuery.of(context).size.width,
            child: IgnorePointer(
              ignoring: modeApp.maybeWhen(
                  checkSheetUnit: () => true, orElse: () => false),
              child: TextFormField(
                controller: frameController,
                decoration: Themes.formStyle(
                    frameStr != ''
                        ? frameStr + ' (ketik untuk ubah teks)'
                        : 'Masukkan frame',
                    icon: InkWell(
                        onTap: () async {
                          String? frame =
                              await FlutterBarcodeScanner.scanBarcode(
                                  "#65B689", "Cancel", false, ScanMode.DEFAULT);

                          if (frame.isNotEmpty) {
                            frameController.text = frame;

                            ref
                                .read(updateFrameNotifierProvider.notifier)
                                .changeFrame(frameStr: frame, index: index);
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
          ),
        )
      ],
    );
  }
}
