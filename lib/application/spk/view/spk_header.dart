import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../style/style.dart';
import '../shared/spk_providers.dart';
import 'spk_search.dart';

class SpkHeader extends HookConsumerWidget {
  const SpkHeader(this.hideDone, {super.key});

  final ValueNotifier<bool> hideDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Flexible(flex: 4, child: SPKSearch()),
        Flexible(
            flex: 1,
            child: InkWell(
              onTap: () => hideDone.value = !hideDone.value,
              child: Ink(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Column(
                    children: [
                      if (!hideDone.value) ...[
                        Flexible(
                            flex: 0,
                            child: Text(
                              'Spk Blm',
                              textAlign: TextAlign.center,
                              style: Themes.customColor(
                                  FontWeight.bold, 9, Colors.black),
                            )),
                        Flexible(
                            flex: 1,
                            child: Icon(
                              Icons.no_sim_sharp,
                              size: 35,
                            ))
                      ] else ...[
                        Flexible(
                            flex: 0,
                            child: Text(
                              'Spk Done',
                              textAlign: TextAlign.center,
                              style: Themes.customColor(
                                  FontWeight.bold, 9, Colors.black),
                            )),
                        Flexible(
                            flex: 1,
                            child: Icon(
                              Icons.sim_card_download_sharp,
                              size: 35,
                            ))
                      ]
                    ],
                  ),
                ),
              ),
            )),
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
                      'NO.SPK',
                      textAlign: TextAlign.center,
                      style:
                          Themes.customColor(FontWeight.bold, 9, Colors.black),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: InkWell(
                      onTap: () async {
                        log('NOSPK SCAN INIT');
                        String? noSPK = await FlutterBarcodeScanner.scanBarcode(
                            "#65B689", "Cancel", false, ScanMode.DEFAULT);

                        log('NOSPK SCAN $noSPK');

                        if (noSPK.isNotEmpty && noSPK != '-1') {
                          ref
                              .read(spkSearchNotifierProvider.notifier)
                              .changeSearchText(noSPK);

                          await ref
                              .read(spkNotifierProvider.notifier)
                              .searchSPKListOFFLINE(search: noSPK);

                          log('NOSPK SCAN 2 $noSPK');
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
    );
  }
}
