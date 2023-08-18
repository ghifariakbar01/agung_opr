import 'dart:developer';

import 'package:agung_opr/application/widgets/v_appbar.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/providers.dart';
import '../shared/update_frame_providers.dart';
import 'frame_search.dart';
import 'update_frame_item_scaffold.dart';

class UpdateFrameScaffold extends ConsumerWidget {
  const UpdateFrameScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modeApp = ref.watch(modeNotifierProvider);
    final frameList = ref.watch(frameNotifierProvider);
    final isSearching = ref.watch(
        frameSearchNotifierProvider.select((value) => value.isSearching));

    final isLoading =
        ref.watch(frameNotifierProvider.select((value) => value.isProcessing));

    return Scaffold(
        appBar: VAppBar(
          '${modeApp.maybeWhen(
            updateFrameDummy: () => 'Update Frame Dummy',
            checkSheetUnit: () => 'Check Sheet Unit',
            orElse: () {},
          )}',
        ),
        bottomNavigationBar: Container(
          height: 63,
          width: MediaQuery.of(context).size.width,
          color: Palette.greySecondary,
          child: TextButton(
            style:
                ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
            onPressed: () => context.pop(),
            child: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'BACK',
                  style: Themes.customColor(FontWeight.bold, 14, Colors.black),
                )
              ],
            ),
          ),
        ),
        // drawer: Drawer(),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(flex: 5, child: FrameSearch()),
                      Flexible(
                          flex: 1,
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 0,
                                  child: Text(
                                    'FRAME',
                                    textAlign: TextAlign.center,
                                    style: Themes.customColor(
                                        FontWeight.bold, 9, Colors.black),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () async {
                                      String? frame =
                                          await FlutterBarcodeScanner
                                              .scanBarcode("#65B689", "Cancel",
                                                  false, ScanMode.DEFAULT);

                                      if (frame.isNotEmpty) {
                                        ref
                                            .read(frameSearchNotifierProvider
                                                .notifier)
                                            .changeSearchText(frame);

                                        final idSPK = ref.read(
                                            updateFrameNotifierProvider.select(
                                                (value) => value.idSPK));

                                        await ref
                                            .read(
                                                frameNotifierProvider.notifier)
                                            .searchFrameListOFFLINE(
                                                idSPK: '$idSPK', frame: frame);
                                      }
                                    },
                                    child: Ink(
                                      child: Icon(
                                        Icons.qr_code_2,
                                        size: 40,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  if (!isSearching || !isLoading) ...[
                    for (int index = 0;
                        index < frameList.frameList.length;
                        index++) ...[
                      UpdateFrameItemScaffold(
                        index,
                      ),
                    ]
                  ]
                ],
              ),
            )));
  }
}
