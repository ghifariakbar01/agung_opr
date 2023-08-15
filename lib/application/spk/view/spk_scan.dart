import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../widgets/v_appbar.dart';

class SPKScan extends ConsumerWidget {
  const SPKScan();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: VAppBar(
        'Scan NO. SPK',
        backgroundColor: Colors.grey.withOpacity(0.1),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          MobileScanner(
            // fit: BoxFit.contain,
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.normal,
              facing: CameraFacing.back,
              torchEnabled: true,
            ),
            placeholderBuilder: (p0, p1) =>
                Center(child: CircularProgressIndicator()),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  context.pop(barcode.rawValue.toString());
                }
              }
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                width: 2,
                color: Palette.primaryColor,
              )),
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}
