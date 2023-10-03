import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/value_objects_copy.dart';
import '../shared/update_frame_providers.dart';
import 'update_frame_item_middle.dart';

class UpdateFrameItemScaffold extends ConsumerStatefulWidget {
  const UpdateFrameItemScaffold(this.index);

  final int index;

  @override
  ConsumerState<UpdateFrameItemScaffold> createState() =>
      _UpdateFrameItemScaffoldState();
}

class _UpdateFrameItemScaffoldState
    extends ConsumerState<UpdateFrameItemScaffold> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => ref
        .read(updateFrameNotifierProvider.notifier)
        .changeIndex(index: widget.index));
  }

  @override
  Widget build(BuildContext context) {
    // FORM LISTENER
    ref.listen<FrameUnit>(
        updateFrameNotifierProvider
            .select((value) => value.updateFrameList[widget.index].frame),
        (prev, __) =>
            ref.read(updateFrameNotifierProvider.notifier).checkIfValid());

    ref.listen<SPPDC>(
        updateFrameNotifierProvider.select((value) => value.sppdc),
        (prev, __) =>
            ref.read(updateFrameNotifierProvider.notifier).checkIfValid());

    //

    return Stack(
      children: [
        UpdateFrameItemMiddle(widget.index),
        // LoadingOverlay(isLoading: isLoading)
      ],
    );
  }
}
