import 'package:agung_opr/application/assign_unit/view/assign_unit_scaffold.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssignUnitPage extends ConsumerWidget {
  const AssignUnitPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [AssignUnitScaffold(), LoadingOverlay(isLoading: false)],
    );
  }
}
