import 'package:agung_opr/application/widgets/v_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';
import '../../../../style/style.dart';
import '../../../mode/mode_state.dart';
import '../../../widgets/v_appbar.dart';
import '../shared/csu_providers.dart';
import 'form/csu_new_form.dart';
import 'widget/csu_kelengkapan.dart';

class CSUNewScaffold extends ConsumerWidget {
  const CSUNewScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDefect = ref.watch(updateCSUFrameNotifierProvider.select((value) =>
        value.updateFrameList.isNG.firstWhere(
            (checkSheet) => checkSheet == true,
            orElse: () => false)));

    final _frame = ref.watch(csuFrameNotifierProvider).frame;

    return WillPopScope(
      onWillPop: () {
        ModeState modeState = ref.read(modeNotifierProvider);
        modeState.maybeWhen(
          orElse: () {},
          checkSheetUnit: () => ref
              .read(modeNotifierProvider.notifier)
              .changeModeAplikasi(ModeState.checkSheetUnit()),
        );
        return Future.value(true);
      },
      child: KeyboardDismissOnTap(
          child: SafeArea(
        child: Scaffold(
            appBar: VAppBar(context, 'Check Sheet Unit New'),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CSUNewForm(_frame),
                      SizedBox(
                        height: 8,
                      ),
                      CSUKelengkapan(),
                      VButton(
                          label: 'DEFECT',
                          color: Palette.red,
                          isEnabled: isDefect,
                          onPressed: () async {
                            await ref
                                .read(updateCSUFrameNotifierProvider.notifier)
                                .saveQuery();
                          }),
                      VButton(
                          label: 'NO DEFECT',
                          isEnabled: !isDefect,
                          onPressed: () async {
                            await ref
                                .read(updateCSUFrameNotifierProvider.notifier)
                                .saveQuery();
                          }),
                    ],
                  ),
                ))),
      )),
    );
  }
}
