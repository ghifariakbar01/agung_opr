import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/loading_overlay.dart';
import '../providers/gate_providers.dart';
import 'gate_scaffold.dart';

class GatePage extends ConsumerStatefulWidget {
  const GatePage(this.isCSU);

  final bool isCSU;

  @override
  ConsumerState<GatePage> createState() => _GatePageState();
}

class _GatePageState extends ConsumerState<GatePage> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      gateNotifierProvider.select((value) => value.isProcessing),
    );

    return Stack(
      children: [
        GateScaffold(),
        LoadingOverlay(isLoading: isLoading),
      ],
    );
  }
}
