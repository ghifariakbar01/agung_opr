import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/loading_overlay.dart';
import 'spk_scaffold.dart';

class SPKPage extends ConsumerWidget {
  const SPKPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [SPKScaffold(), LoadingOverlay(isLoading: false)],
    );
  }
}
