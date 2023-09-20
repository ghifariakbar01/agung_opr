import 'package:agung_opr/application/widgets/v_appbar.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../routes/route_names.dart';
import '../../update_frame/shared/update_frame_providers.dart';

import 'frame_search_without.dart';
import 'unit_item.dart';

class UnitScaffold extends ConsumerWidget {
  const UnitScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frameList = ref.watch(frameNotifierProvider);
    final isSearching = ref.watch(
        frameSearchNotifierProvider.select((value) => value.isSearching));

    final isLoading =
        ref.watch(frameNotifierProvider.select((value) => value.isProcessing));

    return KeyboardDismissOnTap(
      child: Scaffold(
          appBar: VAppBar(
            'Check Sheet Unit',
          ),
          bottomNavigationBar: Container(
            height: 63,
            width: MediaQuery.of(context).size.width,
            color: Palette.greySecondary,
            child: TextButton(
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero)),
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
                    style:
                        Themes.customColor(FontWeight.bold, 14, Colors.black),
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
                        Flexible(flex: 5, child: FrameSearchWithoutSPK()),
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
                                                .scanBarcode(
                                                    "#65B689",
                                                    "Cancel",
                                                    false,
                                                    ScanMode.DEFAULT);

                                        if (frame.isNotEmpty && frame != '-1') {
                                          ref
                                              .read(frameSearchNotifierProvider
                                                  .notifier)
                                              .changeSearchText(frame);

                                          await ref
                                              .read(frameNotifierProvider
                                                  .notifier)
                                              .searchFrameListOFFLINE(
                                                  idSPK: '0', frame: frame);
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
                        TextButton(
                          style: ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.zero)),
                          onPressed: () async {
                            Map<String, dynamic> frameMap =
                                frameList.frameList[index].toJson();

                            await context.pushNamed(RouteNames.CSUListNameRoute,
                                extra: frameMap);
                          },
                          child: UnitItem(
                            nomorUnit:
                                frameList.frameList[index].idUnit.toString(),
                            namaFrame: frameList.frameList[index].frame ?? '-',
                            namaCust: frameList.frameList[index].custnm ?? '-',
                            tglDibuat:
                                'TGL DIBUAT: ${frameList.frameList[index].tglDibuat ?? '-'}',
                          ),
                        ),
                      ]
                    ]
                  ],
                ),
              ))),
    );
  }
}
