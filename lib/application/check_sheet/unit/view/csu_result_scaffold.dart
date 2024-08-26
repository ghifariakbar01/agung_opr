import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/mode/mode_state.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/common/widgets/v_appbar.dart';
import 'package:agung_opr/common/widgets/v_button.dart';
import 'package:agung_opr/shared/providers.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/csu_result.dart';
import 'csu_result_item.dart';
import 'widget/csu_result_info.dart';

class CSUResultScaffold extends ConsumerWidget {
  const CSUResultScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frame =
        ref.watch(csuFrameNotifierProvider.select((value) => value.frame));

    final csuResultList = ref
        .watch(csuFrameNotifierProvider.select((value) => value.csuResultList));

    return KeyboardDismissOnTap(
      child: SafeArea(
        child: Scaffold(
            appBar: VAppBar(context, 'Check Sheet Unit'),
            bottomNavigationBar: VBottomNav(),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Palette.yellow,
                        ),
                        child: Center(
                          child: Text(
                            '${frame.frame ?? ''}',
                            style: Themes.customColor(
                                FontWeight.bold, 16, Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CSUResultInfo(),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 2, color: Palette.primaryColor)),
                          child: VButton(
                              label: 'BUAT CHECKSHEET',
                              onPressed: () async {
                                ref
                                    .read(
                                        updateCSUFrameNotifierProvider.notifier)
                                    .changeFillInitial();
                                ref
                                    .read(modeNotifierProvider.notifier)
                                    .changeModeAplikasi(
                                        ModeState.checkSheetUnit());

                                // PASS -1 AS EMPTY
                                await context.pushNamed(
                                  extra: -1,
                                  RouteNames.CSUNewNameRoute,
                                );
                              })),
                      SizedBox(
                        height: 8,
                      ),

                      // Existing CSU List
                      if (csuResultList.isNotEmpty) ...[
                        for (int index = 0;
                            index < csuResultList.length;
                            index++) ...[
                          AbsorbPointer(
                            absorbing: !ref
                                .read(updateCSUFrameNotifierProvider.notifier)
                                .isEditable(
                                    csuResult: csuResultList[index],
                                    csuResultItems: csuResultList),
                            child: TextButton(
                              onPressed: () async {
                                final CSUResult csuItem = csuResultList[index];

                                ref
                                    .read(
                                        updateCSUFrameNotifierProvider.notifier)
                                    .changeFillWithValue(csuResult: csuItem);

                                await context.pushNamed(
                                  extra: csuItem.id,
                                  RouteNames.CSUNewNameRoute,
                                );
                              },
                              child: CSUResultItem(
                                index: index,
                              ),
                              style: ButtonStyle(
                                  padding:
                                      WidgetStatePropertyAll(EdgeInsets.zero)),
                            ),
                          ),
                        ]
                      ]
                    ],
                  ),
                ))),
      ),
    );
  }
}

class VBottomNav extends ConsumerWidget {
  const VBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 63,
      width: MediaQuery.of(context).size.width,
      color: Palette.greySecondary,
      child: TextButton(
        style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
        onPressed: () {
          ref.read(csuFrameNotifierProvider.notifier).changeCSUResultList([]);
          context.pop();
        },
        child: Row(
          children: [
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 24,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'BACK',
              style: Themes.customColor(FontWeight.bold, 14, Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
