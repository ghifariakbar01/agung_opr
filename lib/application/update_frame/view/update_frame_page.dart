import 'package:agung_opr/application/update_frame/view/update_frame_scaffold.dart';
import 'package:agung_opr/application/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdateFramePage extends ConsumerWidget {
  const UpdateFramePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [UpdateFrameScaffold(), LoadingOverlay(isLoading: false)],
    );
  }
}
