import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/widgets/v_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../style/style.dart';
import '../../../widgets/v_appbar.dart';
import '../shared/csu_providers.dart';
import 'form/csu_new_form.dart';
import 'widget/csu_item_form.dart';

class CSUNewScaffold extends ConsumerWidget {
  const CSUNewScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final csuItems = ref
        .watch(csuItemsFrameNotifierProvider.select((value) => value.csuItems));

    final isDefect = ref.watch(updateCSUFrameNotifierProvider.select((value) =>
        value.updateFrameList.isNG.firstWhere(
            (checkSheet) => checkSheet == true,
            orElse: () => false)));

    return KeyboardDismissOnTap(
        child: Scaffold(
            appBar: VAppBar('Check Sheet Unit New'),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CSUNewForm(),

                      SizedBox(
                        height: 8,
                      ),

                      // KELENGKAPAN
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Palette.primaryColor, width: 2)),
                        padding: EdgeInsets.all(4),
                        child: Column(
                          children: [
                            Text(
                              'KELENGKAPAN',
                              style: Themes.customColor(
                                  FontWeight.bold, 16, Palette.primaryColor),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            for (int index = 0;
                                index < csuItems.length;
                                index++) ...[
                              CheckSheetUnitItemForm(
                                  id: csuItems[index].id,
                                  index: index,
                                  instruction:
                                      '${csuItems[index].id}. ${csuItems[index].ind} (${csuItems[index].eng})')
                            ]
                          ],
                        ),
                      ),

                      VButton(
                          label: 'DEFECT',
                          color: Palette.red,
                          isEnabled: isDefect,
                          onPressed: () async {
                            await ref
                                .read(updateCSUFrameNotifierProvider.notifier)
                                .saveQueryNG();

                            await ref
                                .read(updateCSUFrameNotifierProvider.notifier)
                                .saveQueryOK();
                          }),
                      VButton(
                          label: 'NO DEFECT',
                          isEnabled: !isDefect,
                          onPressed: () async {
                            await ref
                                .read(updateCSUFrameNotifierProvider.notifier)
                                .saveQueryOK();
                          }),
                    ],
                  ),
                ))));
  }
}
