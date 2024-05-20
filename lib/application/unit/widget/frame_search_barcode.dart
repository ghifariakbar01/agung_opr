import 'package:agung_opr/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../style/style.dart';
import '../../update_frame/shared/update_frame_providers.dart';

class FrameSearchBarcode extends ConsumerWidget {
  const FrameSearchBarcode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(isOfflineStateProvider);

    return SizedBox(
      height: 50,
      width: 70,
      child: Column(
        children: [
          Flexible(
            flex: 0,
            child: Text(
              '${isOffline ? '(OFFLINE)' : 'FRAME'}',
              textAlign: TextAlign.center,
              style: Themes.customColor(FontWeight.bold, 9, Colors.black),
            ),
          ),
          Flexible(
            flex: 2,
            child: InkWell(
              onTap: () async {
                String? frame = await FlutterBarcodeScanner.scanBarcode(
                    "#65B689", "Cancel", false, ScanMode.DEFAULT);

                if (frame.isNotEmpty && frame != '-1') {
                  ref
                      .read(frameSearchNotifierProvider.notifier)
                      .changeSearchText(frame);

                  if (!isOffline) {
                    await ref
                        .read(frameNotifierProvider.notifier)
                        .searchFrameListWithoutSPK(frame: frame);
                  } else {
                    await ref
                        .read(frameNotifierProvider.notifier)
                        .searchFrameListOFFLINE(idSPK: '0', frame: frame);
                  }
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
    );
  }
}
