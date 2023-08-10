import 'package:agung_opr/application/check_sheet/unit/shared/csu_providers.dart';
import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/application/widgets/v_appbar.dart';
import 'package:agung_opr/application/widgets/v_button.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/providers.dart';
import 'csu_result_item.dart';
import 'csu_trips_item.dart';
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
      child: Scaffold(
          appBar: VAppBar('Check Sheet Unit'),
          bottomNavigationBar: VBottomNav(),
          drawer: Drawer(),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Header
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
                        child: Column(
                          children: [
                            VButton(label: 'PILIH GATE', onPressed: () {}),
                            VButton(
                                label: 'BUAT CHECKSHEET',
                                onPressed: () => context
                                    .pushNamed(RouteNames.CSUNewNameRoute)),
                          ],
                        )),

                    for (int index = 0;
                        index < csuResultList.length;
                        index++) ...[
                      CSUResultItem(
                        index: index,
                      ),
                    ]
                  ],
                ),
              ))),
    );
  }
}

class VBottomNav extends StatelessWidget {
  const VBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      width: MediaQuery.of(context).size.width,
      color: Palette.greySecondary,
      child: TextButton(
        style: ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
        onPressed: () => context.pop(),
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
