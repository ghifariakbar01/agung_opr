import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'check_sheet_loading_scaffold.dart';

class CheckSheetLoadingPage extends ConsumerWidget {
  const CheckSheetLoadingPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [CheckSheetLoadingScaffold(), LoadingOverlay(isLoading: false)],
    );
  }
}
