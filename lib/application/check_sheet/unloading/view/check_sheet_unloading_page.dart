import 'package:agung_opr/common/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'check_sheet_unloading_scaffold.dart';

class CheckSheetUnloadingPage extends ConsumerWidget {
  const CheckSheetUnloadingPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        CheckSheetUnloadingScaffold(),
        LoadingOverlay(isLoading: false)
      ],
    );
  }
}
