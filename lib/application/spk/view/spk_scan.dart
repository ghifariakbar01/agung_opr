
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';


// final qrControllerProvider = Provider((ref) => MobileScannerController(
//       autoStart: true,
//       detectionSpeed: DetectionSpeed.normal,
//       detectionTimeoutMs: 250,
//       facing: CameraFacing.back,
//       torchEnabled: true,
//     ));

class SPKScan extends ConsumerWidget {
  const SPKScan();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final qrController = ref.watch(qrControllerProvider);

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   if (await qrController.isStarting) {
    //     // await qrController.dispose();
    //     await qrController.start();
    //     debugger(message: 'called');
    //   }
    // });

    return Container();
  }
}
