import 'package:agung_opr/application/cranny/view/cranny_scaffold.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CrannyPage extends ConsumerWidget {
  const CrannyPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [CrannyScaffold(), LoadingOverlay(isLoading: false)],
    );
  }
}
